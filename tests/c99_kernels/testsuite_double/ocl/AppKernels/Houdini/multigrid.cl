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
 * NAME:    multigrid.cl ( CE Library, OpenCL)
 *
 * COMMENTS:
 */

// #pragma OPENCL EXTENSION cl_amd_printf : enable

// Update the boundary cells for the given axis given the boundary modifiers.
__kernel void
updateBoundaries(__global float *grid,
                   uint naxis, uint axisstride,
                   float boundModNeg, float boundAdjModNeg,
                   float boundModPos, float boundAdjModPos,
                   uint offset, uint xstride, uint ystride)
{
    size_t idx0 = offset + get_global_id(0) * xstride +
                           get_global_id(1) * ystride;
    size_t idxn = idx0 + (naxis - 1) * axisstride;

    float val0 =  boundModNeg * grid[idx0] +
                  boundAdjModNeg * grid[idx0 + axisstride];

    float valn =  boundModPos * grid[idxn] +
                  boundAdjModPos * grid[idxn - axisstride];

    // Set ghost cell values.
    grid[idx0 - axisstride] = val0;
    grid[idxn + axisstride] = valn;
}

// Compute res = b - A * x, where A is the Laplacian.
__kernel void
subtractApplyLaplacian(__global const float *b,
                        __global const float *x,
                        __global float *res,
                        float diag,
                        float invdx2, float invdy2, float invdz2,
                        uint offset, uint ystride, uint zstride)
{
    size_t idx = offset + get_global_id(0) + get_global_id(1) * ystride +
              get_global_id(2) * zstride;
    res[idx] = b[idx] - diag * x[idx] +
               invdx2 * (x[idx - 1] + x[idx + 1]) +
               invdy2 * (x[idx - ystride] + x[idx + ystride]) +
               invdz2 * (x[idx - zstride] + x[idx + zstride]);
}

// Compute res = b - A * x, where A is the 2-d Laplacian.
__kernel void
subtractApplyLaplacian2d(__global const float *b,
                        __global const float *x,
                        __global float *res,
                        float diag,
                        float invdx2, float invdy2,
                        uint offset, uint xstride, uint ystride)
{
    size_t idx = offset + get_global_id(0) * xstride +
                          get_global_id(1) * ystride;
    res[idx] = b[idx] - diag * x[idx] +
               invdx2 * (x[idx - xstride] + x[idx + xstride]) +
               invdy2 * (x[idx - ystride] + x[idx + ystride]);
}

// Accumulate in double precision unless not available.
#ifdef NO_DOUBLE_SUPPORT
typedef float accumtype;
#else
#pragma OPENCL EXTENSION cl_khr_fp64: enable
typedef double accumtype;
#endif

// Computes the infinity and 2-norm of the residual that results from b - A * x,
// where A is the Laplacian operator.  Calculating and reducing at the same
// time avoids writing the residual to the grid and reducing twice.
// This is based on reduceGrid from reduce.cl.
__kernel void
computeResidualNorms(__global const float *b,
                     __global const float *x,
                     __global accumtype *norminf,
                     __global accumtype *norm2,
                     float diag,
                     float invdx2, float invdy2, float invdz2,
                     __local accumtype *ldatainf,
                     __local accumtype *ldata2,
                     uint groupsize,
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
    // Start with identity values.
    accumtype accinf = FLT_MIN;
    accumtype acc2 = 0;
    if (j < ny && k < nz)
    {
        // Get index to start of x-row.
        size_t base = offset + j * ystride + k * zstride;
        // Step through row
        for (size_t i = get_global_id(0); i < nx; i += xinc)
        {
            size_t idx = base + i * xstride;
            // Calc residual from applying Laplacian operator.
            float res = b[idx] - diag * x[idx] +
                        invdx2 * (x[idx - xstride] + x[idx + xstride]) +
                        invdy2 * (x[idx - ystride] + x[idx + ystride]) +
                        invdz2 * (x[idx - zstride] + x[idx + zstride]);
            // Map and reduce infinity norm (max of abs).
            accinf = fmax(accinf, fabs((accumtype)res));
            // Map and reduce norm-2 (sum of squares).
            acc2 += (res * res);
        }
    }
    // Store in local memory.
    ldatainf[lidx] = accinf;
    ldata2[lidx] = acc2;
    barrier(CLK_LOCAL_MEM_FENCE);

    // Now reduce (but don't map) the values in local memory.
    for(size_t offset = groupsize / 2; offset > 0; offset >>= 1)
    {
        if (lidx < offset)
        {
            ldatainf[lidx] = fmax(ldatainf[lidx], ldatainf[lidx + offset]);
            ldata2[lidx] += ldata2[lidx + offset];
        }
        barrier(CLK_LOCAL_MEM_FENCE);
    }

    // Store the output, with a reduced value per workgroup.
    if (lidx == 0)
    {
        // There's only ever one x-dimension group, so ignore it when
        // calculating unique group id.
        size_t gid = get_group_id(1) + get_group_id(2) * get_num_groups(1);
        norminf[gid] = ldatainf[0];
        norm2[gid] = ldata2[0];
    }
}


float ghostValue(float mod, float adjMod, float x, float xadj)
{
    return mod * x + adjMod * xadj;
}


// Perform Gauss-Seidel smoothing of the grid, where parity defines whether
// the red or black cycle is being done.
__kernel void
smoothLaplacianGaussSeidel(__global const float *b,
        __global float *x,
        int parity, float omega,
        uint nx, uint ny, uint nz,
        float diag, float invdx2, float invdy2, float invdz2,
        float diagModNegx, float diagModNegy, float diagModNegz,
        float diagModPosx, float diagModPosy, float diagModPosz,
        uint offset, uint ystride, uint zstride)
{
    size_t i = get_global_id(0);
    size_t j = get_global_id(1);
    size_t k = get_global_id(2);

    i *= 2;
    // Increment i as needed to ensure i+j+k matches parity.
    i += select(1, 0, ((j + k) % 2 == parity));
    if (i < nx)
    {
        size_t idx = offset + i + j * ystride + k * zstride;

        float res = b[idx] - diag * x[idx];
        res += invdx2 * (x[idx - 1] + x[idx + 1]);
        res += invdy2 * (x[idx - ystride] + x[idx + ystride]);
        res += invdz2 * (x[idx - zstride] + x[idx + zstride]);

        // Modify diagonal to handle boundary conditions.
        float diagM = diag;
        diagM -= select(0.0f, diagModNegx * invdx2, i == 0);
        diagM -= select(0.0f, diagModPosx * invdx2, i == nx - 1);
        diagM -= select(0.0f, diagModNegy * invdy2, j == 0);
        diagM -= select(0.0f, diagModPosy * invdy2, j == ny - 1);
        diagM -= select(0.0f, diagModNegz * invdz2, k == 0);
        diagM -= select(0.0f, diagModPosz * invdz2, k == nz - 1);

        // Apply over-relaxation.
        x[idx] += omega * res / diagM;
    }
}

// Perform Gauss-Seidel smoothing of the 2-d grid, where parity defines whether
// the red or black cycle is being done.
__kernel void
smoothLaplacianGaussSeidel2d(__global const float *b,
        __global float *x,
        int parity, float omega,
        uint nx, uint ny,
        float diag, float invdx2, float invdy2,
        float diagModNegx, float diagModNegy,
        float diagModPosx, float diagModPosy,
        uint offset, uint xstride, uint ystride)
{
    size_t i = get_global_id(0);
    size_t j = get_global_id(1);
    i *= 2;
    // Increment i as needed to ensure i+j+k matches parity.
    i += select(1, 0, (j % 2 == parity));
    if (i < nx)
    {
        size_t idx = offset + i * xstride + j * ystride;

        float res = b[idx] - diag * x[idx];
        res += invdx2 * (x[idx - xstride] + x[idx + xstride]);
        res += invdy2 * (x[idx - ystride] + x[idx + ystride]);

        // Modify diagonal to handle boundary conditions.
        float diagM = diag;
        diagM -= select(0.0f, diagModNegx * invdx2, i == 0);
        diagM -= select(0.0f, diagModPosx * invdx2, i == nx - 1);
        diagM -= select(0.0f, diagModNegy * invdy2, j == 0);
        diagM -= select(0.0f, diagModPosy * invdy2, j == ny - 1);

        // Apply over-relaxation.
        x[idx] += omega * res / diagM;
    }
}

// Perform several iteraions of Gauss-Seidel smoothing of the grid, assuming
// that the entire grid can fit into one workgroup and local memory.  In this
// case we transfer the entire grid into local memory and use a fairly
// divergent kernel to do the smoothing.  The grid is small enough at this
// point that the kernel is still plenty fast, and decreasing the total number
// of kernel invocations becomes a big win.
__kernel void
smoothLaplacianGaussSeidelSmall(__global const float *b,
            __global float *x,
            __local float *xloc,
            uint niter,
            float omega,
            uint nx, uint ny, uint nz,
            float diag, float invdx2, float invdy2, float invdz2,
            float boundModNegx, float boundModNegy, float boundModNegz,
            float boundModPosx, float boundModPosy, float boundModPosz,
            float boundAdjModNegx, float boundAdjModNegy, float boundAdjModNegz,
            float boundAdjModPosx, float boundAdjModPosy, float boundAdjModPosz,
            float diagModNegx, float diagModNegy, float diagModNegz,
            float diagModPosx, float diagModPosy, float diagModPosz,
            uint offset, uint ystride, uint zstride)
{
    size_t lidx = get_global_id(0);
    size_t lystride = nx;
    size_t lzstride = nx * ny;
    // Calculate 3D indices from 1D local index, x dimension changing fastest
    size_t i = lidx % nx;
    size_t j = (lidx / lystride) % ny;
    size_t k = (lidx / lzstride) % nz;
    // Index into global arrays
    size_t idx = offset + i + j * ystride + k * zstride;
    const float b_ijk = b[idx];

    // Copy x array to local memory
    xloc[lidx] = x[idx];
    barrier(CLK_LOCAL_MEM_FENCE);

    for (uint iter = 0; iter < niter; iter++)
    {
    // Red/black loop.
    for (uint parity=0; parity < 2; parity++)
    {
        if ((i + j + k) % 2 == parity)
        {
            const float x_ijk = xloc[lidx];
            float res = b_ijk - diag * x_ijk;
            float diagM = diag;
            float x_n, x_p;

            if (i == 0)
            {
                x_p = xloc[lidx + 1];
                x_n = ghostValue(boundModNegx, boundAdjModNegx, x_ijk, x_p);
                diagM -= diagModNegx * invdx2;
            }
            else if (i == nx-1)
            {
                x_n = xloc[lidx - 1];
                x_p = ghostValue(boundModPosx, boundAdjModPosx, x_ijk, x_n);
                diagM -= diagModPosx * invdx2;
            }
            else
            {
                x_n = xloc[lidx - 1];
                x_p = xloc[lidx + 1];
            }
            res += invdx2 * (x_n + x_p);

            if (j == 0)
            {
                x_p = xloc[lidx + lystride];
                x_n = ghostValue(boundModNegy, boundAdjModNegy, x_ijk, x_p);
                diagM -= diagModNegy * invdy2;
            }
            else if (j == ny-1)
            {
                x_n = xloc[lidx - lystride];
                x_p = ghostValue(boundModPosy, boundAdjModPosy, x_ijk, x_n);
                diagM -= diagModPosy * invdy2;
            }
            else
            {
                x_n = xloc[lidx - lystride];
                x_p = xloc[lidx + lystride];
            }
            res += invdy2 * (x_n + x_p);

            if (k == 0)
            {
                x_p = xloc[lidx + lzstride];
                x_n = ghostValue(boundModNegz, boundAdjModNegz, x_ijk, x_p);
                diagM -= diagModNegz * invdz2;
            }
            else if (k == nz-1)
            {
                x_n = xloc[lidx - lzstride];
                x_p = ghostValue(boundModPosz, boundAdjModPosz, x_ijk, x_n);
                diagM -= diagModPosz * invdz2;
            }
            else
            {
                x_n = xloc[lidx - lzstride];
                x_p = xloc[lidx + lzstride];
            }
            res += invdz2 * (x_n + x_p);


            xloc[lidx] += omega * res / diagM;
        }
        barrier(CLK_LOCAL_MEM_FENCE);
    }
    }
    // Copy back to global array.
    x[idx] = xloc[lidx];
}

// 2-d version of smoothLaplacianGaussSeidelSmall.
__kernel void
smoothLaplacianGaussSeidelSmall2d(__global const float *b,
            __global float *x,
            __local float *xloc,
            uint niter,
            float omega,
            uint nx, uint ny,
            float diag, float invdx2, float invdy2,
            float boundModNegx, float boundModNegy,
            float boundModPosx, float boundModPosy,
            float boundAdjModNegx, float boundAdjModNegy,
            float boundAdjModPosx, float boundAdjModPosy,
            float diagModNegx, float diagModNegy,
            float diagModPosx, float diagModPosy,
            uint offset, uint xstride, uint ystride)
{
    size_t lidx = get_global_id(0);
    size_t lystride = nx;
    // Calculate 2D indices from 1D local index, x dimension changing fastest
    size_t i = lidx % nx;
    size_t j = (lidx / lystride) % ny;
    // Index into global arrays
    size_t idx = offset + i * xstride + j * ystride;
    const float b_ij = b[idx];

    // Copy x array to local memory
    xloc[lidx] = x[idx];
    barrier(CLK_LOCAL_MEM_FENCE);

    for (uint iter = 0; iter < niter; iter++)
    {
    // Red/black loop.
    for (uint parity=0; parity < 2; parity++)
    {
        if ((i + j) % 2 == parity)
        {
            const float x_ij = xloc[lidx];
            float res = b_ij - diag * x_ij;
            float diagM = diag;
            float x_n, x_p;

            if (i == 0)
            {
                x_p = xloc[lidx + 1];
                x_n = ghostValue(boundModNegx, boundAdjModNegx, x_ij, x_p);
                diagM -= diagModNegx * invdx2;
            }
            else if (i == nx-1)
            {
                x_n = xloc[lidx - 1];
                x_p = ghostValue(boundModPosx, boundAdjModPosx, x_ij, x_n);
                diagM -= diagModPosx * invdx2;
            }
            else
            {
                x_n = xloc[lidx - 1];
                x_p = xloc[lidx + 1];
            }
            res += invdx2 * (x_n + x_p);

            if (j == 0)
            {
                x_p = xloc[lidx + lystride];
                x_n = ghostValue(boundModNegy, boundAdjModNegy, x_ij, x_p);
                diagM -= diagModNegy * invdy2;
            }
            else if (j == ny-1)
            {
                x_n = xloc[lidx - lystride];
                x_p = ghostValue(boundModPosy, boundAdjModPosy, x_ij, x_n);
                diagM -= diagModPosy * invdy2;
            }
            else
            {
                x_n = xloc[lidx - lystride];
                x_p = xloc[lidx + lystride];
            }
            res += invdy2 * (x_n + x_p);

            xloc[lidx] += omega * res / diagM;
        }
        barrier(CLK_LOCAL_MEM_FENCE);
    }
    }
    // Copy back to global array.
    x[idx] = xloc[lidx];
}

// Coarsen kernels work for 2d and 3d. Separate kernels for x, y, and z cases.
__kernel void
coarsenAlongAxisX(__global const float *u,
                    __global float *uh,
                    int parity,
                    uint offset, uint xstride, uint ystride, uint zstride,
                    uint offseth, uint xstrideh, uint ystrideh, uint zstrideh)
{
    size_t i = get_global_id(0);
    size_t j = get_global_id(1);
    size_t k = get_global_id(2);
    size_t i2 = i * 2 + 1;

    // Index into u grid is (i2, j, k)
    size_t uidx = offset + i2 * xstride + j * ystride + k * zstride;
    size_t uhidx = offseth + i * xstride  + j * ystrideh + k * zstrideh;
    if (parity == 0)
        uh[uhidx] = 0.5f * (u[uidx - xstride] + u[uidx]);
    else
        uh[uhidx] = 0.25f * (u[uidx - xstride] + 2 * u[uidx] +
                             u[uidx + xstride]);
}

__kernel void
coarsenAlongAxisY(__global const float *u,
                    __global float *uh,
                    int parity,
                    uint offset, uint xstride, uint ystride, uint zstride,
                    uint offseth, uint xstrideh, uint ystrideh, uint zstrideh)
{
    size_t i = get_global_id(0);
    size_t j = get_global_id(1);
    size_t k = get_global_id(2);
    size_t j2 = j * 2 + 1;

    // Index into u grid is (i, j2, k)
    size_t uidx = offset + i * xstride + j2 * ystride + k * zstride;
    size_t uhidx = offseth + i * xstride  + j * ystrideh + k * zstrideh;
    if (parity == 0)
        uh[uhidx] = 0.5f * (u[uidx - ystride] + u[uidx]);
    else
        uh[uhidx] = 0.25f * (u[uidx - ystride] + 2 * u[uidx] +
                             u[uidx + ystride]);
}

__kernel void
coarsenAlongAxisZ(__global const float *u,
                    __global float *uh,
                    int parity,
                    uint offset, uint xstride, uint ystride, uint zstride,
                    uint offseth, uint xstrideh, uint ystrideh, uint zstrideh)
{
    size_t i = get_global_id(0);
    size_t j = get_global_id(1);
    size_t k = get_global_id(2);
    size_t k2 = k * 2 + 1;

    // Index into u grid is (i, j, k2)
    size_t idx = offset + i * xstride + j * ystride + k2 * zstride;
    size_t idxh = offseth + i * xstride + j * ystrideh + k * zstrideh;
    if (parity == 0)
        uh[idxh] = 0.5f * (u[idx - zstride] + u[idx]);
    else
        uh[idxh] = 0.25f * (u[idx - zstride] + 2 * u[idx] +
                            u[idx + zstride]);
}

// Interpolate kernels work for 2d and 3d. Separate kernels for x, y, and z cases.
__kernel void
interpolateAlongAxisX(__global const float *uh,
                    __global float *u,
                    int parity, uint nx,
                    uint offseth, uint xstrideh, uint ystrideh, uint zstrideh,
                    uint offset, uint xstride, uint ystride, uint zstride)
{
    size_t ih = get_global_id(0);
    size_t j = get_global_id(1);
    size_t k = get_global_id(2);
    size_t i = ih * 2;

    // Index into uh grid is (ih, j, k)
    size_t idxh = offseth + ih * xstrideh + j * ystrideh + k * zstrideh;
    size_t idx = offset + i * xstride + j * ystride + k * zstride;
    if (parity == 0)
    {
        float v = 0.75f * uh[idxh];
        u[idx] = v + 0.25f * uh[idxh - xstrideh];
        u[idx + xstrideh] = v + 0.25f * uh[idxh + xstrideh];
    }
    else
    {
        u[idx] = 0.5f * (uh[idxh - xstrideh] + uh[idxh]);
        if (i < nx - 1)
        {
            u[idx + xstride] = uh[idxh];
        }
    }
}

__kernel void
interpolateAlongAxisY(__global const float *uh,
                    __global float *u,
                    int parity, uint ny,
                    uint offseth, uint xstrideh, uint ystrideh, uint zstrideh,
                    uint offset, uint xstride, uint ystride, uint zstride)
{
    size_t i = get_global_id(0);
    size_t jh = get_global_id(1);
    size_t k = get_global_id(2);
    size_t j = jh * 2;

    // Index into uh grid is (i, jh, k)
    size_t idxh = offseth + i * xstrideh + jh * ystrideh + k * zstrideh;
    size_t idx = offset + i * xstride + j * ystride + k * zstride;
    if (parity == 0)
    {
        float v = 0.75f * uh[idxh];
        u[idx] = v + 0.25f * uh[idxh - ystrideh];
        u[idx + ystride] = v + 0.25f * uh[idxh + ystrideh];
    }
    else
    {
        u[idx] = 0.5f * (uh[idxh - ystrideh] + uh[idxh]);
        if (j < ny - 1)
            u[idx + ystride] = uh[idxh];
    }
}

__kernel void
interpolateAlongAxisZ(__global const float *uh,
                    __global float *u,
                    int parity, uint nz,
                    uint offseth, uint xstrideh, uint ystrideh, uint zstrideh,
                    uint offset, uint xstride, uint ystride, uint zstride)
{
    size_t i = get_global_id(0);
    size_t j = get_global_id(1);
    size_t kh = get_global_id(2);
    size_t k = kh * 2;

    // Index into uh grid is (i, j, kh)
    size_t idxh = offseth + i * xstrideh + j * ystrideh + kh * zstrideh;
    size_t idx = offset + i * xstride + j * ystride + k * zstride;
    if (parity == 0)
    {
        float v = 0.75f * uh[idxh];
        u[idx] = v + 0.25f * uh[idxh - zstrideh];
        u[idx + zstride] = v + 0.25f * uh[idxh + zstrideh];
    }
    else
    {
        u[idx] = 0.5f * (uh[idxh - zstrideh] + uh[idxh]);
        if (k < nz - 1)
            u[idx + zstride] = uh[idxh];
    }
}


// buildOptions=-D NO_DOUBLE_SUPPORT -I testsuite/ocl/AppKernels/Houdini
// RUN: %occ-cli %s --cl-options="-I%cwd -I%S -D NO_DOUBLE_SUPPORT -I testsuite/ocl/AppKernels/Houdini" %cfg_path --cl-device=%cl_device 2>&1
