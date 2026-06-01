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
 * NAME:    interpolate.h ( CE Library, OpenCL)
 *
 * COMMENTS:
 */

// #pragma OPENCL EXTENSION cl_amd_printf : enable

/*#ifdef cl_amd_printf
#define CHECKNAN(f) if (isnan(f)) { printf("%s is NAN, x = %g, y = %g, z = %g\n",#f, x, y, z);}
#define CHECKNAN2D(f) if (isnan(f)) { printf("%s is NAN, x = %g, y = %g\n",#f, x, y);}
#else*/
#define CHECKNAN(f)
#define CHECKNAN2D(f)
// #endif

#define CLAMPOFFSET 1e-4f


float centerFromFace(__global const float *a, size_t idx, uint axisstride)
{
    return 0.5f * (a[idx] + a[idx + axisstride]);
}

float faceFromCenter(__global const float *a, size_t idx, uint axisstride)
{
    return 0.5f * (a[idx - axisstride] + a[idx]);
}

// Calc central difference derivative of cell-centered grid
// at a center cell at idx.
float dudxAligned(__global const float *u, const uint idx,
                  const uint xstride, const float inv2dx)
{
    return inv2dx * (u[idx + xstride] - u[idx - xstride]);
}

// Calc central difference derivative of face-sampled grid
// at a center cell at idx.  This works for all the off-axes directions
// other than the one the face-sampled grid represents.  E.g. you can
// take the dy-derivative of the x-velocity field.
float dudxAlignedFace(__global const float *u, const uint idx,
                      const uint ustride, const uint xstride, float inv4dx)
{
    return inv4dx * ((u[idx + xstride] + u[idx + ustride + xstride]) -
                     (u[idx - xstride] + u[idx + ustride - xstride]));
}

// Calc central difference derivative of face-sampled grid
// at a center cell at idx. This only works for the derivative along
// the axis the face-centered grid represents, e.g. you can only take
// the dx-derivative of the x-velocity field.
float dudxFaceAtCenter(__global const float *u, const uint idx,
                      const uint xstride, float invdx)
{
    return invdx * (u[idx + xstride] - u[idx]);
}

float dudxCenterAtFace(__global const float *u, const uint idx,
                      const uint xstride, float invdx)
{
    return invdx * (u[idx] - u[idx - xstride]);
}

void
bilinear_interp(float x, float y, __global const float *p,
                        size_t idx,
                        __global float *phin,
                        __global float *minphi,
                        __global float *maxphi,
                        uint offset, uint xstride, uint ystride)

{
    // clamp to boundaries
    x = clamp(x, -1.0f, get_global_size(0) - CLAMPOFFSET);
    y = clamp(y, -1.0f, get_global_size(1) - CLAMPOFFSET);

    const int gi = (int)floor(x);
    const int gj = (int)floor(y);

    // get fractional part
    const float sx = x - gi;
    const float sy = y - gj;

    size_t srcidx = offset + gi * xstride + gj * ystride;

    const float i00 = p[srcidx];
    const float i10 = p[srcidx + xstride];
    const float i01 = p[srcidx + ystride];
    const float i11 = p[srcidx + xstride + ystride];

    CHECKNAN2D(i00)
    CHECKNAN2D(i10)
    CHECKNAN2D(i01)
    CHECKNAN2D(i11)
    const float val = (i00 * (1-sx) + i10 * (sx)) * (1-sy) +
                      (i01 * (1-sx) + i11 * (sx)) * (  sy);
    phin[idx] = val;
    if (minphi)
        minphi[idx] = fmin(fmin(fmin(i00, i01), i10), i11);
    if (maxphi)
        maxphi[idx] = fmax(fmax(fmax(i00, i01), i10), i11);
}

float
bilinear_interp_val(float x, float y, __global const float *p,
                        uint offset, uint xstride, uint ystride)

{
    // clamp to boundaries
    x = clamp(x, -1.0f, get_global_size(0) - CLAMPOFFSET);
    y = clamp(y, -1.0f, get_global_size(1) - CLAMPOFFSET);

    const int gi = (int)floor(x);
    const int gj = (int)floor(y);

    // get fractional part
    const float sx = x - gi;
    const float sy = y - gj;

    size_t srcidx = offset + gi * xstride + gj * ystride;

    const float i00 = p[srcidx];
    const float i10 = p[srcidx + xstride];
    const float i01 = p[srcidx + ystride];
    const float i11 = p[srcidx + xstride + ystride];

    return (i00 * (1-sx) + i10 * (sx)) * (1-sy) +
           (i01 * (1-sx) + i11 * (sx)) * (  sy);
}

void
trilinear_interp(float x, float y, float z, __global const float *p,
                    size_t idx,
                    __global float *phin,
                    __global float *minphi,
                    __global float *maxphi,
                    uint offset, uint ystride, uint zstride)
{
    x = clamp(x, -1.0f, get_global_size(0) - CLAMPOFFSET);
    y = clamp(y, -1.0f, get_global_size(1) - CLAMPOFFSET);
    z = clamp(z, -1.0f, get_global_size(2) - CLAMPOFFSET);

    const int gi = (int)floor(x);
    const int gj = (int)floor(y);
    const int gk = (int)floor(z);

    const float sx = x - gi;
    const float sy = y - gj;
    const float sz = z - gk;

    size_t srcidx = offset + gi + gj * ystride + gk * zstride;

    const float i000 = p[srcidx];
    const float i100 = p[srcidx + 1];
    const float i010 = p[srcidx + ystride];
    const float i110 = p[srcidx + 1 + ystride];
    const float i001 = p[srcidx + zstride];
    const float i101 = p[srcidx + 1 + zstride];
    const float i011 = p[srcidx + ystride + zstride];
    const float i111 = p[srcidx + 1 + ystride + zstride];

    CHECKNAN(i000)
    CHECKNAN(i100)
    CHECKNAN(i010)
    CHECKNAN(i110)
    CHECKNAN(i001)
    CHECKNAN(i101)
    CHECKNAN(i011)
    CHECKNAN(i111)
    const float val = ((i000 * (1 - sx) + i100 * (sx)) * (1 - sy) +
                      (i010 * (1 - sx) + i110 * (sx)) * (  sy)) * (1 - sz) +
                      ((i001 * (1 - sx) + i101 * (sx)) * (1 - sy) +
                      (i011 * (1 - sx) + i111 * (sx)) * (  sy)) * (  sz);

    phin[idx] = val;
    if (minphi)
        minphi[idx] = fmin(fmin(fmin(fmin(fmin(fmin(fmin(i000, i001), i010),
                                            i011), i100), i101), i110), i111);
    if (maxphi)
        maxphi[idx] = fmax(fmax(fmax(fmax(fmax(fmax(fmax(i000, i001), i010),
                                            i011), i100), i101), i110), i111);
}

float
trilinear_interp_val(float x, float y, float z, __global const float *p,
                    uint offset, uint ystride, uint zstride,
		    uint offx,	uint offy, uint offz )
{
    x = clamp(x, -1.0f, get_global_size(0) - CLAMPOFFSET - offx);
    y = clamp(y, -1.0f, get_global_size(1) - CLAMPOFFSET - offy);
    z = clamp(z, -1.0f, get_global_size(2) - CLAMPOFFSET - offz);

    const int gi = (int)floor(x);
    const int gj = (int)floor(y);
    const int gk = (int)floor(z);

    const float sx = x - gi;
    const float sy = y - gj;
    const float sz = z - gk;

    size_t srcidx = offset + gi + gj * ystride + gk * zstride;

    const float i000 = p[srcidx];
    const float i100 = p[srcidx + 1];
    const float i010 = p[srcidx + ystride];
    const float i110 = p[srcidx + 1 + ystride];
    const float i001 = p[srcidx + zstride];
    const float i101 = p[srcidx + 1 + zstride];
    const float i011 = p[srcidx + ystride + zstride];
    const float i111 = p[srcidx + 1 + ystride + zstride];

    return  ((i000 * (1 - sx) + i100 * (sx)) * (1 - sy) +
            (i010 * (1 - sx) + i110 * (sx)) * (  sy)) * (1 - sz) +
            ((i001 * (1 - sx) + i101 * (sx)) * (1 - sy) +
            (i011 * (1 - sx) + i111 * (sx)) * (  sy)) * (  sz);
}