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
#pragma OPENCL EXTENSION cl_khr_global_int32_base_atomics : enable
#pragma OPENCL EXTENSION cl_khr_local_int32_base_atomics : enable
#pragma OPENCL EXTENSION cl_khr_global_int32_extended_atomics : enable
#pragma OPENCL EXTENSION cl_khr_local_int32_extended_atomics : enable

//
// AABB
//
typedef struct
{
	float4 bbMin;
	float4 bbMax;
	int flag;
} AABB;


#define WARPSIZE 32
#define BLOCKSIZE 8

__kernel void clAABB(__global float4* vertex, __global AABB* aabb, int size)
{
	int g = get_global_id(0);
	int threadid = get_local_id(0);

	float4 bMin = (float4)( MAXFLOAT, MAXFLOAT,MAXFLOAT,0);
	float4 bMax = (float4)(-MAXFLOAT,-MAXFLOAT,-MAXFLOAT,0);
	for (int i=0; i<BLOCKSIZE; i++)
	{
		float4 value = vertex[min(g*BLOCKSIZE+i, size-1)];
		bMin = min(bMin, value);
		bMax = max(bMax, value);
	}

	__local float4 wMin[WARPSIZE];
	__local float4 wMax[WARPSIZE];
	wMin[threadid] = bMin;
	wMax[threadid] = bMax;
	barrier(CLK_LOCAL_MEM_FENCE);

	wMin[threadid] = min(wMin[threadid], wMin[threadid^1]);
	wMin[threadid] = min(wMin[threadid], wMin[threadid^2]);
	wMin[threadid] = min(wMin[threadid], wMin[threadid^4]);
	wMin[threadid] = min(wMin[threadid], wMin[threadid^8]);
 	wMax[threadid] = max(wMax[threadid], wMax[threadid^1]);
	wMax[threadid] = max(wMax[threadid], wMax[threadid^2]);
	wMax[threadid] = max(wMax[threadid], wMax[threadid^4]);
	wMax[threadid] = max(wMax[threadid], wMax[threadid^8]);
	barrier(CLK_LOCAL_MEM_FENCE);

    if ((threadid & 16) == 0)
	{
        wMin[threadid] = min(wMin[threadid], wMin[threadid ^ 16]),
		wMax[threadid] = max(wMax[threadid], wMax[threadid ^ 16]);
	}

	if (threadid==0)
	{
		while (atom_cmpxchg(&aabb[0].flag,0,1)==1);
		aabb[0].bbMin = min(aabb[0].bbMin, wMin[0]);
		aabb[0].bbMax = max(aabb[0].bbMax, wMax[0]);
		atom_cmpxchg(&aabb[0].flag,1,0);
	}
}

//
// Morton Code
//

uint code(uint x)
{
	x = (x | (x << 16)) & 0x030000FF;
	x = (x | (x <<  8)) & 0x0300F00F;
	x = (x | (x <<  4)) & 0x030C30C3;
	x = (x | (x <<  2)) & 0x09249249;
	return x;
}

__kernel void clMorton(__global uint* index, __global float4* vertex, __global uint* key, __global uint* val, __global AABB* aabb)
{
	int g = get_global_id(0);

	float4 v0 = vertex[index[g*3+0]];
	float4 v1 = vertex[index[g*3+1]];
	float4 v2 = vertex[index[g*3+2]];

	float4 normal = ((v0+v1+v2)/3 - aabb[0].bbMin)/(aabb[0].bbMax - aabb[0].bbMin);

	key[g] = code(normal.x*0x3FF) | (code(normal.y*0x3FF)<<1) | (code(normal.z*0x3FF)<<2);
	val[g] = g;
}

//
// Create BVH
//

typedef struct
{
	float4 bbMin;
	float4 bbMax;
	int left;
	int right;
	uint bit;
	uint trav;
} BVHNode;

__kernel void clCreateNodes(__global uint* mortonKey, __global uint* mortonVal, __global BVHNode* bvh)
{
	int globalid = get_global_id(0);

	bvh[globalid].left = -1;
	bvh[globalid].right = -1;
	bvh[globalid].bit = 0;
	bvh[globalid].trav = 0;
	bvh[globalid].bbMin = (float4)( MAXFLOAT, MAXFLOAT,MAXFLOAT,0);
	bvh[globalid].bbMax = (float4)(-MAXFLOAT,-MAXFLOAT,-MAXFLOAT,0);

	uint key0 = mortonKey[globalid];
	uint key1 = mortonKey[globalid+1];

	for (int i=29; i>=0; i--)
	{
		uint bit0 = (key0 >> i) & 0x1;
		uint bit1 = (key1 >> i) & 0x1;
		if (bit0 != bit1)
		{
			bvh[globalid].bit = i;
			break;
		}
	}
}

__kernel void clLinkNodes(__global uint* mortonKey, __global BVHNode* bvh, __global uint* bvhRoot)
{
	int globalid = get_global_id(0);

	uchar bit = bvh[globalid].bit;

	//scan left
	int left = -1;
	for (int i=globalid-1; i>=0; i--)
	{
		if (bvh[i].bit > bit)
		{
			left = i;
			break;
		}
	}

	//scan right
	int right = -1;
	for (int i=globalid+1; i<get_global_size(0); i++)
	{
		if (bvh[i].bit > bit)
		{
			right = i;
			break;
		}
	}

	if (left != -1 || right != -1)
	{
		if (right == -1)
		{
			bvh[left].right = globalid;
		}
		else if (left == -1)
		{
			bvh[right].left = globalid;
		}
		else
		{
			if (bvh[left].bit < bvh[right].bit)
			{
				bvh[left].right = globalid;
			}
			else
			{
				bvh[right].left = globalid;
			}
		}
	}
	else
	{
		*bvhRoot = globalid;
	}
}

__kernel void clCreateLeaves(__global uint* mortonVal, __global BVHNode* bvh)
{
	int globalid = get_global_id(0);
	int leafstart = get_global_size(0)-1;

	bvh[leafstart+globalid].bit = mortonVal[globalid];
	bvh[leafstart+globalid].left = 0;
	bvh[leafstart+globalid].right = 0;
	bvh[leafstart+globalid].trav = 0;

	if (globalid == 0)
	{
		bvh[globalid].left = leafstart+globalid;
 		return;
	}
	if (globalid == leafstart)
	{
		bvh[leafstart-1].right = leafstart+globalid;
 		return;
	}

	uint bit = 	bvh[globalid].bit;

	if (bvh[globalid].left == -1)
	{
		bvh[globalid].left = globalid + leafstart;
	}
	else if (bvh[globalid-1].right == -1)
	{
		bvh[globalid-1].right = globalid + leafstart;
	}
}

__kernel void clComputeAABBs(__global uint* index, __global float4* vertex, __global BVHNode* bvh, __global int* bvhRoot)
{
	int globalid = get_global_id(0);

	uint stack[128];
	uint top = 0;

	stack[top] = *bvhRoot;
	while (1)
	{
		if (stack[top] >= globalid)
		{
			// turn left
			stack[top+1] = bvh[stack[top]].left;
		}
		else
		{
			// turn right
			stack[top+1] = bvh[stack[top]].right;
		}

		top++;

		if (bvh[stack[top]].left == bvh[stack[top]].right)
		{
			// is leaf
			int triangle = bvh[stack[top]].bit;
			float4 v0 = vertex[index[triangle*3+0]];
			float4 v1 = vertex[index[triangle*3+1]];
			float4 v2 = vertex[index[triangle*3+2]];
			float4 bbMin = (float4)( MAXFLOAT, MAXFLOAT,MAXFLOAT,0);
			float4 bbMax = (float4)(-MAXFLOAT,-MAXFLOAT,-MAXFLOAT,0);
			bbMin = min(bbMin, v0);
			bbMin = min(bbMin, v1);
			bbMin = min(bbMin, v2);
			bbMax = max(bbMax, v0);
			bbMax = max(bbMax, v1);
			bbMax = max(bbMax, v2);
			bvh[stack[top]].bbMin = bbMin;
			bvh[stack[top]].bbMax = bbMax;
			break;
		}
	}

	while (top--)
	{
		if (atom_cmpxchg(&bvh[stack[top]].trav,0,1)==0)
		{
			bvh[stack[top]].trav = 2;
			return;
		};

		while (atom_cmpxchg(&bvh[stack[top]].trav,2,3)==1);

		uint left = bvh[stack[top]].left;
		uint right = bvh[stack[top]].right;
		bvh[stack[top]].bbMin = bvh[left].bbMin;
		bvh[stack[top]].bbMax = bvh[left].bbMax;
		bvh[stack[top]].bbMin = min(bvh[stack[top]].bbMin, bvh[right].bbMin);
		bvh[stack[top]].bbMax = max(bvh[stack[top]].bbMax, bvh[right].bbMax);
	}

}


// buildOptions=
// RUN: %occ-cli %s --cl-options="-I%cwd -I%S " %cfg_path --cl-device=%cl_device 2>&1
