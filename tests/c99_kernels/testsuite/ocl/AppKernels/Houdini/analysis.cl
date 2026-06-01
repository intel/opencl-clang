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
 * NAME:    analysis.cl ( CE Library, OpenCL)
 *
 * COMMENTS:
 */

#include "interpolate.h"

// Calculate curl from center-sampled velocity to store in center-sampled cells.
__kernel void
curlAligned(__global const float *u,
            __global const float *v,
            __global const float *w,
            __global float *x,
            __global float *y,
            __global float *z,
            const float inv2dx, const float inv2dy, const float inv2dz,
            uint offset, const uint ystride, const uint zstride)
{
    const size_t idx = offset + get_global_id(0) +
                                get_global_id(1) * ystride +
                                get_global_id(2) * zstride;

    float dwdy = dudxAligned(w, idx, ystride, inv2dy);

    float dvdz = dudxAligned(v, idx, zstride, inv2dz);

    float dudz = dudxAligned(u, idx, zstride, inv2dz);

    float dwdx = dudxAligned(w, idx, 1, inv2dx);

    float dvdx = dudxAligned(v, idx, 1, inv2dx);

    float dudy = dudxAligned(u, idx, ystride, inv2dy);

    x[idx] = dwdy - dvdz;
    y[idx] = dudz - dwdx;
    z[idx] = dvdx - dudy;
}

__kernel void
curlAligned2d(__global const float *u,
              __global const float *v,
              __global float *x,
              __global float *y,
              __global float *z,
            const float inv2dx, const float inv2dy,
            uint offset, uint xstride, uint ystride)
{
    const size_t idx = offset + get_global_id(0) * xstride +
                                get_global_id(1) * ystride;

    float dvdx = dudxAligned(v, idx, xstride, inv2dx);

    float dudy = dudxAligned(u, idx, ystride, inv2dy);

    x[idx] = 0;
    y[idx] = 0;
    z[idx] = dvdx - dudy;
}

// Calculate curl from face-sampled velocity to store in center-sampled cells.
__kernel void
curlAlignedFace(__global const float *u,
               __global const float *v,
               __global const float *w,
               __global float *x,
               __global float *y,
               __global float *z,
               const float inv4dx, const float inv4dy, const float inv4dz,
               uint offset, const uint ystride, const uint zstride)
{
    const size_t idx = offset + get_global_id(0) +
                                get_global_id(1) * ystride +
                                get_global_id(2) * zstride;

    float dwdy = dudxAlignedFace(w, idx, zstride, ystride, inv4dy);

    float dvdz = dudxAlignedFace(v, idx, ystride, zstride, inv4dz);

    float dudz = dudxAlignedFace(u, idx, 1, zstride, inv4dz);

    float dwdx = dudxAlignedFace(w, idx, zstride, 1, inv4dx);

    float dvdx = dudxAlignedFace(v, idx, ystride, 1, inv4dx);

    float dudy = dudxAlignedFace(u, idx, 1, ystride, inv4dy);

    x[idx] = dwdy - dvdz;
    y[idx] = dudz - dwdx;
    z[idx] = dvdx - dudy;
}

__kernel void
curlAlignedFace2d(__global const float *u,
              __global const float *v,
              __global float *x,
              __global float *y,
              __global float *z,
            const float inv2dx, const float inv2dy,
            uint offset, uint xstride, uint ystride)
{
    const size_t idx = offset + get_global_id(0) * xstride +
                                get_global_id(1) * ystride;

    float dvdx = dudxAlignedFace(v, idx, ystride, xstride, inv2dx);

    float dudy = dudxAlignedFace(u, idx, xstride, ystride, inv2dy);

    x[idx] = 0;
    y[idx] = 0;
    z[idx] = dvdx - dudy;
}

// Expects center-sampled velocity
__kernel void lengthAligned(__global const float *u,
                            __global const float *v,
                            __global const float *w,
                            __global float *len,
                            uint offset,
                            uint xstride, uint ystride, uint zstride)
{
    size_t idx = offset + get_global_id(0) * xstride +
                          get_global_id(1) * ystride +
                          get_global_id(2) * zstride;
    float vx = u[idx], vy = v[idx], vz = w[idx];
    len[idx] = native_sqrt(vx * vx + vy * vy + vz * vz);
}

void
vectorNormalize(float *x, float *y, float *z)
{
    float sqrsum = *x * *x + *y * *y + *z * *z;
    if (sqrsum > FLT_MIN)
    {
        sqrsum = native_sqrt(sqrsum);
        *x /= sqrsum;
        *y /= sqrsum;
        *z /= sqrsum;
    }
}

void
vectorNormalize2d(float *x, float *y)
{
    float sqrsum = *x * *x + *y * *y;
    if (sqrsum > FLT_MIN)
    {
        sqrsum = native_sqrt(sqrsum);
        *x /= sqrsum;
        *y /= sqrsum;
    }
}

__kernel void
normalizeAligned(__global const float *u,
                 __global const float *v,
                 __global const float *w,
                 __global float *x,
                 __global float *y,
                 __global float *z,
                 uint offset,
                 uint xstride, uint ystride, uint zstride)
{
    size_t idx = offset + get_global_id(0) * xstride +
                          get_global_id(1) * ystride +
                          get_global_id(2) * zstride;

    float vx = u[idx];
    float vy = v[idx];
    float vz = w[idx];
    vectorNormalize(&vx, &vy, &vz);
    x[idx] = vx;
    y[idx] = vy;
    z[idx] = vz;
}

__kernel void
gradientAligned(__global const float *u,
         __global float *x,
         __global float *y,
         __global float *z,
         int doNormalize,
         float inv2dx, float inv2dy, float inv2dz,
         uint offset, uint ystride, uint zstride)
{
    size_t idx = offset + get_global_id(0) +
                          get_global_id(1) * ystride +
                          get_global_id(2) * zstride;

    // Central-difference derivatives.
    float dudx = dudxAligned(u, idx, 1, inv2dx);
    float dudy = dudxAligned(u, idx, ystride, inv2dy);
    float dudz = dudxAligned(u, idx, zstride, inv2dz);

    // Normalize
    if (doNormalize)
        vectorNormalize(&dudx, &dudy, &dudz);
    x[idx] = dudx;
    y[idx] = dudy;
    z[idx] = dudz;
}

__kernel void
gradientAligned2d(__global const float *u,
                  __global float *x,
                  __global float *y,
                  __global float *z,
                  int doNormalize,
                  float inv2dx, float inv2dy,
                  uint offset, uint xstride, uint ystride)
{
    size_t idx = offset + get_global_id(0) * xstride +
                          get_global_id(1) * ystride;

    // Central-difference derivatives.
    float dudx = dudxAligned(u, idx, xstride, inv2dx);
    float dudy = dudxAligned(u, idx, ystride, inv2dy);

    // Normalize
    if (doNormalize)
        vectorNormalize2d(&dudx, &dudy);
    x[idx] = dudx;
    y[idx] = dudy;
    z[idx] = 0;
}

// Calculate the divergence of face-sampled vector field and store in
// center-sampled scalar field.
__kernel void
divergenceFace(__global const float *x, __global const float *y,
               __global const float *z, __global float *div,
               float invdx, float invdy, float invdz,
               uint offset, uint ystride, uint zstride)
{
    size_t idx = offset + get_global_id(0) +
                          get_global_id(1) * ystride +
                          get_global_id(2) * zstride;
    div[idx] = dudxFaceAtCenter(x, idx, 1, invdx) +
               dudxFaceAtCenter(y, idx, ystride, invdy) +
               dudxFaceAtCenter(z, idx, zstride, invdz);
}

__kernel void
divergenceFace2d(__global const float *x, __global const float *y,
                 __global float *div,
                 float invdx, float invdy,
                 uint offset, uint xstride, uint ystride)
{
    size_t idx = offset + get_global_id(0) * xstride +
                          get_global_id(1) * ystride;
    div[idx] = dudxFaceAtCenter(x, idx, xstride, invdx) +
               dudxFaceAtCenter(y, idx, ystride, invdy);
}

// Calculate the divergence of center-sampled vector field and store in
// center-sampled scalar field.
__kernel void
divergenceCenter(__global const float *x, __global const float *y,
                 __global const float *z, __global float *div,
                 float inv2dx, float inv2dy, float inv2dz,
                 uint offset, uint ystride, uint zstride)
{
    size_t idx = offset + get_global_id(0) +
                          get_global_id(1) * ystride +
                          get_global_id(2) * zstride;
    div[idx] = dudxAligned(x, idx, 1, inv2dx) +
               dudxAligned(y, idx, ystride, inv2dy) +
               dudxAligned(z, idx, zstride, inv2dz);
}

__kernel void
divergenceCenter2d(__global const float *x, __global const float *y,
                   __global float *div,
                   float inv2dx, float inv2dy,
                   uint offset, uint xstride, uint ystride)
{
    size_t idx = offset + get_global_id(0) * xstride +
                          get_global_id(1) * ystride;
    div[idx] = dudxAligned(x, idx, xstride, inv2dx) +
               dudxAligned(y, idx, ystride, inv2dy);
}

__kernel void
crossProductAligned(__global const float *u,
                    __global const float *v,
                    __global const float *w,
                    __global const float *x,
                    __global const float *y,
                    __global const float *z,
                    __global float *cx,
                    __global float *cy,
                    __global float *cz,
                    uint offset, uint xstride, uint ystride, uint zstride)
{
    size_t idx = offset + get_global_id(0) * xstride +
                          get_global_id(1) * ystride +
                          get_global_id(2) * zstride;
    float ax = u[idx];
    float ay = v[idx];
    float az = w[idx];
    float bx = x[idx];
    float by = y[idx];
    float bz = z[idx];

    // Cross product: A x B
    cx[idx] =  ay * bz - az * by;
    cy[idx] =  az * bx - ax * bz;
    cz[idx] =  ax * by - ay * bx;
}



// buildOptions=-D NO_DOUBLE_SUPPORT -I testsuite/ocl/AppKernels/Houdini
// RUN: %occ-cli %s --cl-options="-I%cwd -I%S -D NO_DOUBLE_SUPPORT -I testsuite/ocl/AppKernels/Houdini" %cfg_path --cl-device=%cl_device 2>&1
