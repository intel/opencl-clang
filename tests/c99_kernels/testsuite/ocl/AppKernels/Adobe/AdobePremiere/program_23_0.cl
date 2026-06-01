
#ifndef GFKERNELSUPPORT_KERNELCORE_H
#define GFKERNELSUPPORT_KERNELCORE_H

#define GF_DEVICE_TARGET_CUDA 0

#define GF_DEVICE_TARGET_OPENCL 1

#define GF_DEVICE_TARGET_HOST 0

#define GF_KERNEL __kernel void

#define GF_DEVICE_FUNCTION

#define GF_HOST_FUNCTION

#define GF_CONSTANT(T) __constant T

#define GF_CONSTANT_PTR(T) GF_PTR(T)

#define GF_CUDA_CONSTANT(T, N)

#define GF_OPENCL_CONSTANT(T, N) GF_PTR(T) N

#define GF_GET_CONSTANT(P) P

#define GF_STATIC_CONSTANT_PTR(T) GF_CONSTANT(T*)

#define GF_SHARED(T) __local T

#define GF_SHARED_PTR(T) __local T*

#define GF_PTR(T) __global T*

#define GF_ALIGN(N) __attribute__ ((aligned (N)))

#define GF_FASTMULTIPLY(X, Y) mul24(X, Y)

#define GF_READ2D(I, R, X, Y) (I)[GF_FASTMULTIPLY(Y, R) + (X)]

#define GF_WRITE2D(P, I, R, X, Y) (I)[GF_FASTMULTIPLY(Y, R) + (X)] = (P)

#define GF_CUDA_TEXTURE(C, N)

#define GF_CUDA_NORMALIZED_TEXTURE(C, N)

#define GF_OPENCL_TEXTURE(N) __read_only image2d_t N

#define GF_GET_TEXTURE(T) T

#define GF_READTEXTURE(I, X, Y, S) read_imagef(I, S, (float2)(X, Y))

#ifndef make_int2
#define make_int2(X, Y) (int2)(X, Y)
#endif

#ifndef make_float4
#define make_float4(X, Y, Z, W) (float4)(X, Y, Z, W)
#endif

#ifndef make_float3
#define make_float3(X, Y, Z) (float3)(X, Y, Z)
#endif

#ifndef make_float2
#define make_float2(X, Y) (float2)(X, Y)
#endif

#ifndef make_uchar4
#define make_uchar4(X, Y, Z, W) (uchar4)(X, Y, Z, W)
#endif

#ifndef make_ushort4
#define make_ushort4(X, Y, Z, W) (ushort4)(X, Y, Z, W)
#endif

#ifndef make_uint4
#define make_uint4(X, Y, Z, W) (uint4)(X, Y, Z, W)
#endif
GF_DEVICE_FUNCTION int KernelX() { return get_global_id(0); } GF_DEVICE_FUNCTION int KernelY() { return get_global_id(1); } GF_DEVICE_FUNCTION int2 ThreadID() { return make_int2(get_local_id(0), get_local_id(1)); } GF_DEVICE_FUNCTION int2 BlockID() { return make_int2(get_group_id(0), get_group_id(1)); } GF_DEVICE_FUNCTION int2 BlockSize() { return make_int2(get_local_size(0), get_local_size(1)); } GF_DEVICE_FUNCTION float saturate(float inX) { return clamp(inX, 0.0f, 1.0f); } GF_DEVICE_FUNCTION void SyncThreads() { barrier(CLK_LOCAL_MEM_FENCE); }
#endif
float GET_POLYPOINT_X(__constant float* pts, int i); float GET_POLYPOINT_Y(__constant float* pts, int i); float GET_POLYPOINT_Z(__constant float* pts, int i); float GET_POLYPOINT_X(__constant float* pts, int i) { return pts[i*3]; } float GET_POLYPOINT_Y(__constant float* pts, int i) { return pts[(i)*3+1]; } float GET_POLYPOINT_Z(__constant float* pts, int i) { return pts[(i)*3+2]; } __kernel void amdcl_kernel_gm16_inplace( __global float* dstFrame, int width, __constant float *polyPoints ) { int py = get_global_id(1); const int NUMPOINTS = 16; float x_intersect[16]; for(int n=0; n<NUMPOINTS; n++) { if( py>=GET_POLYPOINT_Y(polyPoints,n) == py<GET_POLYPOINT_Y(polyPoints,n+1)) { float x_walk = GET_POLYPOINT_Z(polyPoints,n) * (py - GET_POLYPOINT_Y(polyPoints,n)); x_intersect[n] = GET_POLYPOINT_X(polyPoints,n) + x_walk; } else x_intersect[n] = -1.f; } int px = get_global_id(0); int pidx = py * width + px; const int wgWidth = get_local_size(0); while( px < width ) { int inside = 0; for(int n=0; n<NUMPOINTS; n++) { if(px < x_intersect[n]) inside ^= 1; } if(!inside) { dstFrame[(pidx<<2)+3] = 0.f; } px += wgWidth; pidx += wgWidth; } } __kernel void amdcl_kernel_gm16_inplace_by4( __global float* dstFrame, int width, __constant float *polyPoints ) { int py = get_global_id(1); const int NUMPOINTS = 16; float x_intersect[16]; for(int n=0; n<NUMPOINTS; n++) { if( py>=GET_POLYPOINT_Y(polyPoints,n) == py<GET_POLYPOINT_Y(polyPoints,n+1)) { float x_walk = GET_POLYPOINT_Z(polyPoints,n) * (py - GET_POLYPOINT_Y(polyPoints,n)); x_intersect[n] = GET_POLYPOINT_X(polyPoints,n) + x_walk; } else x_intersect[n] = -1.f; } int px = get_global_id(0); int pidxBase = py*width*4; const int wgWidth = get_local_size(0); int4 pxOffset = (int4)(0,wgWidth,wgWidth*2,wgWidth*3); while( px < width ) { int4 inside = (int4)0; int4 vpx = px+pxOffset; for(int n=0; n<NUMPOINTS; n++) { if(vpx.x < x_intersect[n]) inside.x ^= 1; if(vpx.y < x_intersect[n]) inside.y ^= 1; if(vpx.z < x_intersect[n]) inside.z ^= 1; if(vpx.w < x_intersect[n]) inside.w ^= 1; } int4 pidx = pidxBase+(vpx<<2)+3; if(!inside.x && vpx.x<width) { dstFrame[pidx.x] = 0.f; } if(!inside.y && vpx.y<width) { dstFrame[pidx.y] = 0.f; } if(!inside.z && vpx.z<width) { dstFrame[pidx.z] = 0.f; } if(!inside.w && vpx.w<width) { dstFrame[pidx.w] = 0.f; } px += (wgWidth<<2); } } __kernel void amdcl_kernel_gm8_inplace( __global float* dstFrame, int width, __constant float *polyPoints ) { int py = get_global_id(1); const int NUMPOINTS = 8; float x_intersect[8]; for(int n=0; n<NUMPOINTS; n++) { if( py>=GET_POLYPOINT_Y(polyPoints,n) == py<GET_POLYPOINT_Y(polyPoints,n+1)) { float x_walk = GET_POLYPOINT_Z(polyPoints,n) * (py - GET_POLYPOINT_Y(polyPoints,n)); x_intersect[n] = GET_POLYPOINT_X(polyPoints,n) + x_walk; } else x_intersect[n] = -1.f; } int px = get_global_id(0); int pidx = py * width + px; const int wgWidth = get_local_size(0); while( px < width ) { int inside = 0; for(int n=0; n<NUMPOINTS; n++) { if(px < x_intersect[n]) inside ^= 1; } if(!inside) { dstFrame[(pidx<<2)+3] = 0.f; } px += wgWidth; pidx += wgWidth; } } __kernel void amdcl_kernel_gm8_inplace_by4( __global float* dstFrame, int width, __constant float *polyPoints ) { int py = get_global_id(1); const int NUMPOINTS = 8; float x_intersect[8]; for(int n=0; n<NUMPOINTS; n++) { if( py>=GET_POLYPOINT_Y(polyPoints,n) == py<GET_POLYPOINT_Y(polyPoints,n+1)) { float x_walk = GET_POLYPOINT_Z(polyPoints,n) * (py - GET_POLYPOINT_Y(polyPoints,n)); x_intersect[n] = GET_POLYPOINT_X(polyPoints,n) + x_walk; } else x_intersect[n] = -1.f; } int px = get_global_id(0); int pidxBase = py*width*4; const int wgWidth = get_local_size(0); int4 pxOffset = (int4)(0,wgWidth,wgWidth*2,wgWidth*3); while( px < width ) { int4 inside = (int4)0; int4 vpx = px+pxOffset; for(int n=0; n<NUMPOINTS; n++) { if(vpx.x < x_intersect[n]) inside.x ^= 1; if(vpx.y < x_intersect[n]) inside.y ^= 1; if(vpx.z < x_intersect[n]) inside.z ^= 1; if(vpx.w < x_intersect[n]) inside.w ^= 1; } int4 pidx = pidxBase+(vpx<<2)+3; if(!inside.x && vpx.x<width) { dstFrame[pidx.x] = 0.f; } if(!inside.y && vpx.y<width) { dstFrame[pidx.y] = 0.f; } if(!inside.z && vpx.z<width) { dstFrame[pidx.z] = 0.f; } if(!inside.w && vpx.w<width) { dstFrame[pidx.w] = 0.f; } px += (wgWidth<<2); } } __kernel void amdcl_kernel_gm4_inplace( __global float* dstFrame, int width, __constant float *polyPoints ) { int py = get_global_id(1); const int NUMPOINTS = 4; float x_intersect[4]; for(int n=0; n<NUMPOINTS; n++) { if( py>=GET_POLYPOINT_Y(polyPoints,n) == py<GET_POLYPOINT_Y(polyPoints,n+1)) { float x_walk = GET_POLYPOINT_Z(polyPoints,n) * (py - GET_POLYPOINT_Y(polyPoints,n)); x_intersect[n] = GET_POLYPOINT_X(polyPoints,n) + x_walk; } else x_intersect[n] = -1.f; } int px = get_global_id(0); int pidx = py * width + px; const int wgWidth = get_local_size(0); while( px < width ) { int inside = 0; for(int n=0; n<NUMPOINTS; n++) { if(px < x_intersect[n]) inside ^= 1; } if(!inside) { dstFrame[(pidx<<2)+3] = 0.f; } px += wgWidth; pidx += wgWidth; } } __kernel void amdcl_kernel_gm4_inplace_by4( __global float* dstFrame, int width, __constant float *polyPoints ) { int py = get_global_id(1); const int NUMPOINTS = 4; float x_intersect[4]; for(int n=0; n<NUMPOINTS; n++) { if( py>=GET_POLYPOINT_Y(polyPoints,n) == py<GET_POLYPOINT_Y(polyPoints,n+1)) { float x_walk = GET_POLYPOINT_Z(polyPoints,n) * (py - GET_POLYPOINT_Y(polyPoints,n)); x_intersect[n] = GET_POLYPOINT_X(polyPoints,n) + x_walk; } else x_intersect[n] = -1.f; } int px = get_global_id(0); int pidxBase = py*width*4; const int wgWidth = get_local_size(0); int4 pxOffset = (int4)(0,wgWidth,wgWidth*2,wgWidth*3); while( px < width ) { int4 inside = (int4)0; int4 vpx = px+pxOffset; for(int n=0; n<NUMPOINTS; n++) { if(vpx.x < x_intersect[n]) inside.x ^= 1; if(vpx.y < x_intersect[n]) inside.y ^= 1; if(vpx.z < x_intersect[n]) inside.z ^= 1; if(vpx.w < x_intersect[n]) inside.w ^= 1; } int4 pidx = pidxBase+(vpx<<2)+3; if(!inside.x && vpx.x<width) { dstFrame[pidx.x] = 0.f; } if(!inside.y && vpx.y<width) { dstFrame[pidx.y] = 0.f; } if(!inside.z && vpx.z<width) { dstFrame[pidx.z] = 0.f; } if(!inside.w && vpx.w<width) { dstFrame[pidx.w] = 0.f; } px += (wgWidth<<2); } }

// buildOptions= -cl-single-precision-constant -cl-fast-relaxed-math
// RUN: %occ-cli %s --cl-options="-I%cwd -I%S  -cl-single-precision-constant -cl-fast-relaxed-math" %cfg_path --cl-device=%cl_device 2>&1
