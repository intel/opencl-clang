// Copyright [2011] [Geist Software Labs Inc.]
//
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
// http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.

#define BITS 4
#define RADIX (1<<BITS)
#define WARPSIZE 32
#define BLOCKSIZE 256

__kernel void clBlockSort(__global uint* keyIn,
						  __global uint* keyOut,
						  __global uint* valIn,
						  __global uint* valOut,
						  uint startbit, __global uint* blockScan, __global uint* blockOffset, uint size)
{
	int globalId = get_global_id(0);
	int threadid = get_local_id(0);
	int totalBlocks = get_num_groups(0);
	int blockid = get_group_id(0);

	__local uint key[BLOCKSIZE];
	__local uint val[BLOCKSIZE];

	key[threadid] = 0xFFFFFFFF;
	val[threadid] = 0xFFFFFFFF;
	if (globalId < size)
	{
		key[threadid] = keyIn[globalId];
		val[threadid] = valIn[globalId];
	}
	barrier(CLK_LOCAL_MEM_FENCE);

	// reorder block
	__local uint prefixSum[BLOCKSIZE];
	for(uint bit = startbit; bit < (startbit+BITS); bit++)
	{
		uint curKey = key[threadid];
		uint curVal = val[threadid];
		uint lsb = !((curKey >> bit) & 0x1);
		prefixSum[threadid] = lsb;
		barrier(CLK_LOCAL_MEM_FENCE);
		if (threadid == BLOCKSIZE - 1)
		{
			for (int i=1; i<BLOCKSIZE; i++)
			{
				prefixSum[i] += prefixSum[i-1];
			}
		}
		barrier(CLK_LOCAL_MEM_FENCE);
		uint address = lsb ? prefixSum[threadid]-1: prefixSum[BLOCKSIZE-1] - prefixSum[threadid] + threadid;
		key[address] = curKey;
		val[address] = curVal;
		barrier(CLK_LOCAL_MEM_FENCE);
	}

	if (globalId < size)
	{
		keyOut[globalId] = key[threadid];
		valOut[globalId] = val[threadid];
	}
	barrier(CLK_LOCAL_MEM_FENCE);


	// compute block histograms
	__local uint offset[RADIX];
	if (threadid < RADIX)
	{
		offset[threadid] = 0;
	}
	key[threadid] = (key[threadid] >> startbit) & 0xF;
	barrier(CLK_LOCAL_MEM_FENCE);

	if(threadid > 0 && key[threadid] != key[threadid - 1])
	{
		offset[key[threadid]] = threadid;
	}
	barrier(CLK_LOCAL_MEM_FENCE);

	if (threadid < RADIX)
	{
		blockOffset[blockid*RADIX+threadid] = offset[threadid];
	}
	barrier(CLK_LOCAL_MEM_FENCE);

	if(threadid > 0 && key[threadid] != key[threadid - 1])
	{
		offset[key[threadid - 1]] = threadid - offset[key[threadid - 1]];
	}
    barrier(CLK_LOCAL_MEM_FENCE);

	if(threadid == BLOCKSIZE - 1)
	{
		offset[key[BLOCKSIZE - 1]] = BLOCKSIZE - offset[key[BLOCKSIZE - 1]];
	}
    barrier(CLK_LOCAL_MEM_FENCE);

	if (threadid < RADIX)
	{
		blockScan[threadid*totalBlocks+blockid] = offset[threadid];
	}

}

__kernel void clBlockScan(__global uint4* blockScan, __global uint* scanSum, uint size)
{
	int globalId = get_global_id(0);
	int threadid = get_local_id(0);
	int blockid = get_group_id(0);

	uint4 value4 = 0;
	if (globalId < size)
	{
		value4 = blockScan[globalId];
	}

	__local uint prefixSum[BLOCKSIZE];

	uint4 sum;
	sum.x = value4.x;
 	sum.y = sum.x + value4.y;
 	sum.z = sum.y + value4.z;
 	sum.w = sum.z + value4.w;
	prefixSum[threadid] = sum.w;
    barrier(CLK_LOCAL_MEM_FENCE);

	if (threadid == BLOCKSIZE - 1)
	{
		for (int i=1; i<BLOCKSIZE; i++)
		{
			prefixSum[i] += prefixSum[i-1];
		}
	}
    barrier(CLK_LOCAL_MEM_FENCE);

	uint count = prefixSum[threadid] - sum.w;
	if (globalId < size)
	{
		uint4 result;
		result.x = count;
		result.y = count + sum.x;
		result.z = count + sum.y;
		result.w = count + sum.z;
		blockScan[globalId] = result;
	}
    barrier(CLK_LOCAL_MEM_FENCE);

	if (threadid == BLOCKSIZE-1)
	{
		scanSum[blockid] = count + sum.w; // exclusive -> inclusive
	}
}

__kernel void clBlockPrefix(__global uint4* blockScan, __global uint* blockSum, uint size)
{
	int globalId = get_global_id(0);
	int threadid = get_local_id(0);
	int blockid = get_group_id(0);

	__local uint prefixSum[BLOCKSIZE];

	prefixSum[threadid] = blockSum[threadid];
	barrier(CLK_LOCAL_MEM_FENCE);

	if (threadid == BLOCKSIZE - 1)
	{
		for (int i=1; i<BLOCKSIZE; i++)
		{
			prefixSum[i] += prefixSum[i-1];
		}
	}
	barrier(CLK_LOCAL_MEM_FENCE);

	if (blockid > 0 && globalId < size)
	{
		blockScan[globalId] = blockScan[globalId] + prefixSum[blockid-1];
	}
}

__kernel void clReorder(__global uint* keyIn,
					    __global uint* keyOut,
						__global uint* valIn,
						__global uint* valOut,
					    __global uint* blockScan, __global uint* offsets, uint startbit, uint size)
{
	int globalId = get_global_id(0);
	int threadid = get_local_id(0);
	int blockid = get_group_id(0);
	int totalBlocks = get_num_groups(0);

    __local uint blockOffset[RADIX];
    __local uint totalOffset[RADIX];

	if (threadid < RADIX)
	{
		totalOffset[threadid] = blockScan[threadid*totalBlocks + blockid];
		blockOffset[threadid] = offsets[blockid*RADIX + threadid];
	}
	barrier(CLK_LOCAL_MEM_FENCE);

	if (globalId >= size)
	{
		return;
	}

	uint key = keyIn[globalId];
	uint val = valIn[globalId];
	uint radix = (key >> startbit) & 0xF;
	uint index = totalOffset[radix] + threadid - blockOffset[radix];

	keyOut[index] = key;
	valOut[index] = val;
}


// buildOptions=
// RUN: %occ-cli %s --cl-options="-I%cwd -I%S " %cfg_path --cl-device=%cl_device 2>&1
