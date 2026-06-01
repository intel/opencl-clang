/*
 * PROPRIETARY INFORMATION.  This software is proprietary to
 * Side Effects Software Inc., and is not to be reproduced,
 * transmitted, or disclosed in any way without written permission.
 *
 * Produced by:
 *  Side Effects Software Inc
 *  123 Front Street West, Suite 1401
 *  Toronto, Ontario
 *  Canada   M5J 2M2
 *  416-504-9876
 *
 * NAME:    reduce.cl ( CE Library, OpenCL)
 *
 * COMMENTS:
 */

// #pragma OPENCL EXTENSION cl_amd_printf : enable

// Reduce ops
#define OP_SUM 0
#define OP_MIN 1
#define OP_MAX 2

// Map ops
#define MAP_IDENT   0
#define MAP_SQR     1
#define MAP_ABS     2

// Accumulate in double precision unless not available.
#ifdef NO_DOUBLE_SUPPORT
typedef float accumtype;
#else
#pragma OPENCL EXTENSION cl_khr_fp64: enable
typedef double accumtype;
#endif

accumtype reduce(accumtype a, accumtype b)
{
#if REDUCEOP == OP_SUM
    return a + b;
#elif REDUCEOP == OP_MIN
    return fmin(a, b);
#elif REDUCEOP == OP_MAX
    return fmax(a, b);
#endif
    return a;
}

accumtype identity()
{
#if REDUCEOP == OP_SUM
    return 0;
#elif REDUCEOP == OP_MIN
    return FLT_MAX;
#elif REDUCEOP == OP_MAX
    return FLT_MIN;
#endif
    return 0;
}

accumtype map(accumtype a)
{
#if MAPOP == MAP_IDENT
    return a;
#elif MAPOP == MAP_SQR
    return a * a;
#elif MAPOP == MAP_ABS
    return fabs(a);
#endif
    return a;
}

void
reduceLocal(__local accumtype *ldata, size_t lidx, uint groupsize)
{
    for(size_t offset = groupsize / 2; offset > 0; offset >>= 1)
    {
        if (lidx < offset)
        {
            ldata[lidx] = reduce(ldata[lidx], ldata[lidx + offset]);
        }
        barrier(CLK_LOCAL_MEM_FENCE);
    }
}

__kernel void
reduceGrid(__global accumtype *out, __global const float *in,
           __local accumtype *ldata, uint groupsize,
           uint nx, uint ny, uint nz,
           uint offset, uint xstride, uint ystride, uint zstride)
{
    // There's a workitem for each x voxel in the workgroup, so skip that
    // many x-voxels each iteration.
    size_t xinc = get_local_size(0);
    size_t lidx = get_local_id(0) + get_local_id(1) * xinc +
                  get_local_id(2) * xinc * get_local_size(1);

    size_t j = get_global_id(1);
    size_t k = get_global_id(2);

    // Map and reduce the grid values into local memory by stepping along
    // the x axis as much as possible for each workgroup.  This keeps much
    // of the reduction serial and sets up the later stages of reduction.
    accumtype acc = identity();
    if (j < ny && k < nz)
    {
        // Get pointer to start of x-row.
        __global const float *base = in + (offset + j * ystride + k * zstride);
        // Step through row
        for (size_t i = get_global_id(0); i < nx; i += xinc)
            acc = reduce(acc, map(base[i * xstride]));
    }
    ldata[lidx] = acc;
    barrier(CLK_LOCAL_MEM_FENCE);

    // Now reduce (but don't map) the values in local memory.
    reduceLocal(ldata, lidx, groupsize);

    // Store the output, with a reduced value per workgroup.
    if (lidx == 0)
    {
        // There's only ever one x-dimension group, so ignore it when
        // calculating unique group id.
        size_t gid = get_group_id(1) + get_group_id(2) * get_num_groups(1);
        out[gid] = ldata[0];
    }
}

__kernel void
reduceFlat(__global accumtype *out, __global const accumtype *in,
           __local accumtype *ldata, uint groupsize,
           uint n)
{
    size_t lidx = get_local_id(0), i = lidx;

    // Reduce the flat input array into local memory. Note this does not map
    // the input values, assuming it's only used as the second stage of a
    // two-stage reduction.
    accumtype acc = identity();
    while (i < n)
    {
        acc = reduce(acc, in[i]);
        i += groupsize;
    }
    ldata[lidx] = acc;
    barrier(CLK_LOCAL_MEM_FENCE);

    // Now reduce (but don't map) the values in local memory.
    reduceLocal(ldata, lidx, groupsize);

    // Store the single output.
    if (lidx == 0)
    {
        *out = ldata[0];
    }
}



// buildOptions=-D NO_DOUBLE_SUPPORT -I testsuite/ocl/AppKernels/Houdini
// RUN: %occ-cli %s --cl-options="-I%cwd -I%S -D NO_DOUBLE_SUPPORT -I testsuite/ocl/AppKernels/Houdini" %cfg_path --cl-device=%cl_device 2>&1
