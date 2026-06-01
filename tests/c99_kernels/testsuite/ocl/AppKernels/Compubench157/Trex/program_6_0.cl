__kernel
void radixKeyWrite(__global const int2* restrict data, __global int* restrict keys, const int bitselect, const int n)
{
	int wiIdG = get_global_id(0);

	if(wiIdG < n)
		keys[wiIdG] = !(bitselect & data[wiIdG].s1);
}

__kernel
void radixOffsetCalc(__global int* restrict offsets, __global const int* restrict keys, __global const int* restrict totalfalses, const int n)
{
	int wiIdG = get_global_id(0);

	if( wiIdG < n && keys[wiIdG] == 0 )
	{
		offsets[wiIdG] = wiIdG - offsets[wiIdG] + totalfalses[0];
	}
}

__kernel
void radixScatter(__global const int2* restrict data0, __global int2* restrict data1, __global const int* restrict offsets, const int n)
{
	int wiIdG = get_global_id(0);

	if(wiIdG < n)
		data1[ offsets[wiIdG] ] = data0[ wiIdG ];
}

__kernel
__attribute__((reqd_work_group_size(RADIXATOMICSEQWG, 1, 1)))
void radixBinning16(__global const int2* restrict data0, __global int2* restrict data1, const int bitselect, const int bitshift, const int n, __global int* restrict gOffsets, __global int* restrict gBucketStartIndices)
{
	int wiGId = get_global_id(0);
	int wiLId = get_local_id(0);
	int wgId = get_group_id(0);
	int wgNum = get_num_groups(0);

	volatile __local int sOffsets[16];
	if(wiLId < 16)
	{
		sOffsets[wiLId] = 0;
	}
	//barrier(CLK_LOCAL_MEM_FENCE);

	int bucketId = (wiGId < n) ? ( (data0[wiGId].s1 & bitselect) >> bitshift ) : 15;
	int indexInBucket = atomic_inc( sOffsets+bucketId );
	//barrier(CLK_LOCAL_MEM_FENCE);

	volatile __local int sBucketStartIndices[16];
	if(wiLId < 16)
	{
		sBucketStartIndices[wiLId] = sOffsets[wiLId];

		if( wiLId >= 1 ) sBucketStartIndices[wiLId] = sBucketStartIndices[wiLId - 1] + sBucketStartIndices[wiLId];
		if( wiLId >= 2 ) sBucketStartIndices[wiLId] = sBucketStartIndices[wiLId - 2] + sBucketStartIndices[wiLId];
		if( wiLId >= 4 ) sBucketStartIndices[wiLId] = sBucketStartIndices[wiLId - 4] + sBucketStartIndices[wiLId];
		if( wiLId >= 8 ) sBucketStartIndices[wiLId] = sBucketStartIndices[wiLId - 8] + sBucketStartIndices[wiLId];

		sBucketStartIndices[wiLId] -= sOffsets[wiLId];

		gOffsets[wiLId*wgNum + wgId] = sOffsets[wiLId];
		gBucketStartIndices[16*wgId + wiLId] = sBucketStartIndices[wiLId];
	}
	//barrier(CLK_LOCAL_MEM_FENCE);

	if(wiGId < n)
	{
		data1[ wgId*RADIXATOMICSEQWG + indexInBucket + sBucketStartIndices[bucketId] ] = data0[wiGId];
	}
}

__kernel
__attribute__((reqd_work_group_size(RADIXATOMICSEQWG, 1, 1)))
void radixScatter16(__global const int2* restrict data1, __global int2* restrict data0, const int bitselect, const int bitshift, const int n, __global const int* restrict gOffsets, __global const int* restrict gBucketStartIndices)
{
	int wiGId = get_global_id(0);
	int wiLId = get_local_id(0);
	int wgId = get_group_id(0);
	int wgNum = get_num_groups(0);

	if(wiGId < n)
	{
		int binId = (data1[wiGId].s1 & bitselect) >> bitshift;
		data0[  gOffsets[binId*wgNum + wgId] + (wiLId - gBucketStartIndices[16*wgId + binId]) ] = data1[ wiGId ];
	}
}

#define WGSIZE 128

__kernel
__attribute__((reqd_work_group_size(WGSIZE, 1, 1)))
void radixCount16(__global const int2* restrict data0, const int bitselect, const int bitshift, const int n, __global int* restrict gGCounts)
{
	int wiGId = get_global_id(0);
	int wiLId = get_local_id(0);
	int wgId = get_group_id(0);
	int wgNum = get_num_groups(0);

	__local int sGCounts[16];
	if(wiLId < 16)
	{
		sGCounts[wiLId] = 0;
	}
	barrier(CLK_LOCAL_MEM_FENCE);

	int bucketId = (wiGId < n) ? ( (data0[wiGId].s1 & bitselect) >> bitshift ) : 15;
	atomic_inc( sGCounts+bucketId );
	barrier(CLK_LOCAL_MEM_FENCE);

	if(wiLId < 16)
	{
		gGCounts[wiLId*wgNum + wgId] = sGCounts[wiLId];
	}
}

__kernel
__attribute__((reqd_work_group_size(WGSIZE, 1, 1)))
__kernel void radixSplit16(__global const int2* restrict data0, __global int2* restrict data1, const int bitselect, const int bitshift, const int n, __global const int* restrict gGCounts)
{
	int wiGId = get_global_id(0);
	int wiLId = get_local_id(0);
	int wgId = get_group_id(0);
	int wgNum = get_num_groups(0);

	__local int sOffsets[WGSIZE*16];
	for(int i = 0; i < 16; ++i)
	{
		sOffsets[i*WGSIZE + wiLId] = 0;
	}

	int bucketId = (wiGId < n) ? ( (data0[wiGId].s1 & bitselect) >> bitshift ) : 15;
	sOffsets[bucketId*WGSIZE + wiLId] = 1;
	barrier(CLK_LOCAL_MEM_FENCE);

	for(int i = 0; i < 16; ++i)
	{
		int x = sOffsets[WGSIZE*i + wiLId];

		for(int offset = 1; offset < WGSIZE; offset *= 2)
		{
			int t;
			if(wiLId >= offset)
			{
				t = sOffsets[i*WGSIZE + wiLId - offset];
			}
			barrier(CLK_LOCAL_MEM_FENCE);

			if(wiLId >= offset)
 			{
				sOffsets[i*WGSIZE + wiLId] += t;
 			}
 			barrier(CLK_LOCAL_MEM_FENCE);
		}

		sOffsets[i*WGSIZE + wiLId] -= x;
		barrier(CLK_LOCAL_MEM_FENCE);
	}

	if(wiGId < n)
	{
		data1[ gGCounts[bucketId*wgNum + wgId] + sOffsets[WGSIZE*bucketId + wiLId] ] = data0[wiGId];
	}
}

// atomic ordering test

__kernel
__kernel void atomicTest(__global int* restrict data)
{
	__local int myCounter;
	if(get_local_id(0) == 0)
		myCounter = 0;

	int x = atomic_inc( &myCounter );

	data[get_global_id(0)] = x;
}


int segscanThreadGroup(volatile __local int* sData, volatile __local int* sHead, const int wiLId)
{
	const int lane = wiLId & 32-1;

	#pragma unroll
	for(int i = 0; i < 5; ++i)
	{
        int offset = 1 << i;

		if(lane >= offset)
		{
			sData[wiLId] += sHead[wiLId] ? 0 : sData[wiLId - offset];
			sHead[wiLId] |= sHead[wiLId - offset];
		}
	}

	return sData[wiLId];
}


__kernel
void scanBlock_INT(__global int* restrict data, __global const int* restrict head, __global int* restrict dsum, __global int* restrict hsum, const int n, volatile __local int* sData, volatile __local int* sHead)
{
	const int wiGId = get_global_id(0);
	const int wiLId = get_local_id(0);

	const int threadbunchId = wiLId >> 5;
	const int threadbunchFirst = threadbunchId << 5;
	const int threadbunchLast = threadbunchFirst + 31;

	// read input data into local memory
	sData[wiLId] = (wiGId < n) ? data[wiGId] : 0;
	sHead[wiLId] = (wiGId < n) ? head[wiGId] : 1;
	barrier(CLK_LOCAL_MEM_FENCE);

	int val = segscanThreadGroup(sData, sHead, wiLId);
	barrier(CLK_LOCAL_MEM_FENCE);

	int threadbunchAccum = sHead[wiLId] == 0;
	barrier(CLK_LOCAL_MEM_FENCE);

	if( wiLId == threadbunchLast )
	{
		sData[threadbunchId] = sData[threadbunchLast];
		sHead[threadbunchId] = sHead[threadbunchLast];
	}
	barrier(CLK_LOCAL_MEM_FENCE);

	if( threadbunchId == 0 )
		segscanThreadGroup(sData, sHead, wiLId);
	barrier(CLK_LOCAL_MEM_FENCE);

	if( threadbunchId != 0 && threadbunchAccum)
		val += sData[threadbunchId-1];
	barrier(CLK_LOCAL_MEM_FENCE);

	// write block sum result to global mem
	if(wiLId == 0)
	{
		dsum[get_group_id(0)] = sData[4-1];
		hsum[get_group_id(0)] = sHead[4-1];
	}

	// write result for this block to global mem
	if(wiGId < n)
	{
		data[wiGId] = val;
	}
}

__kernel
void scanBlockAdd_INT(__global const int* restrict input, __global const int* restrict head, __global int* restrict output, const int n, volatile __local int* sHead)
{
	int wiIdG = get_global_id(0);
	int wiIdL = get_local_id(0);
	int wgId = get_group_id(0);

	// read input data into local memory
	__local int sdata[1];
	if(wiIdL == 0)
	{
		sdata[0] = (wgId > 0) ? input[wgId-1] : 0;
	}
	barrier(CLK_LOCAL_MEM_FENCE);

	for(int offset = get_local_size(0) / 2; offset > 0; offset >>= 1)
	{
		if(wiIdL < offset)
		{
			sHead[wiIdL] |= sHead[wiIdL + offset];
		}
		barrier(CLK_LOCAL_MEM_FENCE);
	}

	if( sHead == 0 || wiIdG < n)
	{
		output[wiIdG] += sdata[0];
	}
}


// buildOptions=-cl-fast-relaxed-math -D RADIXATOMICSEQWG=64
// RUN: %occ-cli %s --cl-options="-I%cwd -I%S -cl-fast-relaxed-math -D RADIXATOMICSEQWG=64" %cfg_path --cl-device=%cl_device 2>&1
