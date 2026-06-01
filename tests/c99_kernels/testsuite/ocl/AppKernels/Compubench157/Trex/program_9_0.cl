__kernel
__attribute__((reqd_work_group_size(WGSIZE, 1, 1)))
void segscanTraverse_INT(__global int* restrict data, __global const int* restrict head, __global int* restrict dsum, __global int* restrict hsum, const int n, volatile __local int* sData, volatile __local int* sHead)
{
	const int wiGId = get_global_id(0);
	const int wiLId = get_local_id(0);

	// read input data into local memory
	sData[wiLId] = (wiGId < n) ? data[wiGId] : 0;
	sHead[wiLId] = (wiGId < n) ? head[wiGId] : 0;
	barrier(CLK_LOCAL_MEM_FENCE);

	#pragma unroll
	for(int offset = 1; offset < WGSIZE; offset *= 2)
	{
		int td, th;
		if(wiLId >= offset)
		{
			td = sData[wiLId - offset];
			th = sHead[wiLId - offset];
		}
		barrier(CLK_LOCAL_MEM_FENCE);

		if(wiLId >= offset)
 		{
			sData[wiLId] += sHead[wiLId] ? 0 : td;
			sHead[wiLId] |= th;
 		}
 		barrier(CLK_LOCAL_MEM_FENCE);
	}

	// write block sum result to global mem
	if(wiLId == 0)
	{
		dsum[get_group_id(0)] = sData[WGSIZE-1];
		hsum[get_group_id(0)] = sHead[WGSIZE-1];
	}

	// write result for this block to global mem
	if(wiGId < n)
	{
		data[wiGId] = sData[wiLId];
	}
}

__kernel
__attribute__((reqd_work_group_size(WGSIZE, 1, 1)))
void segscanBlockAdd_INT(__global const int* restrict input, __global const int* restrict head, __global int* restrict output, const int n, volatile __local int* sHead)
{
	int wiIdG = get_global_id(0);
	int wiIdL = get_local_id(0);
	int wgId = get_group_id(0);

	// read input data into local memory
	__local int sData[1];
	if(wiIdL == 0)
	{
		sData[0] = (wgId > 0) ? input[wgId-1] : 0;
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
		output[wiIdG] += sData[0];
	}
}

__kernel
void segscanTraverseTask_INT(__global int* restrict data, __global const int* restrict head, const int n)
{
	int curr = data[0];

	for(int i = 1; i < n; ++i)
	{
		if(head[i] == 1)
		{
			curr = data[i];
		}
		else
		{
			curr += data[i];
			data[i] = curr;
		}
	}
}


// buildOptions=-cl-fast-relaxed-math -D WGSIZE=128
// RUN: %occ-cli %s --cl-options="-I%cwd -I%S -cl-fast-relaxed-math -D WGSIZE=128" %cfg_path --cl-device=%cl_device 2>&1
