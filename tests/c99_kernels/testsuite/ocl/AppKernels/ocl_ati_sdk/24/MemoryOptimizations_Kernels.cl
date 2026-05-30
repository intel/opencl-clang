

__kernel void copy1DFastPath(__global float *input, __global float *output)
{
	int gid = get_global_id(0);
	output[gid]=input[gid];
	return;
}

#pragma OPENCL EXTENSION cl_khr_global_int32_base_atomics : enable

__kernel void copy1DCompletePath(__global float *input, __global float *output)
{
	int gid = get_global_id(0);
	if(gid < 0)
		atom_add((__global int*)output, 1);
	output[gid]=input[gid];
	return;
}

#define WIDTH 1024
#define DATA_TYPE float
#define A(y,x) A[(y)* WIDTH +(x)]
#define C(y,x) C[(y)* WIDTH +(x)]
__kernel void copy2Dfloat(__global DATA_TYPE *A, __global DATA_TYPE *C)
{
	int idx = get_global_id(0);
	int idy = get_global_id(1);
	C(idy,idx) = A(idy,idx);
}


#define DATA_TYPE float4
__kernel void copy2Dfloat4(__global DATA_TYPE *A, __global DATA_TYPE *C)
{
	int idx = get_global_id(0);
	int idy = get_global_id(1);
	C(idy,idx) = A(idy,idx);
}

__kernel void copy1Dfloat4(__global float4 *input, __global float4 *output)
{
	int gid = get_global_id(0);
	output[gid]=input[gid];
	return;
}

//Shift by 16
__kernel void NoCoal(__global float* input, __global float* output)
{
	int gid = get_global_id(0) - 1;
	if((get_local_id(0) & 0xf) == 0)
		gid += 16;
	output[gid] = input[gid];
}

//Messed up access pattern
__kernel void Split(__global float* input, __global float* output)
{
	int gid = get_global_id(0);
	if((gid & 0x1) == 0)
	{
		gid = (gid & !63) + 62 - get_local_id(0);
	}
	output[gid] = input[gid];
}




// buildOptions=
// RUN: %occ-cli %s --cl-options="-I%cwd -I%S " %cfg_path --cl-device=%cl_device 2>&1
