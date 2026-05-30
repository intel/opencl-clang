
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
typedef enum { kDevicePixelFormat_BGRA_4444_16f, kDevicePixelFormat_BGRA_4444_32f, } DevicePixelFormat;
#endif
typedef struct { float b, g, r, a; } GF_ALIGN(16) PixelRGB; GF_DEVICE_FUNCTION PixelRGB BGRA( float inB, float inG, float inR, float inA) { PixelRGB pixel; pixel.b = inB; pixel.g = inG; pixel.r = inR; pixel.a = inA; return pixel; } GF_DEVICE_FUNCTION float4 ConvertRGB_To_Components( PixelRGB inPixel) { return *(float4*)&inPixel; } GF_DEVICE_FUNCTION PixelRGB ConvertComponents_To_RGB( float4 inPixel) { return *(PixelRGB*)&inPixel; }GF_DEVICE_FUNCTION float4 ReadPixel( const GF_PTR(float4) inImage, int inPitch, DevicePixelFormat inDeviceFormat, int inX, int inY) { return GF_READ2D(inImage, inPitch, inX, inY); } GF_DEVICE_FUNCTION void WritePixel( float4 inPixel, GF_PTR(float4) outImage, int inPitch, DevicePixelFormat inDeviceFormat, int inX, int inY) { GF_WRITE2D(inPixel, outImage, inPitch, inX, inY); }GF_DEVICE_FUNCTION PixelRGB ReadRGBPixel( const GF_PTR(float4) inImage, int inPitch, DevicePixelFormat inDeviceFormat, int inX, int inY) { return ConvertComponents_To_RGB(ReadPixel(inImage, inPitch, inDeviceFormat, inX, inY)); } GF_DEVICE_FUNCTION void WriteRGBPixel( PixelRGB inPixel, GF_PTR(float4) outImage, int inPitch, DevicePixelFormat inDeviceFormat, int inX, int inY) { WritePixel(ConvertRGB_To_Components(inPixel), outImage, inPitch, inDeviceFormat, inX, inY); }
#define GF_READTEXTUREPIXEL(I, X, Y, S) ConvertComponents_To_RGB(GF_READTEXTURE(I, X, Y, S))

#endif
GF_KERNEL CopyMemory2DKernel( const GF_PTR(float4) inSrc, int inSrcPitch, int inSrcOffset, GF_PTR(float4) outDest, int inDestPitch, int inDestOffset, DevicePixelFormat inDeviceFormat, int inWidth, int inHeight) { int x = KernelX(); int y = KernelY(); const GF_PTR(float4) pSrc = inSrc + inSrcOffset; GF_PTR(float4) pDest = outDest + inDestOffset; if (x < inWidth && y < inHeight) { WriteRGBPixel( ReadRGBPixel(pSrc, inSrcPitch, inDeviceFormat, x, y), pDest, inDestPitch, inDeviceFormat, x, y); } } GF_KERNEL CopyRectKernel( const GF_PTR(float4) inSrc, int inSrcPitch, GF_PTR(float4) outDest, int inDestPitch, DevicePixelFormat inDeviceFormat, int inSrcX, int inSrcY, int inDestX, int inDestY, int inDestWidth, int inDestHeight) { int x = KernelX() + inDestX; int y = KernelY() + inDestY; if (inDestX <= x && x < inDestX + inDestWidth && inDestY <= y && y < inDestY + inDestHeight) { int readX = inSrcX + x - inDestX; int readY = inSrcY + y - inDestY; WriteRGBPixel( ReadRGBPixel(inSrc, inSrcPitch, inDeviceFormat, readX, readY), outDest, inDestPitch, inDeviceFormat, x, y); } }
#if USE_CL_IMAGES
 GF_KERNEL CopyBufferToImageKernel_1ch_8u( const GF_PTR(float4) inSrc, int inSrcOffset, int inSrcPitch, __write_only image2d_t outImage ) { int x = KernelX(); int y = KernelY(); const GF_PTR(uchar) src = (const GF_PTR(uchar))inSrc + inSrcOffset; float4 pixel; uchar input = GF_READ2D((const GF_PTR(uchar))src, inSrcPitch, x, y); pixel.x = native_divide((float)input, 255.0f); write_imagef(outImage, (int2)(x, y), pixel); } GF_KERNEL CopyBufferToImageKernel_4444_8u( const GF_PTR(float4) inSrc, int inSrcOffset, int inSrcPitch, __write_only image2d_t outImage ) { int x = KernelX(); int y = KernelY(); const GF_PTR(uchar) src = (const GF_PTR(uchar))inSrc + inSrcOffset; float4 pixel = native_divide(convert_float4(GF_READ2D((const GF_PTR(uchar4))src, inSrcPitch, x, y)), (float4)255.0f); write_imagef(outImage, (int2)(x, y), pixel); } GF_KERNEL CopyBufferToImageKernel_1ch_32f( const GF_PTR(float4) inSrc, int inSrcOffset, int inSrcPitch, __write_only image2d_t outImage ) { int x = KernelX(); int y = KernelY(); const GF_PTR(uchar) src = (const GF_PTR(uchar))inSrc + inSrcOffset; float4 pixel; float input = GF_READ2D((const GF_PTR(float))src, inSrcPitch, x, y); pixel.x = input; write_imagef(outImage, (int2)(x, y), pixel); } GF_KERNEL CopyBufferToImageKernel_4444_32f( const GF_PTR(float4) inSrc, int inSrcOffset, int inSrcPitch, __write_only image2d_t outImage) { int x = KernelX(); int y = KernelY(); const GF_PTR(uchar) src = (const GF_PTR(uchar))inSrc + inSrcOffset; float4 pixel = GF_READ2D((const GF_PTR(float4))src, inSrcPitch, x, y); write_imagef(outImage, (int2)(x, y), pixel); }
#endif
 GF_KERNEL CopyBufferToImageKernel( const GF_PTR(float4) inSrc, int inSrcOffset, int inSrcPitch, __write_only image2d_t outImage, int inWidth, int inHeight) { int x = KernelX(); int y = KernelY();
#if USE_CL_IMAGES
 const GF_PTR(uchar) src = (const GF_PTR(uchar))inSrc + inSrcOffset; int channelOrder = get_image_channel_order(outImage); int channelType = get_image_channel_data_type(outImage); float4 pixel; if (channelType == CLK_UNORM_INT8) { if (channelOrder == CLK_R) { uchar input = GF_READ2D((const GF_PTR(uchar))src, inSrcPitch, x, y); pixel.x = input / 255.0f; } else { uchar4 input = GF_READ2D((const GF_PTR(uchar4))src, inSrcPitch, x, y); pixel = native_divide(convert_float4(input), (float4)255.0f); } } else { if (channelOrder == CLK_R) { float input = GF_READ2D((const GF_PTR(float))src, inSrcPitch, x, y); pixel.x = input; } else { pixel = GF_READ2D((const GF_PTR(float4))src, inSrcPitch, x, y); } } write_imagef(outImage, (int2)(x, y), pixel);
#else
 if (x < inWidth && y < inHeight) { const GF_PTR(uchar) src = (const GF_PTR(uchar))inSrc + inSrcOffset; int channelOrder = get_image_channel_order(outImage); int channelType = get_image_channel_data_type(outImage); float4 pixel; if (channelType == CLK_UNORM_INT8) { if (channelOrder == CLK_R) { uchar input = GF_READ2D((const GF_PTR(uchar))src, inSrcPitch, x, y); pixel.x = input / 255.0f; } else { uchar4 input = GF_READ2D((const GF_PTR(uchar4))src, inSrcPitch, x, y); pixel.x = input.x / 255.0f; pixel.y = input.y / 255.0f; pixel.z = input.z / 255.0f; pixel.w = input.w / 255.0f; } } else { if (channelOrder == CLK_R) { float input = GF_READ2D((const GF_PTR(float))src, inSrcPitch, x, y); pixel.x = input; } else { pixel = GF_READ2D((const GF_PTR(float4))src, inSrcPitch, x, y); } } write_imagef(outImage, (int2)(x, y), pixel); }
#endif
 }

// buildOptions= -cl-single-precision-constant -cl-fast-relaxed-math
// RUN: %occ-cli %s --cl-options="-I%cwd -I%S  -cl-single-precision-constant -cl-fast-relaxed-math" %cfg_path --cl-device=%cl_device 2>&1
