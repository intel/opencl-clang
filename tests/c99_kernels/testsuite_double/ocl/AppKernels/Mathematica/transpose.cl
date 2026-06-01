/*
 * Copyright 1993-2009 NVIDIA Corporation.  All rights reserved.
 *
 * NVIDIA Corporation and its licensors retain all intellectual property and
 * proprietary rights in and to this software and related documentation.
 * Any use, reproduction, disclosure, or distribution of this software
 * and related documentation without an express license agreement from
 * NVIDIA Corporation is strictly prohibited.
 *
 * Please refer to the applicable NVIDIA end user license agreement (EULA)
 * associated with this source code for terms and conditions that govern
 * your use of this NVIDIA software.
 *
 */

/* Matrix transpose with OpenCL
* Device code.
*/

#define BLOCK_DIM 16

#define USING_OPENCL_FUNCTION 1
#define OPENCLLINK_USING_NVIDIA
#define mint long
#define Real_t double
#define USING_DOUBLE_PRECISIONQ 1
#define MAX_ITERATIONS 100


// This kernel is optimized to ensure all global reads and writes are coalesced,
// and to avoid bank conflicts in shared memory.  This kernel is up to 11x faster
// than the naive kernel below.  Note that the shared memory array is sized to
// (BLOCK_DIM+1)*BLOCK_DIM.  This pads each row of the 2D block in shared memory
// so that bank conflicts do not occur when threads address the array column-wise.
__kernel void transpose(__global float *odata, __global float *idata, mint offset, mint width, mint height, __local float* block)
{
	// read the matrix tile into shared memory
	unsigned int xIndex = get_global_id(0);
	unsigned int yIndex = get_global_id(1);

	if((xIndex + offset < width) && (yIndex < height))
	{
		unsigned int index_in = yIndex * width + xIndex + offset;
		block[get_local_id(1)*(BLOCK_DIM+1)+get_local_id(0)] = idata[index_in];
	}

	barrier(CLK_LOCAL_MEM_FENCE);

	// write the transposed matrix tile to global memory
	xIndex = get_group_id(1) * BLOCK_DIM + get_local_id(0);
	yIndex = get_group_id(0) * BLOCK_DIM + get_local_id(1);
	if((xIndex < height) && (yIndex + offset < width))
    {
		unsigned int index_out = yIndex * height + xIndex;
		odata[index_out] = block[get_local_id(0)*(BLOCK_DIM+1)+get_local_id(1)];
	}
}



// This naive transpose kernel suffers from completely non-coalesced writes.
// It can be up to 10x slower than the kernel above for large matrices.
__kernel void transpose_naive(__global float *odata, __global float* idata, mint offset, mint width, mint height)
{
    unsigned int xIndex = get_global_id(0);
    unsigned int yIndex = get_global_id(1);

    if (xIndex + offset < width && yIndex < height)
    {
        unsigned int index_in  = xIndex + offset + width * yIndex;
        unsigned int index_out = yIndex + height * xIndex;
        odata[index_out] = idata[index_in];
    }
}


__kernel void simple_copy(__global float *odata, __global float* idata, mint offset, mint width, mint height)
{
    unsigned int xIndex = get_global_id(0);
    unsigned int yIndex = get_global_id(1);

    if (xIndex + offset < width && yIndex < height)
    {
        unsigned int index_in  = xIndex + offset + width * yIndex;
        odata[index_in] = idata[index_in];
    }
}

__kernel void shared_copy(__global float *odata, __global float *idata, mint offset, mint width, mint height, __local float* block)
{
	// read the matrix tile into shared memory
	unsigned int xIndex = get_global_id(0);
	unsigned int yIndex = get_global_id(1);

    unsigned int index_in = yIndex * width + xIndex + offset;
	if((xIndex + offset< width) && (yIndex < height))
	{
		block[get_local_id(1)*(BLOCK_DIM+1)+get_local_id(0)] = idata[index_in];
	}

	barrier(CLK_LOCAL_MEM_FENCE);

	if((xIndex < height) && (yIndex+ offset < width))
    {
		odata[index_in] = block[get_local_id(1)*(BLOCK_DIM+1)+get_local_id(0)];
	}
}


__kernel void uncoalesced_copy(__global float *odata, __global float* idata, mint offset, mint width, mint height)
{
    unsigned int xIndex = get_global_id(0);
    unsigned int yIndex = get_global_id(1);

    if (xIndex + offset < width && yIndex < height)
    {
        unsigned int index_in  = yIndex + height * (xIndex+ offset);
        odata[index_in] = idata[index_in];
    }
}


// buildOptions=
// RUN: %occ-cli %s --cl-options="-I%cwd -I%S " %cfg_path --cl-device=%cl_device 2>&1
