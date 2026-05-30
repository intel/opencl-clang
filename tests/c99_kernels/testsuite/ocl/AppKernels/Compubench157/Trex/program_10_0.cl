typedef struct
{
	float4	min, max;
} CLAABB;

__kernel
__attribute__((reqd_work_group_size(WGSIZE, 1, 1)))
void segscanTraverse_AABB(__global CLAABB* restrict data, __global const int* restrict head, __global CLAABB* restrict dsum, __global int* restrict hsum, const int n, volatile __local float4* sDataMin, volatile __local float4* sDataMax, volatile __local int* sHead)
{
	const int wiGId = get_global_id(0);
	const int wiLId = get_local_id(0);

	// read input data into local memory
	sDataMin[wiLId] = (wiGId < n) ? data[wiGId].min : (float4)( FLT_MAX, FLT_MAX, FLT_MAX, 1.0f);
	sDataMax[wiLId] = (wiGId < n) ? data[wiGId].max : (float4)(-FLT_MAX,-FLT_MAX,-FLT_MAX, 1.0f);
	sHead[wiLId] = (wiGId < n) ? head[wiGId] : 0;
	barrier(CLK_LOCAL_MEM_FENCE);

	#pragma unroll
	for(int offset = 1; offset < WGSIZE; offset *= 2)
	{
		CLAABB td;
		int th;
		if(wiLId >= offset)
		{
			td.min = sDataMin[wiLId - offset];
			td.max = sDataMax[wiLId - offset];
			th = sHead[wiLId - offset];
		}
		barrier(CLK_LOCAL_MEM_FENCE);

		if(wiLId >= offset)
 		{
			sDataMin[wiLId] = sHead[wiLId] ? sDataMin[wiLId] : min(sDataMin[wiLId], td.min);
			sDataMax[wiLId] = sHead[wiLId] ? sDataMax[wiLId] : max(sDataMax[wiLId], td.max);
			sHead[wiLId] |= th;
 		}
 		barrier(CLK_LOCAL_MEM_FENCE);
	}

	// write block sum result to global mem
	if(wiLId == 0)
	{
		dsum[get_group_id(0)].min = sDataMin[WGSIZE-1];
		dsum[get_group_id(0)].max = sDataMax[WGSIZE-1];
		hsum[get_group_id(0)] = sHead[WGSIZE-1];
	}

	// write result for this block to global mem
	if(wiGId < n)
	{
		data[wiGId].min = sDataMin[wiLId];
		data[wiGId].max = sDataMax[wiLId];
	}
}

__kernel
__attribute__((reqd_work_group_size(WGSIZE, 1, 1)))
void segscanBlockAdd_AABB(__global const CLAABB* restrict input, __global const int* restrict head, __global CLAABB* restrict output, const int n, volatile __local int* sHead)
{
	int wiIdG = get_global_id(0);
	int wiIdL = get_local_id(0);
	int wgId = get_group_id(0);

	// read input data into local memory
	__local CLAABB sData[1];
	if(wiIdL == 0)
	{
		sData[0].min = (wgId > 0) ? input[wgId-1].min : (float4)( FLT_MAX, FLT_MAX, FLT_MAX, 1.0f);
		sData[0].max = (wgId > 0) ? input[wgId-1].max : (float4)(-FLT_MAX,-FLT_MAX,-FLT_MAX, 1.0f);
	}
	barrier(CLK_LOCAL_MEM_FENCE);

	// read input data into local memory
	sHead[wiIdL] = (wiIdG < n) ? head[wiIdG] : 0;
	barrier(CLK_LOCAL_MEM_FENCE);

	#pragma unroll
	for(int offset = 1; offset < WGSIZE; offset *= 2)
	{
		int t;
		if(wiIdL >= offset)
		{
			t = sHead[wiIdL - offset];
		}
		barrier(CLK_LOCAL_MEM_FENCE);

		if(wiIdL >= offset)
 		{
			sHead[wiIdL] |= t;
 		}
 		barrier(CLK_LOCAL_MEM_FENCE);
	}

	if( sHead[wiIdL] == 0 && wiIdG < n)
	{
		output[wiIdG].min = min(output[wiIdG].min, sData[0].min);
		output[wiIdG].max = max(output[wiIdG].max, sData[0].max);
	}
}

__kernel
void segscanTraverseTask_AABB(__global CLAABB* restrict data, __global const int* restrict head, const int n)
{
	CLAABB curr = data[0];

	for(int i = 1; i < n; ++i)
	{
		if(head[i] == 1)
		{
			curr = data[i];
		}
		else
		{
			curr.min = min(curr.min, data[i].min);
			curr.max = max(curr.max, data[i].max);

			data[i] = curr;
		}
	}
}


// buildOptions=-cl-fast-relaxed-math -D WGSIZE=128
// RUN: %occ-cli %s --cl-options="-I%cwd -I%S -cl-fast-relaxed-math -D WGSIZE=128" %cfg_path --cl-device=%cl_device 2>&1
