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


#define WARPSIZE 32
#define BLOCKSIZE 8

//
// Morton Code
//

__kernel void clMorton(__global float2* vertex, __global uint* key, __global uint* val)
{
	int g = get_global_id(0);

	float2 c = 0.5f*(vertex[g*2+0]+vertex[g*2+1]);
	uint2 center = (uint2)(c.x, c.y);

	center.x &= 0x0000ffff;
	center.y &= 0x0000ffff;
	center.x |= ( center.x << 8 );
	center.y |= ( center.y << 8 );
	center.x &= 0x00ff00ff;
	center.y &= 0x00ff00ff;
	center.x |= ( center.x << 4 );
	center.y |= ( center.y << 4 );
	center.x &= 0x0f0f0f0f;
	center.y &= 0x0f0f0f0f;
	center.x |= ( center.x << 2 );
	center.y |= ( center.y << 2 );
	center.x &= 0x33333333;
	center.y &= 0x33333333;
	center.x |= ( center.x << 1 );
	center.y |= ( center.y << 1 );
	center.x &= 0x55555555;
	center.y &= 0x55555555;

	key[g] = center.x | ( center.y << 1 );
	val[g] = g;
}

//
// Create BVH
//

typedef struct
{
	float2 bbMin;
	float2 bbMax;
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
	bvh[globalid].bbMin = MAXFLOAT;
	bvh[globalid].bbMax = -MAXFLOAT;

	uint key0 = mortonKey[globalid];
	uint key1 = mortonKey[globalid+1];

	for (int i=31; i>=0; i--)
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

__kernel void clComputeAABBs(__global float2* vertex, __global BVHNode* bvh, __global int* bvhRoot)
{
	uint globalid = get_global_id(0);

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
			int line = bvh[stack[top]].bit;
			float2 v0 = vertex[line*2+0];
			float2 v1 = vertex[line*2+1];
			float2 bbMin = MAXFLOAT;
			float2 bbMax = -MAXFLOAT;
			bbMin = min(bbMin, v0);
			bbMin = min(bbMin, v1);
			bbMax = max(bbMax, v0);
			bbMax = max(bbMax, v1);
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
