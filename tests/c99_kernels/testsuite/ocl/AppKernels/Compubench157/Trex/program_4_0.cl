typedef struct
{
	float4	min, max;
} CLAABB;

__kernel
void reduction_INT(__global const int* restrict input,  __global int* restrict output, const int n, __local int* sdata)
{
	int wiIdG = get_global_id(0);
	int wiIdL = get_local_id(0);

	// load data into local memory
	sdata[wiIdL] = (wiIdG < n) ? input[wiIdG] : 0;

    barrier(CLK_LOCAL_MEM_FENCE);

    for(int offset = get_local_size(0) / 2; offset > 0; offset >>= 1)
	{
		if(wiIdL < offset)
		{
			sdata[wiIdL] += sdata[wiIdL + offset];
		}

		barrier(CLK_LOCAL_MEM_FENCE);
	}

    // save data for this block to global mem
    if(wiIdL == 0)
	{
		output[get_group_id(0)] = sdata[0];
	}
}

__kernel
void reduction_AABB(__global const CLAABB* restrict input, __global CLAABB* restrict output, const int n, __local float4* sdataMin, __local float4* sdataMax)
{
	int wiIdG = get_global_id(0);
	int wiIdL = get_local_id(0);

	// load data into local memory
	sdataMin[wiIdL] = (wiIdG < n) ? input[wiIdG].min : (float4)( FLT_MAX, FLT_MAX, FLT_MAX, 1.0f);
	sdataMax[wiIdL] = (wiIdG < n) ? input[wiIdG].max : (float4)(-FLT_MAX,-FLT_MAX,-FLT_MAX, 1.0f);
	barrier(CLK_LOCAL_MEM_FENCE);

	for(int offset = get_local_size(0) / 2; offset > 0; offset >>= 1)
	{
		if(wiIdL < offset)
		{
			sdataMin[wiIdL] = min( sdataMin[wiIdL], sdataMin[wiIdL + offset] );
			sdataMax[wiIdL] = max( sdataMax[wiIdL], sdataMax[wiIdL + offset] );
		}

		barrier(CLK_LOCAL_MEM_FENCE);
	}

	// save data for this block to global mem
	if(wiIdL == 0)
	{
		output[get_group_id(0)].min = sdataMin[0];
		output[get_group_id(0)].max = sdataMax[0];
	}
}

__kernel
void reductionTask_AABB(__global const CLAABB* restrict input, __global CLAABB* restrict output, const int n)
{
	CLAABB curr = input[0];

	for(int i = 1; i < n; ++i)
	{
		curr.min = min( curr.min, input[i].min );
		curr.max = max( curr.max, input[i].max );
	}

	output[0] = curr;
}


// buildOptions=-cl-fast-relaxed-math
// RUN: %occ-cli %s --cl-options="-I%cwd -I%S -cl-fast-relaxed-math" %cfg_path --cl-device=%cl_device 2>&1
