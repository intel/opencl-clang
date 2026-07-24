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
 * NAME:    gridops.cl ( CE Library, OpenCL)
 *
 * COMMENTS:
 */

// #pragma OPENCL EXTENSION cl_amd_printf : enable
#include "interpolate.h"

// Sets the grid to a single constant value.
__kernel void
setValue(__global float *grid, float val,
            uint offset, uint xstride, uint ystride, uint zstride)
{
    size_t idx = offset + get_global_id(0) * xstride +
                          get_global_id(1) * ystride +
                          get_global_id(2) * zstride;
    grid[idx] = val;
}

// Used for copying data between non-congruent grids.
__kernel void
copyData(__global const float *src,
         __global float *dst,
         uint srcoffset, uint srcxstride, uint srcystride, uint srczstride,
         uint dstoffset, uint dstxstride, uint dstystride, uint dstzstride)
{
    size_t i = get_global_id(0);
    size_t j = get_global_id(1);
    size_t k = get_global_id(2);
    size_t srcidx = srcoffset + i * srcxstride + j * srcystride + k * srczstride;
    size_t dstidx = dstoffset + i * dstxstride + j * dstystride + k * dstzstride;
    dst[dstidx] = src[srcidx];
}

// Add the gradient of a center-sampled grid to a face-centered one.
__kernel void
applyGradientFace(__global const float *p, __global float *v,
              float invdp, int pstride,
              uint offset, uint xstride, uint ystride, uint zstride)
{
    size_t idx = offset + get_global_id(0) * xstride +
                          get_global_id(1) * ystride +
                          get_global_id(2) * zstride;
    v[idx] += dudxCenterAtFace(p, idx, pstride, invdp);
}

// Add the gradient of a grid to another, assuming they are aligned.
__kernel void
applyGradientAligned(__global const float *p, __global float *v,
              float inv2dp, int pstride,
              uint offset, uint xstride, uint ystride, uint zstride)
{
    size_t idx = offset + get_global_id(0) * xstride +
                          get_global_id(1) * ystride +
                          get_global_id(2) * zstride;
    v[idx] += dudxAligned(p, idx, pstride, inv2dp);
}

// Apply buoyancy force from center-sample temperature grid to a
// face-sampled field.
__kernel void
buoyancyFace(__global const float *temp, __global float *vel,
         uint tempstride,
         float scale, float Tamb,
         uint offset, uint xstride, uint ystride, uint zstride)
{
    size_t idx = offset + get_global_id(0) * xstride +
                          get_global_id(1) * ystride +
                          get_global_id(2) * zstride;
    float T = faceFromCenter(temp, idx, tempstride);
    vel[idx] += scale * (T - Tamb);
}

// Apply buoyancy force from temperature grid to aligned field.
__kernel void
buoyancyAligned(__global const float *temp, __global float *vel,
         uint tempstride,
         float scale, float Tamb,
         uint offset, uint xstride, uint ystride, uint zstride)
{
    size_t idx = offset + get_global_id(0) * xstride +
                          get_global_id(1) * ystride +
                          get_global_id(2) * zstride;
    vel[idx] += scale * (temp[idx] - Tamb);
}

// Updates the grid border "ghost" cells to a constant value.
__kernel void
updateBorderConstant(__global float *grid, float val,
                        uint naxis, uint ng,
                        uint offset,
                        uint xstride, uint ystride, uint zstride)
{
    size_t idx0 = offset + get_global_id(0) * xstride +
                           get_global_id(1) * ystride;
    size_t idxn = idx0 + (naxis + ng) * zstride;
    for (int i = 0; i < ng; i++)
    {
        grid[idx0] = val;
        grid[idxn] = val;
        idx0 += zstride;
        idxn += zstride;
    }
}

// Updates the grid border "ghost" cells to the streaked value at the borders.
__kernel void
updateBorderStreak(__global float *grid,
                    uint naxis, uint ng,
                    uint offset,
                    uint xstride, uint ystride, uint zstride)
{
    // Index of "left side" border cell.
    size_t idxb0 = offset + get_global_id(0) * xstride +
                            get_global_id(1) * ystride +
                            ng * zstride;
    // Index of "right side" border cell.
    size_t idxbn = idxb0 + (naxis - 1) * zstride;

    float b0 = grid[idxb0];
    float bn = grid[idxbn];
    size_t goff = 0;
    for (int i=0; i < ng; i++)
    {
        // Offset to current ghost cell.
        goff += zstride;
        // Set current "left side" ghost cell.
        grid[idxb0 - goff] = b0;
        // Set current "right side" ghost cell.
        grid[idxbn + goff] = bn;
    }
}

int
clampint(int x, int minval, int maxval)
{
    return min(max(x, minval), maxval);
}

// Updates the grid border "ghost" cells to an extrapolate value from the borders.
__kernel void
updateBorderExtrapolate(__global float *grid,
                    float sx, float sy, float sz,
                    int nx, int ny,
                    int ngx, int ngy,
                    uint naxis, uint ng,
                    uint offset,
                    uint xstride, uint ystride, uint zstride)
{
    // Index of "left side" border cell.
    int i = get_global_id(0);
    int j = get_global_id(1);
    size_t idx0 = offset + i * xstride +  j * ystride + ng * zstride;
    size_t idxn = idx0 + (naxis - 1) * zstride;

    int ci = clampint(i, ngx, nx + ngx - 1);
    int cj = clampint(j, ngy, ny + ngy - 1);

    // Index of "left side" border cell.
    size_t idxb0 = offset + ci * xstride +  cj * ystride + ng * zstride;
    // Index of "right side" border cell.
    size_t idxbn = idxb0 + (naxis - 1) * zstride;

    float extrap = (i - ci) * sx + (j - cj) * sy;
    float b0 = grid[idxb0];
    float bn = grid[idxbn];

    for (int k = 1; k <=  ng; k++)
    {
        // Offset to current ghost cell.
        idx0 -= zstride;
        idxn += zstride;
        // Set current "left side" ghost cell.
        grid[idx0] = b0 + extrap - k * sz;
        // Set current "right side" ghost cell.
        grid[idxn] = bn + extrap + k * sz;
    }
}

// Enforce the positive and negative side boundary for one axis to a set
// value, possibly adding a scaled multiple of the boundary value as well.
__kernel void
enforceSideBoundary(__global float *grid, uint naxis, uint axisstride,
                    int setneg, int setpos,
                    float negvalue, float posvalue,
                    float adjneg, float adjpos,
                    uint offset, uint xstride, uint ystride)
{
    size_t idx0 = offset + get_global_id(0) * xstride +
                           get_global_id(1) * ystride;
    if (setneg)
    {
        float adj = 0;
        if (adjneg != 0)
            adj = adjneg * grid[idx0 + axisstride];
        grid[idx0] = negvalue + adj;
    }
    if (setpos)
    {
        size_t idxn = idx0 + (naxis - 1) * axisstride;
        float adj = 0;
        if (adjpos != 0)
            adj = adjpos * grid[idxn - axisstride];
        grid[idxn] = posvalue + adj;
    }
}

// Enforce collision boundary for a scalar, aligned grid.  Just sets to zero.
__kernel void
enforceCollisionBoundaryScalarAligned(__global float *grid,
                                __global const float *collision,
                                uint offset,
                                uint xstride, uint ystride, uint zstride)
{
    size_t idx = offset + get_global_id(0) * xstride +
                          get_global_id(1) * ystride +
                          get_global_id(2) * zstride;

    if (collision[idx] >= 0.0f)
    {
        grid[idx] = 0;
    }
}

// For each collision voxel, set the lower face and upper face to val.
// This means two threads might set a value for the same face, but it
// will always be to the same value so we should be OK.
void
enforceBoundaryAxisConstantFace(__global float *x,
                            size_t idx, uint axisstride,
                            const float val)
{
    x[idx] = val;
    x[idx + axisstride] = val;
}

// Enforce collision boundary to a constant value for face-sampled vector field.
__kernel void
enforceCollisionBoundaryConstantFace(__global float *x,
                                 __global float *y,
                                 __global float *z,
                                 __global const float *collision,
                                 float xval, float yval, float zval,
                                 uint offset, uint ystride, uint zstride)
{
    size_t idx = offset + get_global_id(0) +
                          get_global_id(1) * ystride +
                          get_global_id(2) * zstride;
    if (collision[idx] >= 0.0f)
    {
        enforceBoundaryAxisConstantFace(x, idx, 1, xval);
        enforceBoundaryAxisConstantFace(y, idx, ystride, yval);
        enforceBoundaryAxisConstantFace(z, idx, zstride, zval);
    }
}

// Enforce collision boundary to a constant value for face-sampled 2d vector
// field.
__kernel void
enforceCollisionBoundaryConstantFace2d(__global float *x,
                                   __global float *y,
                                   __global const float *collision,
                                   float xval, float yval,
                                   uint offset, uint xstride, uint ystride)
{
    size_t idx = offset + get_global_id(0) * xstride +
                          get_global_id(1) * ystride;
    if (collision[idx] >= 0.0f)
    {
        enforceBoundaryAxisConstantFace(x, idx, xstride, xval);
        enforceBoundaryAxisConstantFace(y, idx, ystride, yval);
    }
}

// Enforce collision boundary to a constant value for center-sampled vector
// field.
__kernel void
enforceCollisionBoundaryConstantAligned(__global float *x,
                                 __global float *y,
                                 __global float *z,
                                 __global const float *collision,
                                 float xval, float yval, float zval,
                                 uint offset, uint ystride, uint zstride)
{
    size_t idx = offset + get_global_id(0) +
                          get_global_id(1) * ystride +
                          get_global_id(2) * zstride;
    if (collision[idx] >= 0.0f)
    {
        x[idx] = xval;
        y[idx] = yval;
        z[idx] = zval;
    }
}

// Enforce collision boundary to a constant value for center-sampled 2D vector
// field.
__kernel void
enforceCollisionBoundaryConstantAligned2d(__global float *x,
                                   __global float *y,
                                   __global const float *collision,
                                   float xval, float yval,
                                   uint offset, uint xstride, uint ystride)
{
    size_t idx = offset + get_global_id(0) * xstride +
                          get_global_id(1) * ystride;
    if (collision[idx] >= 0.0f)
    {
        x[idx] = xval;
        y[idx] = yval;
    }
}

// For each collision voxel, set the lower face and upper face to the
// interpolated value from the collisionval grid.
// This means two threads might set a value for the same face, but it
// will always be to the same value so we should be OK.
void
enforceBoundaryAxisFace(__global float *x,
                    size_t idx, uint axisstride,
                    __global const float *collisionval)
{
    x[idx] = faceFromCenter(collisionval, idx, axisstride);
    idx += axisstride;
    x[idx] = faceFromCenter(collisionval, idx, axisstride);
}

// Enforce collision boundary as specified by center-sampled collision grid,
// with values from center-sampled collisionval grids, at face-sampled vector
// field.
__kernel void
enforceCollisionBoundaryFace(__global float *x,
                         __global float *y,
                         __global float *z,
                         __global const float *collision,
                         __global const float *collisionvalx,
                         __global const float *collisionvaly,
                         __global const float *collisionvalz,
                         uint offset, uint ystride, uint zstride)
{
    size_t idx = offset + get_global_id(0) +
                          get_global_id(1) * ystride +
                          get_global_id(2) * zstride;

    if (collision[idx] >= 0.0f)
    {
        enforceBoundaryAxisFace(x, idx, 1, collisionvalx);
        enforceBoundaryAxisFace(y, idx, ystride, collisionvaly);
        enforceBoundaryAxisFace(z, idx, zstride, collisionvalz);
    }
}

// Enforce 2-d collision boundary as specified by center-sampled collision grid,
// with values from center-sampled collisionval grids, at face-sampled vector
// field.
__kernel void
enforceCollisionBoundaryFace2d(__global float *x,
                         __global float *y,
                         __global const float *collision,
                         __global const float *collisionvalx,
                         __global const float *collisionvaly,
                         uint offset, uint xstride, uint ystride)
{
    size_t idx = offset + get_global_id(0) * xstride +
                          get_global_id(1) * ystride;

    if (collision[idx] >= 0.0f)
    {
        enforceBoundaryAxisFace(x, idx, xstride, collisionvalx);
        enforceBoundaryAxisFace(y, idx, ystride, collisionvaly);
    }
}

// Enforce collision boundary as specified by collision grid,
// with values from collisionval grids, at aligned vector field.
__kernel void
enforceCollisionBoundaryAligned(__global float *x,
                         __global float *y,
                         __global float *z,
                         __global const float *collision,
                         __global const float *collisionvalx,
                         __global const float *collisionvaly,
                         __global const float *collisionvalz,
                         uint offset, uint ystride, uint zstride)
{
    size_t idx = offset + get_global_id(0) +
                          get_global_id(1) * ystride +
                          get_global_id(2) * zstride;

    if (collision[idx] >= 0.0f)
    {
        x[idx] = collisionvalx[idx];
        y[idx] = collisionvaly[idx];
        z[idx] = collisionvalz[idx];
    }
}

// Enforce 2-d collision boundary as specified by collision grid,
// with values from collisionval grids, at aligned vector field.
__kernel void
enforceCollisionBoundaryAligned2d(__global float *x,
                         __global float *y,
                         __global const float *collision,
                         __global const float *collisionvalx,
                         __global const float *collisionvaly,
                         uint offset, uint xstride, uint ystride)
{
    size_t idx = offset + get_global_id(0) * xstride +
                          get_global_id(1) * ystride;

    if (collision[idx] >= 0.0f)
    {
        x[idx] = collisionvalx[idx];
        y[idx] = collisionvaly[idx];
    }
}

// Perform a box filter along the given axis.
__kernel void
boxFilterAlongAxis(__global const float *src,
                   __global float *out,
                   int intrad, float scale,
                   float frac, float frac2,
                   int axisstride,
                   uint offset, uint xstride, uint ystride, uint zstride)
{
    size_t idx = offset + get_global_id(0) * xstride +
                          get_global_id(1) * ystride +
                          get_global_id(2) * zstride;
    float sum = 0;
    float x1, x2;
    // axisstride needs to be int rather than uint since intrad can be < 0.
    x2 = src[idx - (intrad + 2) * axisstride];
    x1 = src[idx - (intrad + 1) * axisstride];
    sum += frac * x1 + frac2 * (x2 - x1);
    if (intrad >= 0)
        for (int i = -intrad; i <= intrad; i++)
            sum += src[idx + i * axisstride];
    x1 = src[idx + (intrad + 1) * axisstride];
    x2 = src[idx + (intrad + 2) * axisstride];
    sum += frac * x1 + frac2 * (x2 - x1);
    out[idx] = sum * scale;
}

// Perform a "sliding window" box filter along the given axis.
__kernel void
boxFilterWindow(__global const float *src,
                __global float *out,
                int intrad, float scale,
                float frac, float frac2,
                uint naxis, int axisstride,
                uint offset, uint xstride, uint ystride)
{
    size_t idx = offset + get_global_id(0) * xstride +
                          get_global_id(1) * ystride;
    float sum, innersum = 0;
    float v_mir1, v_mir2, v_pir1, v_pir2;
    // Initialize values at "left" axis.
    // axisstride needs to be int rather than uint since intrad can be < 0.
    v_mir1 = src[idx - (intrad + 1) * axisstride];
    v_mir2 = src[idx - (intrad + 2) * axisstride];
    if (intrad >= 0)
        for (int i = -intrad; i <= intrad; i++)
            innersum += src[idx + i * axisstride];
    v_pir1 = src[idx + (intrad + 1) * axisstride];
    v_pir2 = src[idx + (intrad + 2) * axisstride];
    // Accumulate values for voxel.
    sum = innersum;
    sum += frac * v_mir1 + frac2 * (v_mir2 - v_mir1);
    sum += frac * v_pir1 + frac2 * (v_pir2 - v_pir1);
    out[idx] = sum * scale;

    // Slide window across axis.
    for(uint w = 1; w < naxis; w++)
    {
        // The value previously at v_pir1 slides into the window.
        if (intrad >= 0)
            innersum += v_pir1;
        // Roll over existing values.
        v_mir2 = v_mir1;
        v_pir1 = v_pir2;
        idx += axisstride;
        // Load new values.
        v_mir1 = src[idx - (intrad + 1) * axisstride];
        v_pir2 = src[idx + (intrad + 2) * axisstride];
        // The new value for v_mir1 slides out of the window.
        if (intrad >= 0)
            innersum -= v_mir1;

        // Accumulate values for voxel.
        sum = innersum;
        sum += frac * v_mir1 + frac2 * (v_mir2 - v_mir1);
        sum += frac * v_pir1 + frac2 * (v_pir2 - v_pir1);
        out[idx] = sum * scale;
    }

}


// buildOptions=-D NO_DOUBLE_SUPPORT -I testsuite/ocl/AppKernels/Houdini
// RUN: %occ-cli %s --cl-options="-I%cwd -I%/S -D NO_DOUBLE_SUPPORT -I testsuite/ocl/AppKernels/Houdini" %cfg_path --cl-device=%cl_device 2>&1
