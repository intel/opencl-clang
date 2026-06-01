
#ifndef GFKERNELSUPPORT_PIXELUTILS_H
#define GFKERNELSUPPORT_PIXELUTILS_H

#ifndef GFKERNELSUPPORT_FLOATINGPOINT_H
#define GFKERNELSUPPORT_FLOATINGPOINT_H

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
GF_DEVICE_FUNCTION float Power(float inX, float inP) { return inX >= 0 ? native_powr(inX, inP) : -native_powr(-inX, inP); } GF_DEVICE_FUNCTION float fdividef(float inX, float inY) { return native_divide(inX, inY); } GF_DEVICE_FUNCTION float fabsf(float inX) { return fabs(inX); } GF_DEVICE_FUNCTION float rsqrtf(float inX) { return native_rsqrt(inX); } GF_DEVICE_FUNCTION float sqrtf(float inX) { return native_sqrt(inX); } GF_DEVICE_FUNCTION float cosf(float inX) { return native_cos(inX); } GF_DEVICE_FUNCTION float sinf(float inX) { return native_sin(inX); } GF_DEVICE_FUNCTION float atan2f(float inX, float inY) { return atan2(inX, inY); }GF_DEVICE_FUNCTION float LERP(float inA, float inB, float inS) { return inA + inS * (inB - inA); } GF_DEVICE_FUNCTION GF_HOST_FUNCTION bool fIsEqual( float inValue0, float inValue1) { return fabsf(inValue0 - inValue1) < 0.000008f; } GF_DEVICE_FUNCTION GF_HOST_FUNCTION bool fIsNotEqual( float inValue0, float inValue1) { return !fIsEqual(inValue0, inValue1); } GF_DEVICE_FUNCTION GF_HOST_FUNCTION bool fIsLessThan( float inValue0, float inValue1) { return (inValue0 - 0.000008f) < inValue1; } GF_DEVICE_FUNCTION GF_HOST_FUNCTION bool fIsLessThanOrEqual( float inValue0, float inValue1) { return (inValue0 - 0.000008f) <= inValue1; } GF_DEVICE_FUNCTION GF_HOST_FUNCTION bool fIsGreaterThan( float inValue0, float inValue1) { return (inValue0 + 0.000008f) > inValue1; } GF_DEVICE_FUNCTION GF_HOST_FUNCTION bool fIsGreaterThanOrEqual( float inValue0, float inValue1) { return (inValue0 + 0.000008f) >= inValue1; }
#endif

#ifndef GFKERNELSUPPORT_PIXELRGB_H
#define GFKERNELSUPPORT_PIXELRGB_H

#ifndef GFDEVICEPIXELFORMAT_H
#define GFDEVICEPIXELFORMAT_H
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
GF_DEVICE_FUNCTION PixelRGB AddPixels( PixelRGB inPixel0, PixelRGB inPixel1) { PixelRGB result = { inPixel0.b + inPixel1.b, inPixel0.g + inPixel1.g, inPixel0.r + inPixel1.r, inPixel0.a + inPixel1.a, }; return result; } GF_DEVICE_FUNCTION PixelRGB MultiplyPixels( PixelRGB inPixel0, PixelRGB inPixel1) { PixelRGB result = { inPixel0.b * inPixel1.b, inPixel0.g * inPixel1.g, inPixel0.r * inPixel1.r, inPixel0.a * inPixel1.a, }; return result; } GF_DEVICE_FUNCTION PixelRGB SubtractPixels( PixelRGB inPixel0, PixelRGB inPixel1) { PixelRGB result = { inPixel0.b - inPixel1.b, inPixel0.g - inPixel1.g, inPixel0.r - inPixel1.r, inPixel0.a - inPixel1.a, }; return result; } GF_DEVICE_FUNCTION PixelRGB MultiplyPixel( PixelRGB inPixel, float inS) { return MultiplyPixels(inPixel, BGRA(inS, inS, inS, inS)); } GF_DEVICE_FUNCTION PixelRGB DividePixels( PixelRGB inPixel0, PixelRGB inPixel1) { PixelRGB result = { fdividef(inPixel0.b, inPixel1.b), fdividef(inPixel0.g, inPixel1.g), fdividef(inPixel0.r, inPixel1.r), fdividef(inPixel0.a, inPixel1.a), }; return result; } GF_DEVICE_FUNCTION PixelRGB DividePixel( PixelRGB inPixel, float inS) { return DividePixels(inPixel, BGRA(inS, inS, inS, inS)); } GF_DEVICE_FUNCTION PixelRGB PowerPixels( PixelRGB inPixel, float inS) { PixelRGB result = { Power(inPixel.b, inS), Power(inPixel.g, inS), Power(inPixel.r, inS), Power(inPixel.a, inS), }; return result; } GF_DEVICE_FUNCTION PixelRGB AbsPixels( PixelRGB inPixel) { PixelRGB result = { fabsf(inPixel.b), fabsf(inPixel.g), fabsf(inPixel.r), fabsf(inPixel.a), }; return result; } GF_DEVICE_FUNCTION float MaxPixel( PixelRGB inPixel) { return max(max(max(inPixel.b, inPixel.g), inPixel.r), inPixel.a); } GF_DEVICE_FUNCTION PixelRGB ClampPixel( PixelRGB inPixel, float inMin, float inMax) { PixelRGB result = { clamp(inPixel.b, inMin, inMax), clamp(inPixel.g, inMin, inMax), clamp(inPixel.r, inMin, inMax), clamp(inPixel.a, inMin, inMax), }; return result; } GF_DEVICE_FUNCTION PixelRGB OpaquePixel( PixelRGB inPixel) { PixelRGB result = inPixel; result.a = 1.0f; return result; } GF_DEVICE_FUNCTION PixelRGB PremultiplyPixel( PixelRGB inPixel) { PixelRGB result = inPixel; result.r *= inPixel.a; result.g *= inPixel.a; result.b *= inPixel.a; return result; } GF_DEVICE_FUNCTION PixelRGB UnpremultiplyPixel( PixelRGB inPixel) { PixelRGB result = inPixel; result.a = saturate(result.a); if (!fIsLessThanOrEqual(result.a, 0.0f)) { float ra = fdividef(1.0f, result.a); result.r *= ra; result.g *= ra; result.b *= ra; } else { result.r = result.g = result.b = result.a = 0.f; } return result; } GF_DEVICE_FUNCTION float ToLinearColor(float inValue) { return Power(inValue, 2.2f); } GF_DEVICE_FUNCTION float FromLinearColor(float inValue) { return Power(inValue, 1.0f/2.2f); } GF_DEVICE_FUNCTION PixelRGB PremultiplyLinearizePixel(PixelRGB inPixel) { PixelRGB result = inPixel; result.a = saturate(result.a); result.b = ToLinearColor(result.b); result.g = ToLinearColor(result.g); result.r = ToLinearColor(result.r); return PremultiplyPixel(result); } GF_DEVICE_FUNCTION PixelRGB UnpremultiplyUnlinearizePixel(PixelRGB inPixel) { PixelRGB result = UnpremultiplyPixel(inPixel); result.b = FromLinearColor(result.b); result.g = FromLinearColor(result.g); result.r = FromLinearColor(result.r); return result; }
#endif
GF_DEVICE_FUNCTION float4 Add4F(float4 inA, float4 inB) { return make_float4(inA.x + inB.x, inA.y + inB.y, inA.z + inB.z, inA.w + inB.w); } GF_DEVICE_FUNCTION float4 Scale4F(float4 inA, float inB) { return make_float4(inA.x * inB, inA.y * inB, inA.z * inB, inA.w * inB); } GF_KERNEL SharpenCachedKernel( GF_PTR(float4) inSrc, GF_PTR(float4) outDest, int inPitch, DevicePixelFormat inDeviceFormat, int inWidth, int inHeight, float inCenterCoeff, float inSurroundCoeff) { int x = KernelX(); int y = KernelY(); if (x < inWidth && y < inHeight) { int offset = GF_FASTMULTIPLY(y, inPitch) + x; float4 up = ReadPixelIndex(inSrc, inDeviceFormat, offset + (y == 0 ? 0 : -inPitch)); float4 left = ReadPixelIndex(inSrc, inDeviceFormat, offset + (x == 0 ? 0 : -1)); float4 center = ReadPixelIndex(inSrc, inDeviceFormat, offset); float4 right = ReadPixelIndex(inSrc, inDeviceFormat, offset + (x >= inWidth - 1 ? 0 : 1)); float4 down = ReadPixelIndex(inSrc, inDeviceFormat, offset + (y >= inHeight - 1 ? 0 : inPitch)); float4 surround = Add4F(Add4F(up, down), Add4F(left, right)); surround = Scale4F(surround, inSurroundCoeff); center = Scale4F(center, inCenterCoeff); float4 result = Add4F(center, surround); WritePixelIndex(result, outDest, inDeviceFormat, offset); } }


// buildOptions=-cl-single-precision-constant -cl-fast-relaxed-math -cl-denorms-are-zero -cl-mad-enable -D GF_OPENCL_SUPPORTS_16F
// RUN: %occ-cli %s --cl-options="-I%cwd -I%S -cl-single-precision-constant -cl-fast-relaxed-math -cl-denorms-are-zero -cl-mad-enable -D GF_OPENCL_SUPPORTS_16F" %cfg_path --cl-device=%cl_device 2>&1
