
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
GF_KERNEL CopyMemory2DKernel( const GF_PTR(float4) inSrc, int inSrcPitch, int inSrcOffset, GF_PTR(float4) outDest, int inDestPitch, int inDestOffset, DevicePixelFormat inDeviceFormat, int inWidth, int inHeight) { int x = KernelX(); int y = KernelY(); const GF_PTR(float4) pSrc = inSrc + inSrcOffset; GF_PTR(float4) pDest = outDest + inDestOffset; if (x < inWidth && y < inHeight) { WriteRGBPixel( ReadRGBPixel(pSrc, inSrcPitch, inDeviceFormat, x, y), pDest, inDestPitch, inDeviceFormat, x, y); } } GF_KERNEL CopyRectKernel( const GF_PTR(float4) inSrc, int inSrcPitch, GF_PTR(float4) outDest, int inDestPitch, DevicePixelFormat inDeviceFormat, int inSrcX, int inSrcY, int inDestX, int inDestY, int inDestWidth, int inDestHeight) { int x = KernelX() + inDestX; int y = KernelY() + inDestY; if (inDestX <= x && x < inDestX + inDestWidth && inDestY <= y && y < inDestY + inDestHeight) { int readX = inSrcX + x - inDestX; int readY = inSrcY + y - inDestY; WriteRGBPixel( ReadRGBPixel(inSrc, inSrcPitch, inDeviceFormat, readX, readY), outDest, inDestPitch, inDeviceFormat, x, y); } }
#define CL_R 0x10B0

#define CL_RG 0x10B2

#define CL_UNORM_INT8 0x10D2

#define CL_HALF_FLOAT 0x10DD
 GF_KERNEL CopyBufferToImageKernel( const GF_PTR(float4) inSrc, int inSrcOffset, int inSrcPitch, int inSrcChannelOrder, int inSrcChannelType, int inSwapComponents, int inPremultiply, __write_only image2d_t outImage, int inWidth, int inHeight) { int x = KernelX(); int y = KernelY(); if (x < inWidth && y < inHeight) { const GF_PTR(uchar) src = (const GF_PTR(uchar))inSrc + inSrcOffset; float4 pixel; if (inSrcChannelType == CL_UNORM_INT8) { if (inSrcChannelOrder == CL_R) { uchar input = GF_READ2D((const GF_PTR(uchar))src, inSrcPitch, x, y); pixel.x = input / 255.0f; } else { uchar4 input = GF_READ2D((const GF_PTR(uchar4))src, inSrcPitch, x, y); pixel.x = input.x / 255.0f; pixel.y = input.y / 255.0f; pixel.z = input.z / 255.0f; pixel.w = input.w / 255.0f; } } else if (inSrcChannelType == CL_HALF_FLOAT) { if (inSrcChannelOrder == CL_R) { pixel.x = vload_half(GF_FASTMULTIPLY(y, inSrcPitch) + x, (const GF_PTR(half))src); } else { pixel = vload_half4(GF_FASTMULTIPLY(y, inSrcPitch) + x, (const GF_PTR(half))src); } } else { if (inSrcChannelOrder == CL_R) { float input = GF_READ2D((const GF_PTR(float))src, inSrcPitch, x, y); pixel.x = input; } else if (inSrcChannelOrder == CL_RG) { float2 input = GF_READ2D((const GF_PTR(float2))src, inSrcPitch, x, y); pixel.x = input.x; pixel.y = input.y; } else { pixel = GF_READ2D((const GF_PTR(float4))src, inSrcPitch, x, y); } } if (inPremultiply) { pixel.x = pixel.x * saturate(pixel.w); pixel.y = pixel.y * saturate(pixel.w); pixel.z = pixel.z * saturate(pixel.w); } if (inSwapComponents) { pixel = make_float4(pixel.z, pixel.y, pixel.x, pixel.w); } write_imagef(outImage, (int2)(x, y), pixel); } } const sampler_t copyImageToBufferSampler = CLK_NORMALIZED_COORDS_FALSE | CLK_ADDRESS_NONE | CLK_FILTER_NEAREST; GF_KERNEL CopyImageToBufferKernel( __read_only image2d_t inImage, GF_PTR(float4) outDest, int inDestOffset, int inDestPitch, int inDestChannelOrder, int inDestChannelType, int inSwapComponents, int inWidth, int inHeight) { int x = KernelX(); int y = KernelY(); if (x < inWidth && y < inHeight) { GF_PTR(uchar) dest = (GF_PTR(uchar))outDest + inDestOffset; float4 pixel = read_imagef(inImage, copyImageToBufferSampler, (int2)(x, y)); if (inSwapComponents) { pixel = make_float4(pixel.z, pixel.y, pixel.x, pixel.w); } if (inDestChannelType == CL_UNORM_INT8) { if (inDestChannelOrder == CL_R) { uchar output = pixel.x * 255.0 + 0.5f; GF_WRITE2D(output, (GF_PTR(uchar))dest, inDestPitch, x, y); } else { uchar4 output = make_uchar4( pixel.x * 255.0f + 0.5f, pixel.y * 255.0f + 0.5f, pixel.z * 255.0f + 0.5f, pixel.w * 255.0f + 0.5f); GF_WRITE2D(output, (GF_PTR(uchar4))dest, inDestPitch, x, y); } } else if (inDestChannelType == CL_HALF_FLOAT) { if (inDestChannelOrder == CL_R) { vstore_half_rtz(pixel.x, GF_FASTMULTIPLY(y, inDestPitch) + x, (GF_PTR(half))dest); } else { vstore_half4_rtz(pixel, GF_FASTMULTIPLY(y, inDestPitch) + x, (GF_PTR(half))dest); } } else { if (inDestChannelOrder == CL_R) { GF_WRITE2D(pixel.x, (GF_PTR(float))dest, inDestPitch, x, y); } else if (inDestChannelOrder == CL_RG) { GF_WRITE2D(make_float2(pixel.x, pixel.y), (GF_PTR(float2))dest, inDestPitch, x, y); } else { GF_WRITE2D(pixel, (GF_PTR(float4))dest, inDestPitch, x, y); } } } }


// buildOptions=-cl-single-precision-constant -cl-fast-relaxed-math -cl-denorms-are-zero -cl-mad-enable -D GF_OPENCL_SUPPORTS_16F
// RUN: %occ-cli %s --cl-options="-I%cwd -I%S -cl-single-precision-constant -cl-fast-relaxed-math -cl-denorms-are-zero -cl-mad-enable -D GF_OPENCL_SUPPORTS_16F" %cfg_path --cl-device=%cl_device 2>&1
