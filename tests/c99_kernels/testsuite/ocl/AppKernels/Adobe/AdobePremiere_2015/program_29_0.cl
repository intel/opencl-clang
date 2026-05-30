
#ifndef GFKERNELSUPPORT_PIXELYUV_H
#define GFKERNELSUPPORT_PIXELYUV_H

#ifndef GFKERNELSUPPORT_PIXELRGB_H
#define GFKERNELSUPPORT_PIXELRGB_H

#ifndef GFDEVICEPIXELFORMAT_H
#define GFDEVICEPIXELFORMAT_H

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

#define GF_CUDA_SHARED_DYNAMIC(T, N)

#define GF_OPENCL_SHARED_DYNAMIC(T, N) GF_SHARED_PTR(T) N

#define GF_PTR(T) __global T*

#define GF_ALIGN(N) __attribute__ ((aligned (N)))

#define GF_FASTMULTIPLY(X, Y) mul24(X, Y)

#define GF_READ2D(I, R, X, Y) (I)[GF_FASTMULTIPLY(Y, R) + (X)]

#define GF_WRITE2D(P, I, R, X, Y) (I)[GF_FASTMULTIPLY(Y, R) + (X)] = (P)

#define GF_TEXTURE(T, N, S) constant sampler_t kSampler_##N = S;
#define GF_NORMALIZED_TEXTURE(T, N, S) constant sampler_t kSampler_##N = S;
#define GF_OPENCL_TEXTURE(N) __read_only image2d_t N

#define GF_GET_TEXTURE(T) T

#define GF_READTEXTURE(I, X, Y) read_imagef(I, kSampler_##I, (float2)(X, Y))

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
typedef enum { kDevicePixelFormat_BGRA_4444_16f, kDevicePixelFormat_BGRA_4444_32f, } DevicePixelFormat;
#endif
typedef struct { float b, g, r, a; } GF_ALIGN(16) PixelRGB; GF_DEVICE_FUNCTION PixelRGB BGRA( float inB, float inG, float inR, float inA) { PixelRGB pixel; pixel.b = inB; pixel.g = inG; pixel.r = inR; pixel.a = inA; return pixel; } GF_DEVICE_FUNCTION float4 ConvertRGB_To_Components( PixelRGB inPixel) { return *(float4*)&inPixel; } GF_DEVICE_FUNCTION PixelRGB ConvertComponents_To_RGB( float4 inPixel) { return *(PixelRGB*)&inPixel; }GF_DEVICE_FUNCTION float4 ReadPixelIndex( const GF_PTR(float4) inImage, DevicePixelFormat inDeviceFormat, int inIndex) {
#if GF_OPENCL_SUPPORTS_16F
 if (inDeviceFormat == kDevicePixelFormat_BGRA_4444_16f) { return vload_half4(inIndex, (const GF_PTR(half))inImage); }
#endif
 return inImage[inIndex]; } GF_DEVICE_FUNCTION void WritePixelIndex( float4 inPixel, GF_PTR(float4) outImage, DevicePixelFormat inDeviceFormat, int inIndex) {
#if GF_OPENCL_SUPPORTS_16F
 if (inDeviceFormat == kDevicePixelFormat_BGRA_4444_16f) { vstore_half4_rtz(inPixel, inIndex, (GF_PTR(half))outImage); } else
#endif
 { outImage[inIndex] = inPixel; } }GF_DEVICE_FUNCTION float4 ReadPixel( const GF_PTR(float4) inImage, int inPitch, DevicePixelFormat inDeviceFormat, int inX, int inY) { return ReadPixelIndex(inImage, inDeviceFormat, GF_FASTMULTIPLY(inY, inPitch) + inX); } GF_DEVICE_FUNCTION void WritePixel( float4 inPixel, GF_PTR(float4) outImage, int inPitch, DevicePixelFormat inDeviceFormat, int inX, int inY) { WritePixelIndex(inPixel, outImage, inDeviceFormat, GF_FASTMULTIPLY(inY, inPitch) + inX); } GF_DEVICE_FUNCTION PixelRGB ReadRGBPixel( const GF_PTR(float4) inImage, int inPitch, DevicePixelFormat inDeviceFormat, int inX, int inY) { return ConvertComponents_To_RGB(ReadPixel(inImage, inPitch, inDeviceFormat, inX, inY)); } GF_DEVICE_FUNCTION void WriteRGBPixel( PixelRGB inPixel, GF_PTR(float4) outImage, int inPitch, DevicePixelFormat inDeviceFormat, int inX, int inY) { WritePixel(ConvertRGB_To_Components(inPixel), outImage, inPitch, inDeviceFormat, inX, inY); }
#define GF_READTEXTUREPIXEL(I, X, Y) ConvertComponents_To_RGB(GF_READTEXTURE(I, X, Y))

#endif

#ifndef GFKERNELSUPPORT_COLORSPACECONVERT_H
#define GFKERNELSUPPORT_COLORSPACECONVERT_H
GF_CONSTANT(float) kRGB32f_To_601YPbPr[9] = { 0.299f , 0.587f , 0.114f, -0.168736f, -0.331264f, 0.5f, 0.5f , -0.418688f, -0.081312f, }; GF_CONSTANT(float) k601YPbPr_To_RGB32f[9] = { 1.0f, 0.0f , 1.402f, 1.0f, -0.344136f, -0.714136f, 1.0f, 1.772f , 0.0f, }; GF_CONSTANT(float) kRGB32f_To_601YCbCr[9] = { 65.481f, 128.553f, 24.966f, -37.797f, -74.203f , 112.0f, 112.0f , -93.786f , -18.214f, }; GF_CONSTANT(float) k601YCbCr_To_RGB32f[9] = { 0.00456621f, 0.0f , 0.00625893f, 0.00456621f, -0.00153396f, -0.00318811f, 0.00456621f, 0.00791071f, 0.0f, }; GF_CONSTANT(float) kRGB8u_To_601YCbCr[9] = { 65.738f / 256.0f, 129.057f / 256.0f, 25.064f / 256.0f, -37.945f / 256.0f, -74.494f / 256.0f, 112.439f / 256.0f, 112.439f / 256.0f, -94.154f / 256.0f, -18.285f / 256.0f, }; GF_CONSTANT(float) k601YCbCr_To_RGB8u[9] = { 298.082f / 256.0f, 0.0f , 408.583f / 256.0f, 298.082f / 256.0f, -100.291f / 256.0f, -208.120f / 256.0f, 298.082f / 256.0f, 516.411f / 256.0f, 0.0f, }; GF_CONSTANT(float) kRGB8u_To_601YCbCrFullRange[9] = { 76.544 / 256.0f, 150.272 / 256.0f, 29.184 / 256.0f, -43.027 / 256.0f, -84.471 / 256.0f, 127.498 / 256.0f, 127.498 / 256.0f, -106.764 / 256.0f, -20.734 / 256.0f, }; GF_CONSTANT(float) k601YCbCrFullRange_To_RGB8u[9] = { 1.0f, 0.0f , 357.510 / 256.0f, 1.0f, -87.755 / 256.0f, -182.105 / 256.0f, 1.0f, 451.860 / 256.0f, 0.0f, }; GF_CONSTANT(float) kRGB32f_To_601YCbCrFullRange[9] = { 76.245f, 149.685f, 29.07f, -42.859f, -84.141f , 127.0f, 127.0f , -106.347f, -20.653f, }; GF_CONSTANT(float) k601YCbCrFullRange_To_RGB32f[9] = { 1.0f / 255.0f, 0.0f , 357.510 / 65280.0f, 1.0f / 255.0f, -87.755 / 65280.0f, -182.105 / 65280.0f, 1.0f / 255.0f, 451.860 / 65280.0f, 0.0f, }; GF_CONSTANT(float) kRGB32f_To_709YPbPr[9] = { 0.2126f , 0.7152f , 0.0722f, -0.114572f, -0.385428f, 0.5f, 0.5f , -0.454153f, -0.045847f, }; GF_CONSTANT(float) k709YPbPr_To_RGB32f[9] = { 1.0f, 0.0f , 1.5748f, 1.0f, -0.187324f, -0.468124f, 1.0f, 1.8556f , 0.0f, }; GF_CONSTANT(float) kRGB32f_To_709YCbCr[9] = { 46.559f, 156.629f, 15.812f, -25.664f, -86.336f , 112.0f, 112.0f , -101.730f, -10.270f, }; GF_CONSTANT(float) k709YCbCr_To_RGB32f[9] = { 0.00456621f, 0.0f , 0.00703036f, 0.00456621f, -0.00083627f, -0.00208984f, 0.00456621f, 0.00828393f, 0.0f, }; GF_CONSTANT(float) k709YCbCrFullRange_To_RGB32f[9] = { 0.00392157f, 0.0f , 0.00615157f, 0.00392157f, -0.00073174f, -0.00182861f, 0.00392157f, 0.00724844f, 0.0f, }; GF_CONSTANT(float) kRGB8u_To_709YCbCr[9] = { 46.742f / 256.0f, 157.243f / 256.0f, 15.874f / 256.0f, -25.765f / 256.0f, -86.674f / 256.0f, 112.439f / 256.0f, 112.439f / 256.0f, -102.129f / 256.0f, -10.310f / 256.0f, }; GF_CONSTANT(float) k709YCbCr_To_RGB8u[9] = { 298.082f / 256.0f, 0.0f , 458.942f / 256.0f, 298.082f / 256.0f, -54.592f / 256.0f, -136.425f / 256.0f, 298.082f / 256.0f, 540.775f / 256.0f, 0.0f, }; GF_CONSTANT(float) k709YCbCr_To_601YCbCr[9] = { 1.0f, 0.099312f, 0.191700f, 0.0f, 0.989854f, -0.110653f, 0.0f, -0.072453f, 0.983398f, }; GF_CONSTANT(float) k601YCbCr_To_709YCbCr[9] = { 1.0f, -0.115550f, -0.207938f, 0.0f, 1.018640f, 0.114618f, 0.0f, 0.075049f, 1.025327f, }; GF_CONSTANT(float) kYCbCrOffset[3] = { 16.0f, 128.0f, 128.0f, }; GF_CONSTANT(float) kYCbCrFullRangeOffset[3] = { 0.0f, 128.0f, 128.0f, }; GF_DEVICE_FUNCTION float4 SwapComponentOrder( float4 inV) { float4 result = { inV.w, inV.z, inV.y, inV.x }; return result; } GF_DEVICE_FUNCTION float4 ColorSpaceConvert( float4 inPixel, GF_STATIC_CONSTANT_PTR(float) inMatrix) { return make_float4( inPixel.x, inPixel.y * inMatrix[0] + inPixel.z * inMatrix[1] + inPixel.w * inMatrix[2], inPixel.y * inMatrix[3] + inPixel.z * inMatrix[4] + inPixel.w * inMatrix[5], inPixel.y * inMatrix[6] + inPixel.z * inMatrix[7] + inPixel.w * inMatrix[8]); }
#endif
typedef struct { float a, v, u, y; } GF_ALIGN(16) PixelYUV; GF_DEVICE_FUNCTION PixelYUV ConvertRGB_To_YUV( PixelRGB inPixel) { float4 floatPixel = ColorSpaceConvert( SwapComponentOrder( ConvertRGB_To_Components(inPixel)), kRGB32f_To_601YPbPr); PixelYUV result; result.a = floatPixel.x; result.y = floatPixel.y; result.u = floatPixel.z; result.v = floatPixel.w; return result; } GF_DEVICE_FUNCTION PixelRGB ConvertYUV_To_RGB( PixelYUV inPixel) { return ConvertComponents_To_RGB( SwapComponentOrder( ColorSpaceConvert( make_float4( inPixel.a, inPixel.y, inPixel.u, inPixel.v), k601YPbPr_To_RGB32f))); }
#endif
GF_DEVICE_FUNCTION float ReadFloat( const GF_PTR(float) inImage, int inIndex, DevicePixelFormat inDeviceFormat) {
#if GF_OPENCL_SUPPORTS_16F
 if (inDeviceFormat == kDevicePixelFormat_BGRA_4444_16f) { return saturate(vload_half(inIndex, (const GF_PTR(half))inImage)); } else
#endif
 return saturate(inImage[inIndex]); } GF_DEVICE_FUNCTION void WriteFloat( GF_PTR(float) inImage, int inIndex, float inValue, DevicePixelFormat inDeviceFormat) {
#if GF_OPENCL_SUPPORTS_16F
 if (inDeviceFormat == kDevicePixelFormat_BGRA_4444_16f) { vstore_half(saturate(inValue), inIndex, (GF_PTR(half))inImage); } else
#endif
 inImage[inIndex] = saturate(inValue); }GF_KERNEL VerticalRecursiveGaussianGray_kernel( GF_PTR(float) pOut, GF_PTR(float) pIn, int width, int height, int pitch_f, DevicePixelFormat device_format, float n_plus0, float n_plus1, float neg_d_plus1, float neg_d_plus2, float n_minus1, float n_minus2, float neg_d_minus1, float neg_d_minus2, float inHoldEdge) { int X = KernelX(); if( X > width ) return; int gmem_idx = X; float new_in = ReadFloat(pIn, gmem_idx, device_format) * inHoldEdge; float prev_in = new_in; float prev_in2 = new_in; new_in *= 0.5f; float prev_out = new_in; float prev_out2 = new_in; float result; int Y = 0;
#pragma unroll 32
for(;Y < height; Y++) { new_in = ReadFloat(pIn, gmem_idx, device_format); result = n_plus0*new_in + n_plus1*prev_in + neg_d_plus1*prev_out + neg_d_plus2*prev_out2; prev_in = new_in; prev_out2 = prev_out; prev_out = result; WriteFloat(pOut, gmem_idx, result, device_format); gmem_idx += pitch_f; } new_in = ReadFloat(pIn, gmem_idx - pitch_f, device_format) * inHoldEdge; prev_in = new_in; prev_in2 = new_in; new_in *= 0.5f; prev_out = new_in; prev_out2 = new_in;
#pragma unroll 32
for(;Y > 0; Y--) { gmem_idx -= pitch_f; result = n_minus1*prev_in + n_minus2*prev_in2 + neg_d_minus1*prev_out + neg_d_minus2*prev_out2; prev_in2 = prev_in; prev_in = ReadFloat(pIn, gmem_idx, device_format); prev_out2 = prev_out; prev_out = result; WriteFloat(pOut, gmem_idx, result + ReadFloat(pOut, gmem_idx, device_format), device_format); } }
#define GRAY_TILE_W 32
#define GRAY_SMEM_W (GRAY_TILE_W + 1)
#define GRAY_TILE_H 32
GF_KERNEL HorizontalRecursiveGaussianGray_kernel( GF_PTR(float) pOut, GF_PTR(float) pIn, int width, int height, int pitch_f, DevicePixelFormat device_format, float n_plus0, float n_plus1, float neg_d_plus1, float neg_d_plus2, float n_minus1, float n_minus2, float neg_d_minus1, float neg_d_minus2, float inHoldEdge) { GF_SHARED(float) smem[GRAY_SMEM_W * GRAY_TILE_H]; int blockX = 0; int Y = GF_FASTMULTIPLY(BlockID().y, GRAY_TILE_H) + ThreadID().y; int gmem_base = Y * pitch_f; float new_in = ThreadID().y == 0 && (Y + ThreadID().x) < height && inHoldEdge > 0.0f ? ReadFloat(pIn, gmem_base + (ThreadID().x * pitch_f), device_format) * inHoldEdge : 0.0f; float prev_in = new_in; float prev_in2 = new_in; new_in *= 0.5f; float prev_out = new_in; float prev_out2 = new_in; float result; while(blockX < width) { int gmem_idx = gmem_base + blockX + ThreadID().x; int rw_smem_idx = GF_FASTMULTIPLY(ThreadID().y, GRAY_SMEM_W) + ThreadID().x;
#pragma unroll 4
for(int i=0;i<4;i++) { if(Y + (i<<3) < height) { if(blockX + ThreadID().x < width) smem[rw_smem_idx] = ReadFloat(pIn, gmem_idx, device_format); else smem[rw_smem_idx] = 0; } gmem_idx += (pitch_f << 3); rw_smem_idx += (GRAY_SMEM_W * 8); } SyncThreads(); if(ThreadID().y == 0) { int proc_smem_idx = GF_FASTMULTIPLY(ThreadID().x, GRAY_SMEM_W);
#pragma unroll 32
for(int i=0;i<32 ;i++) { new_in = smem[proc_smem_idx]; result = n_plus0*new_in + n_plus1*prev_in + neg_d_plus1*prev_out + neg_d_plus2*prev_out2; prev_in = new_in; prev_out2 = prev_out; prev_out = result; smem[proc_smem_idx] = result; proc_smem_idx++; } } SyncThreads(); gmem_idx = gmem_base + blockX + ThreadID().x; rw_smem_idx = GF_FASTMULTIPLY(ThreadID().y, GRAY_SMEM_W) + ThreadID().x;
#pragma unroll 4
for(int i=0;i<4;i++) { if(Y + (i<<3) < height) { if(blockX + ThreadID().x < width) WriteFloat(pOut, gmem_idx, smem[rw_smem_idx], device_format); } gmem_idx += (pitch_f << 3); rw_smem_idx += (GRAY_SMEM_W * 8); } SyncThreads(); blockX += GRAY_TILE_W; } new_in = ThreadID().y == 0 && (Y + ThreadID().x) < height && inHoldEdge > 0.0f ? ReadFloat(pIn, gmem_base + width - 1 + (ThreadID().x * pitch_f), device_format) * inHoldEdge : 0.0f; prev_in = new_in; prev_in2 = new_in; new_in *= 0.5f; prev_out = new_in; prev_out2 = new_in; while(blockX > 0) { blockX -= GRAY_TILE_W; int gmem_idx = gmem_base + blockX + ThreadID().x; int rw_smem_idx = GF_FASTMULTIPLY(ThreadID().y, GRAY_SMEM_W) + ThreadID().x;
#pragma unroll 4
for(int i=0;i<4;i++) { if(Y + (i<<3) < height) { if(blockX + ThreadID().x < width) smem[rw_smem_idx] = ReadFloat(pIn, gmem_idx, device_format); else smem[rw_smem_idx] = 0; } gmem_idx += (pitch_f << 3); rw_smem_idx += (GRAY_SMEM_W * 8); } SyncThreads(); if(ThreadID().y == 0) { int proc_smem_idx = GF_FASTMULTIPLY(ThreadID().x, GRAY_SMEM_W) + GRAY_TILE_W -1;
#pragma unroll 32
for(int i=31;i>=0;i--) { result = n_minus1*prev_in + n_minus2*prev_in2 + neg_d_minus1*prev_out + neg_d_minus2*prev_out2; prev_in2 = prev_in; prev_in = smem[proc_smem_idx]; prev_out2 = prev_out; prev_out = result; smem[proc_smem_idx] = result; proc_smem_idx--; } } SyncThreads(); gmem_idx = gmem_base + blockX + ThreadID().x; rw_smem_idx = GF_FASTMULTIPLY(ThreadID().y, GRAY_SMEM_W) + ThreadID().x;
#pragma unroll 4
for(int i=0;i<4;i++) { if(Y + (i<<3) < height) { if(blockX + ThreadID().x < width) WriteFloat(pOut, gmem_idx, ReadFloat(pOut, gmem_idx, device_format) + smem[rw_smem_idx], device_format); } gmem_idx += (pitch_f << 3); rw_smem_idx += (GRAY_SMEM_W * 8); } SyncThreads(); } }


// buildOptions=-cl-single-precision-constant -cl-fast-relaxed-math -cl-denorms-are-zero -cl-mad-enable -D GF_OPENCL_SUPPORTS_16F
// RUN: %occ-cli %s --cl-options="-I%cwd -I%S -cl-single-precision-constant -cl-fast-relaxed-math -cl-denorms-are-zero -cl-mad-enable -D GF_OPENCL_SUPPORTS_16F" %cfg_path --cl-device=%cl_device 2>&1
