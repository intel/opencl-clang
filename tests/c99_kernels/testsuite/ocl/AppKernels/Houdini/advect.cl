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
 * NAME:    advect.cl ( CE Library, OpenCL)
 *
 * COMMENTS:
 */

#include "interpolate.h"

// The advection method defaults to 0 ("single-step")
#if !defined(ADVECTMETHOD)
#define ADVECTMETHOD 0
#endif

#define NOPADX	(VELOFFX - FIELDOFFX)
#define NOPADY	(VELOFFY - FIELDOFFY)
#define NOPADZ	(VELOFFZ - FIELDOFFZ)

#define PADX	FIELDOFFX
#define PADY	FIELDOFFY
#define PADZ	FIELDOFFZ

void
advectPositionTrace(float *px, float *py, float *pz,
                    float vx, float vy, float vz, float dt, float cfl,
                    __global const float *u,
                    __global const float *v,
                    __global const float *w,
                    float invhx, float invhy, float invhz,
                    uint offset, uint ystride, uint zstride)
{
    float x = *px, y = *py, z = *pz;
    int i = 0;
#define MAX_TRACE 32
    while(i < MAX_TRACE)
    {
	i++;
        vx *= dt;
        vy *= dt;
        vz *= dt;

        float ratio = fmax(fmax(fabs(vx), fabs(vy)), fabs(vz));

        if (i >= MAX_TRACE || ratio <= cfl)
        {
            x -= vx;
            y -= vy;
            z -= vz;
            break;
        }
        ratio = cfl / ratio;
        dt -= ratio * dt;

        x -= ratio * vx;
        y -= ratio * vy;
        z -= ratio * vz;

        // Look up new velocities and convert to voxel space.
        vx = invhx * trilinear_interp_val(x + VELOFFX * 0.5f, y, z, u,
                                          offset, ystride, zstride,
					NOPADX, PADY, PADZ);
        vy = invhy * trilinear_interp_val(x, y + VELOFFY * 0.5f, z, v,
                                          offset, ystride, zstride,
					PADX, NOPADY, PADZ);
        vz = invhz * trilinear_interp_val(x, y, z + VELOFFZ * 0.5f, w,
                                          offset, ystride, zstride,
					PADX, PADY, NOPADZ);
    }
    *px = x;
    *py = y;
    *pz = z;
}

void
advectPositionTrace2d(float *px, float *py,
                    float vx, float vy, float dt, float cfl,
                    __global const float *u,
                    __global const float *v,
                    float invhx, float invhy,
                    uint offset, uint xstride, uint ystride)
{
    float x = *px, y = *py;
    while(1)
    {
        vx *= dt;
        vy *= dt;

        float ratio = fmax(fabs(vx), fabs(vy));

        if (ratio <= cfl)
        {
            x -= vx;
            y -= vy;
            break;
        }
        ratio = cfl / ratio;
        dt -= ratio * dt;

        x -= ratio * vx;
        y -= ratio * vy;

        // Look up new velocities and convert to voxel space.
        vx = invhx * bilinear_interp_val(x + VELOFFX * 0.5f, y, u,
                                         offset, xstride, ystride);
        vy = invhy * bilinear_interp_val(x, y + VELOFFY * 0.5f, v,
                                         offset, xstride, ystride);
    }
    *px = x;
    *py = y;
}

// In this case, we're advecting a center-sampled field.
#if FIELDOFFX == 0 && FIELDOFFY == 0 && FIELDOFFZ == 0
#define FIELDCENTER 1
#else
#define FIELDCENTER 0
#endif


__kernel void
advectMinMax(float dt, float cfl,
                    __global const float *u,
                    __global const float *v,
                    __global const float *w,
                    __global const float *phi,
                    __global float *phin,
                    __global float *minphi,
                    __global float *maxphi,
                    float invhx, float invhy, float invhz,
                    uint offset, uint ystride, uint zstride)
{
    size_t i = get_global_id(0);
    size_t j = get_global_id(1);
    size_t k = get_global_id(2);

    size_t idx = offset + i + j * ystride + k * zstride;

    // Initial position in voxel space.
    float x = i - FIELDOFFX * 0.5f;
    float y = j - FIELDOFFY * 0.5f;
    float z = k - FIELDOFFZ * 0.5f;

    // Initial velocity.
    float vx, vy, vz;
#if FIELDOFFX == VELOFFX
    vx = u[idx];
#elif FIELDCENTER == 1 && VELOFFX == 1
    vx = centerFromFace(u, idx, 1);
#elif FIELDOFFY == 1 && VELOFFY == 1
    // Y-face
    vx = 0.25f * (u[idx] + u[idx + 1] +
                  u[idx - ystride] + u[idx + 1 - ystride]);
#elif FIELDOFFZ == 1 && VELOFFZ == 1
    // Z-face
    vx = 0.25f * (u[idx] + u[idx - zstride] +
                  u[idx + 1] + u[idx + 1 - zstride]);
#else
    vx = trilinear_interp_val(x + VELOFFX * 0.5f, y, z, u,
                              offset, ystride, zstride,
			    NOPADX, PADY, PADZ);
#endif

#if FIELDOFFY == VELOFFY
    vy = v[idx];
#elif FIELDCENTER == 1 && VELOFFY == 1
    vy = centerFromFace(v, idx, ystride);
#elif FIELDOFFX == 1 && VELOFFX == 1
    // X-face
    vy = 0.25f * (v[idx] + v[idx + ystride] +
                  v[idx - 1] + v[idx - 1 + ystride]);
#elif FIELDOFFZ == 1 && VELOFFZ == 1
    // Z-face
    vy = 0.25f * (v[idx] + v[idx + ystride] +
                  v[idx - zstride] + v[idx + ystride - zstride]);
#else
    vy = trilinear_interp_val(x, y + VELOFFY * 0.5f, z, v,
                              offset, ystride, zstride,
			    PADX, NOPADY, PADZ);
#endif

#if FIELDOFFZ == VELOFFZ
    vz = w[idx];
#elif FIELDCENTER == 1 && VELOFFZ == 1
    vz = centerFromFace(w, idx, zstride);
#elif FIELDOFFX == 1 && VELOFFX == 1
    // X-face
    vz = 0.25f * (w[idx] + w[idx + zstride] +
                  w[idx - 1] + w[idx - 1 + zstride]);
#elif FIELDOFFY == 1 && VELOFFY == 1
    // Y-face
    vz = 0.25f * (w[idx] + w[idx + zstride] +
                  w[idx - ystride] + w[idx - ystride + zstride]);
#else
    vz = trilinear_interp_val(x, y, z + VELOFFZ * 0.5f, w,
                              offset, ystride, zstride,
			    PADX, PADY, NOPADZ);
#endif

    // Convert to voxel space;
    vx *= invhx;
    vy *= invhy;
    vz *= invhz;

#if ADVECTMETHOD == 1
    advectPositionTrace(&x, &y, &z, vx, vy, vz, dt, cfl,
                        u, v, w,
                        invhx, invhy, invhz,
                        offset, ystride, zstride);
#else
    // single Semi-lagrangian step
    x -= dt * vx;
    y -= dt * vy;
    z -= dt * vz;
#endif
    trilinear_interp(x + FIELDOFFX * 0.5f,
                     y + FIELDOFFY * 0.5f,
                     z + FIELDOFFZ * 0.5f,
                     phi, idx, phin, minphi, maxphi,
                     offset, ystride, zstride);
}

__kernel void
advectMinMax2d(float dt, float cfl,
                    __global const float *u,
                    __global const float *v,
                    __global const float *phi,
                    __global float *phin,
                    __global float *minphi,
                    __global float *maxphi,
                    float invhx, float invhy,
                    uint offset, uint xstride, uint ystride)
{
    size_t i = get_global_id(0);
    size_t j = get_global_id(1);

    size_t idx = offset + i * xstride + j * ystride;

    // Initial position in voxel space.
    float x = i - FIELDOFFX * 0.5f;
    float y = j - FIELDOFFY * 0.5f;

    // Initial velocity.
    float vx, vy;
#if FIELDOFFX == VELOFFX
    vx = u[idx];
#elif FIELDCENTER == 1 && VELOFFX == 1
    vx = centerFromFace(u, idx, xstride);
#else
    vx = bilinear_interp_val(x + VELOFFX * 0.5f, y, u,
                             offset, xstride, ystride);
#endif

#if FIELDOFFY == VELOFFY
    vy = v[idx];
#elif FIELDCENTER == 1 && VELOFFY == 1
    vy = centerFromFace(v, idx, ystride);
#else
    vy = bilinear_interp_val(x, y + VELOFFY * 0.5f, v,
                             offset, xstride, ystride);
#endif

    // Convert to voxel space;
    vx *= invhx;
    vy *= invhy;

#if ADVECTMETHOD == 1
    advectPositionTrace2d(&x, &y, vx, vy, dt, cfl,
                        u, v,
                        invhx, invhy,
                        offset, xstride, ystride);
#else
    // single Semi-lagrangian step
    x -= dt * vx;
    y -= dt * vy;
#endif
    bilinear_interp(x + FIELDOFFX * 0.5f, y + FIELDOFFY * 0.5f,
                    phi, idx, phin, minphi, maxphi,
                    offset, xstride, ystride);
}

// A bug in the AMD driver won't let us pass NULL for minphi and maxphi,
// so these functions just forwards to the minmax version passing 0 for
// those parameters.
__kernel void
advect(float dt, float cfl,
            __global const float *u,
            __global const float *v,
            __global const float *w,
            __global const float *phi,
            __global float *phin,
            float invhx, float invhy, float invhz,
            uint offset, uint ystride, uint zstride)
{
    advectMinMax(dt, cfl, u, v, w, phi, phin, 0, 0, invhx, invhy, invhz,
                 offset, ystride, zstride);
}

__kernel void
advect2d(float dt, float cfl,
            __global const float *u,
            __global const float *v,
            __global const float *phi,
            __global float *phin,
            float invhx, float invhy,
            uint offset, uint xstride, uint ystride)
{
    advectMinMax2d(dt, cfl, u, v, phi, phin, 0, 0, invhx, invhy,
                   offset, xstride, ystride);
}

__kernel void
limitRevert(__global float *phi,
            __global const float *oldphi,
            __global const float *minphi,
            __global const float *maxphi,
            uint offset, uint xstride, uint ystride, uint zstride)
{
    size_t idx = offset + get_global_id(0) * xstride +
                          get_global_id(1) * ystride +
                          get_global_id(2) * zstride;
    const float val = phi[idx];
    phi[idx] = select(oldphi[idx], val, minphi[idx] < val && val < maxphi[idx]);
}

__kernel void
limitClamp(__global float *phi,
           __global const float *oldphi,
           __global const float *minphi,
           __global const float *maxphi,
           uint offset, uint xstride, uint ystride, uint zstride)
{
    size_t idx = offset + get_global_id(0) * xstride +
                          get_global_id(1) * ystride +
                          get_global_id(2) * zstride;
    phi[idx] = clamp(phi[idx], minphi[idx], maxphi[idx]);
}


// buildOptions=-D NO_DOUBLE_SUPPORT -I testsuite/ocl/AppKernels/Houdini  -D FIELDOFFX=0 -D VELOFFX=1 -D FIELDOFFY=0 -D VELOFFY=1 -D FIELDOFFZ=0 -D VELOFFZ=1 -D ADVECTMETHOD=1
// RUN: %occ-cli %s --cl-options="-I%cwd -I%S -D NO_DOUBLE_SUPPORT -I testsuite/ocl/AppKernels/Houdini  -D FIELDOFFX=0 -D VELOFFX=1 -D FIELDOFFY=0 -D VELOFFY=1 -D FIELDOFFZ=0 -D VELOFFZ=1 -D ADVECTMETHOD=1" %cfg_path --cl-device=%cl_device 2>&1
