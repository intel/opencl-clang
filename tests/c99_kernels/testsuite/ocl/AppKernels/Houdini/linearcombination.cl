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
 * NAME:    linearcombination.cl ( CE Library, OpenCL)
 *
 * COMMENTS:
 */

#include "interpolate.h"

#ifndef OFFSET0
#define OFFSET0 0
#endif

#ifndef OFFSET1
#define OFFSET1 0
#endif

#ifndef OFFSET2
#define OFFSET2 0
#endif

#define MIX_COPY    0
#define MIX_ADD     1
#define MIX_SUB     2
#define MIX_MUL     3
#define MIX_DIV     4
#define MIX_MAX     5
#define MIX_MIN     6
#define MIX_AVERAGE 7

#ifndef MIXOP
#define MIXOP MIX_ADD
#endif

#ifndef USECONST
#define USECONST 1
#endif

float safediv(float x, float y)
{
    return select(0.0f, x / y, y != 0.0f);
}

float mixop(float d, float s)
{
#if MIXOP == MIX_COPY
    d = s;
#elif MIXOP == MIX_ADD
    d += s;
#elif MIXOP == MIX_SUB
    d -= s;
#elif MIXOP == MIX_MUL
    d *= s;
#elif MIXOP == MIX_DIV
    d = safediv(d, s);
#elif MIXOP == MIX_MAX
    d = fmax(d, s);
#elif MIXOP == MIX_MIN
    d = fmin(d, s);
#endif
    return d;
}

float mix1(float C1, float v1,
           float D, float CPost)
{
    float r;
    r = v1 * C1;
#if USECONST == 1
    r = mixop(r, D);
#endif
    r *= CPost;
    return r;
}

float mix2(float C1, float v1,
           float C2, float v2,
           float D, float CPost)
{
    float r;
    r = v1 * C1;
    r = mixop(r, v2 * C2);
#if USECONST == 1
    r = mixop(r, D);
#endif
    r *= CPost;
    return r;
}

float mix3(float C1, float v1,
           float C2, float v2,
           float C3, float v3,
           float D, float CPost)
{
    float r;
    r = v1 * C1;
    r = mixop(r, v2 * C2);
    r = mixop(r, v3 * C3);
#if USECONST == 1
    r = mixop(r, D);
#endif
    r *= CPost;
    return r;
}

#if !defined(NFIELDS) || NFIELDS == 1
__kernel void
linearCombination1(float c0, __global const float *a0,
                   float d, float cpost,
                   __global float *out, const uint axisstride,
                   uint offset, uint xstride, uint ystride, uint zstride)
{
    const size_t idx = offset + get_global_id(0) * xstride +
                                get_global_id(1) * ystride +
                                get_global_id(2) * zstride;
    float v0;

#if OFFSET0 == -1
    v0 = faceFromCenter(a0, idx, axisstride);
#elif OFFSET0 == 1
    v0 = centerFromFace(a0, idx, axisstride);
#else
    v0 = a0[idx];
#endif

    out[idx] = mix1(c0, v0, d, cpost);
}
#endif

#if !defined(NFIELDS) || NFIELDS == 2
__kernel void
linearCombination2(float c0, __global const float *a0,
                   float c1, __global const float *a1,
                   float d, float cpost,
                   __global float *out, const uint axisstride,
                   uint offset, uint xstride, uint ystride, uint zstride)
{
    const size_t idx = offset + get_global_id(0) * xstride +
                                get_global_id(1) * ystride +
                                get_global_id(2) * zstride;
    float v0, v1;

#if OFFSET0 == -1
    v0 = faceFromCenter(a0, idx, axisstride);
#elif OFFSET0 == 1
    v0 = centerFromFace(a0, idx, axisstride);
#else
    v0 = a0[idx];
#endif

#if OFFSET1 == -1
    v1 = faceFromCenter(a1, idx, axisstride);
#elif OFFSET1 == 1
    v1 = centerFromFace(a1, idx, axisstride);
#else
    v1 = a1[idx];
#endif

    out[idx] = mix2(c0, v0, c1, v1, d, cpost);
}
#endif

#if !defined(NFIELDS) || NFIELDS == 3
__kernel void
linearCombination3(float c0, __global const float *a0,
                   float c1, __global const float *a1,
                   float c2, __global const float *a2,
                   float d, float cpost,
                   __global float *out, const uint axisstride,
                   uint offset, uint xstride, uint ystride, uint zstride)
{
    const size_t idx = offset + get_global_id(0) * xstride +
                                get_global_id(1) * ystride +
                                get_global_id(2) * zstride;
    float v0, v1, v2;

#if OFFSET0 == -1
    v0 = faceFromCenter(a0, idx, axisstride);
#elif OFFSET0 == 1
    v0 = centerFromFace(a0, idx, axisstride);
#else
    v0 = a0[idx];
#endif

#if OFFSET1 == -1
    v1 = faceFromCenter(a1, idx, axisstride);
#elif OFFSET1 == 1
    v1 = centerFromFace(a1, idx, axisstride);
#else
    v1 = a1[idx];
#endif

#if OFFSET2 == -1
    v2 = faceFromCenter(a2, idx, axisstride);
#elif OFFSET2 == 1
    v2 = centerFromFace(a2, idx, axisstride);
#else
    v2 = a2[idx];
#endif

    out[idx] = mix3(c0, v0, c1, v1, c2, v2, d, cpost);
}
#endif



// buildOptions=-D NO_DOUBLE_SUPPORT -I testsuite/ocl/AppKernels/Houdini -D NFIELDS=2 -D USECONST=1 -D MIXOP=1 -D OFFSET0=0 -D OFFSET1=-1
// RUN: %occ-cli %s --cl-options="-I%cwd -I%S -D NO_DOUBLE_SUPPORT -I testsuite/ocl/AppKernels/Houdini -D NFIELDS=2 -D USECONST=1 -D MIXOP=1 -D OFFSET0=0 -D OFFSET1=-1" %cfg_path --cl-device=%cl_device 2>&1
