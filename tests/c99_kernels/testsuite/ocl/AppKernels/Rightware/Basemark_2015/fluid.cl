/**
* 2D Fluid simulation OpenCL implementation
*
* The code expects user to add define for GRID_SIZE to this file before compilation. If not found defaults to 64.
* This define is appended to the beginning of the file by the OpenCL benchmark by default.
*
* Copyright 2011 by Rightware. All rights reserved.
*/


#ifndef GRID_SIZE
#define GRID_SIZE 1024
#endif


#define N (GRID_SIZE-2)
#define INDEX(i,j) ((i)+(N+2)*(j))


#define NEW_DENSITIES_BUFFER_X 0 /**< X coordinate in new densities buffer. */
#define NEW_DENSITIES_BUFFER_Y 1 /**< Y coordinate in new densities buffer. */
#define NEW_DENSITIES_BUFFER_VALUE 2 /**< Y coordinate in new densities buffer. */
#define NEW_DENSITIES_BUFFER_ITEM_SIZE 3 /**< Size of one item in new densities buffer. */
#define NEW_DENSITIES_BUFFER_ITEMS 20 /**< Maximum number of items in new densities buffer. */

#define NEW_VELOCITIES_BUFFER_X 0 /**< X coordinate in new velocities buffer. */
#define NEW_VELOCITIES_BUFFER_Y 1 /**< Y coordinate in new velocities buffer. */
#define NEW_VELOCITIES_BUFFER_VEL_X 2 /**< X velocity in new velocities buffer. */
#define NEW_VELOCITIES_BUFFER_VEL_Y 3 /**< Y velocity in new velocities buffer. */
#define NEW_VELOCITIES_BUFFER_ITEM_SIZE 4 /**< Size of item in new velocities buffer. */
#define NEW_VELOCITIES_BUFFER_ITEMS 20 /**< Maximum number of items velocities buffer. */


__kernel void visualizeDensity(__write_only image2d_t dst_image, __global float* density)
{
    //const sampler_t sampler = CLK_NORMALIZED_COORDS_FALSE | CLK_ADDRESS_CLAMP | CLK_FILTER_NEAREST;
    const int size = GRID_SIZE;

    int x = get_global_id(0);
    int y = get_global_id(1);

    float dens = density[(y) * size + x];
    float4 bgcolor = (float4)(1.0f, 1.0f, 1.0f, 0.0f);
    float4 forecolor = (float4)(0.42f, 0.68f, 0.8f, 1.0f);

    float4 color = bgcolor + (forecolor - bgcolor) * dens;

    write_imagef(dst_image,(int2)(x,y),color);
}

__kernel void linSolve(__global const float* restrict x, __global const float* restrict x0, __global float* restrict outx, float a, float c)
{
    if (get_global_id(0) >= GRID_SIZE-2 || get_global_id(1) >= GRID_SIZE-2) return; // enforce standard work group sizes, 1024x1024 instead of 1022x1022, ttykkala 19052015
    int i = get_global_id(0)+1;
    int j = get_global_id(1)+1;

    outx[INDEX(i,j)] = (x0[INDEX(i,j)] + a*(x[INDEX(i-1,j)] + x[INDEX(i+1,j)] + x[INDEX(i,j-1)] + x[INDEX(i,j+1)]))/c;
}

__kernel void advect(__global float* d, __global float* d0, __global float* u, __global float* v, float dt0)
{
    float x,y,s0,t0,s1,t1;
    int i0, j0, i1, j1;
    int i = get_global_id(0);
    int j = get_global_id(1);

    x = (float)i - dt0 * (float)u[INDEX(i,j)];
    y = (float)j - dt0 * (float)v[INDEX(i,j)];

    if(x < 0.5f)
    {
        x = 0.5f;
    }
    if(x > N + 0.5f)
    {
        x = N + 0.5f;
    }

    i0 = (int)x;
    i1 = i0 + 1;

    if(y < 0.5f)
    {
        y = 0.5f;
    }
    if(y > N + 0.5f)
    {
        y = N + 0.5f;
    }

    j0 = (int)y;
    j1 = j0+1;
    s1 = x-i0;
    s0 = 1-s1;
    t1 = y-j0;
    t0 = 1-t1;

    d[INDEX(i,j)] = s0*(t0*d0[INDEX(i0,j0)] + t1*d0[INDEX(i0,j1)]) + s1*(t0*d0[INDEX(i1,j0)] + t1*d0[INDEX(i1,j1)]);
}

__kernel void project1(__global float* div, __global float* u, __global float* v, __global float* p)
{
	if (get_global_id(0) >= GRID_SIZE-2 || get_global_id(1) >= GRID_SIZE-2) return; // enforce standard work group sizes, 1024x1024 instead of 1022x1022, ttykkala 19052015
    int i = get_global_id(0)+1;
    int j = get_global_id(1)+1;
    div[INDEX(i,j)] = -0.5f*(u[INDEX(i+1,j)]-u[INDEX(i-1,j)]+v[INDEX(i,j+1)]-v[INDEX(i,j-1)])/N;
    p[INDEX(i,j)] = 0;
}

__kernel void project2(__global float* u, __global float* v, __global float* p)
{
    if (get_global_id(0) >= GRID_SIZE-2 || get_global_id(1) >= GRID_SIZE-2) return; // enforce standard work group sizes, 1024x1024 instead of 1022x1022, ttykkala 19052015
    int i = get_global_id(0)+1;
    int j = get_global_id(1)+1;
    u[INDEX(i,j)] -= 0.5f*N*(p[INDEX(i+1,j)]-p[INDEX(i-1,j)]);
    v[INDEX(i,j)] -= 0.5f*N*(p[INDEX(i,j+1)]-p[INDEX(i,j-1)]);
}

__kernel void addSource(__global float* x, __global float* s, float dt)
{
    int i = get_global_id(0);
    int j = get_global_id(1);
    int pos = INDEX(i,j);
    x[pos] += dt * s[pos];
}

__kernel void setBounds(__global float* x, int b)
{
	if (get_global_id(0) >= GRID_SIZE-2) return; // enforce standard work group sizes, 1024x1024 instead of 1022x1022, ttykkala 19052015

    int i = get_global_id(0) + 1;

    x[INDEX(0, i)] = b==1 ? -x[INDEX(1,i)] : x[INDEX(1,i)];
    x[INDEX(N+1, i)] = b==1 ? -x[INDEX(N,i)] : x[INDEX(N,i)];
    x[INDEX(i, 0)] = b==2 ? -x[INDEX(i,1)] : x[INDEX(i,1)];
    x[INDEX(i, N+1)] = b==2 ? -x[INDEX(i,N)] : x[INDEX(i,N)];
}

__kernel void setCornerBounds(__global float* x, int b)
{
    x[INDEX(0, 0)] = 0.5f * (x[INDEX(1, 0)] + x[INDEX(0, 1)]);
    x[INDEX(0, N+1)] = 0.5f * (x[INDEX(1, N+1)] + x[INDEX(0, N)]);
    x[INDEX(N+1, 0)] = 0.5f * (x[INDEX(N, 0)] + x[INDEX(N+1, 1)]);
    x[INDEX(N+1, N+1)] = 0.5f * (x[INDEX(N, N+1)] + x[INDEX(N+1, N)]);
}

__kernel void addForcesAndDensity(__global float* d, __global float* u, __global float* v, __global float* newD, __global float* newV)
{
    int n;
    int i = get_global_id(0);
    int j = get_global_id(1);
    int id = INDEX(i, j);

    u[id] = 0.0f;
    v[id] = 0.0f;
    d[id] = 0.0f;

    for(n = 0; n < NEW_VELOCITIES_BUFFER_ITEMS; n++)
    {
        int offset = n * NEW_VELOCITIES_BUFFER_ITEM_SIZE;
        int x = newV[offset + NEW_VELOCITIES_BUFFER_X];
        int y = newV[offset + NEW_VELOCITIES_BUFFER_Y];
        if(x == i && y == j)
        {
            u[id] = newV[offset + NEW_VELOCITIES_BUFFER_VEL_X];
            v[id] = newV[offset + NEW_VELOCITIES_BUFFER_VEL_Y];
        }
    }

    for(n = 0; n < NEW_DENSITIES_BUFFER_ITEMS; n++)
    {
        int offset = n * NEW_DENSITIES_BUFFER_ITEM_SIZE;
        int x = newD[offset + NEW_DENSITIES_BUFFER_X];
        int y = newD[offset + NEW_DENSITIES_BUFFER_Y];
        if(x == i && y == j)
        {
            d[id] = newD[offset + NEW_DENSITIES_BUFFER_VALUE];
        }
    }
}


// buildOptions=
// RUN: %occ-cli %s --cl-options="-I%cwd -I%S " %cfg_path --cl-device=%cl_device 2>&1
