
#ifndef GFKERNELSUPPORT_COMPOSITE_H
#define GFKERNELSUPPORT_COMPOSITE_H

#ifndef GFBLENDMODE_H
#define GFBLENDMODE_H

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
typedef enum { kBlendMode_Color, kBlendMode_ColorBurn, kBlendMode_ColorDodge, kBlendMode_Darken, kBlendMode_DarkerColor, kBlendMode_Difference, kBlendMode_Dissolve, kBlendMode_Exclusion, kBlendMode_HardLight, kBlendMode_HardMix, kBlendMode_Hue, kBlendMode_Lighten, kBlendMode_LighterColor, kBlendMode_LinearBurn, kBlendMode_LinearDodgeAdd, kBlendMode_LinearLight, kBlendMode_Luminosity, kBlendMode_Multiply, kBlendMode_Normal, kBlendMode_Overlay, kBlendMode_PinLight, kBlendMode_Saturation, kBlendMode_Screen, kBlendMode_SoftLight, kBlendMode_VividLight, kBlendMode_Subtract, kBlendMode_Divide } BlendMode;
#endif

#ifndef GFKERNELSUPPORT_COLORSPACECONVERT_H
#define GFKERNELSUPPORT_COLORSPACECONVERT_H
GF_CONSTANT(float) kRGB32f_To_601YPbPr[9] = { 0.299f , 0.587f , 0.114f, -0.168736f, -0.331264f, 0.5f, 0.5f , -0.418688f, -0.081312f, }; GF_CONSTANT(float) k601YPbPr_To_RGB32f[9] = { 1.0f, 0.0f , 1.402f, 1.0f, -0.344136f, -0.714136f, 1.0f, 1.772f , 0.0f, }; GF_CONSTANT(float) kRGB32f_To_601YCbCr[9] = { 65.481f, 128.553f, 24.966f, -37.797f, -74.203f , 112.0f, 112.0f , -93.786f , -18.214f, }; GF_CONSTANT(float) k601YCbCr_To_RGB32f[9] = { 0.00456621f, 0.0f , 0.00625893f, 0.00456621f, -0.00153396f, -0.00318811f, 0.00456621f, 0.00791071f, 0.0f, }; GF_CONSTANT(float) kRGB8u_To_601YCbCr[9] = { 65.738f / 256.0f, 129.057f / 256.0f, 25.064f / 256.0f, -37.945f / 256.0f, -74.494f / 256.0f, 112.439f / 256.0f, 112.439f / 256.0f, -94.154f / 256.0f, -18.285f / 256.0f, }; GF_CONSTANT(float) k601YCbCr_To_RGB8u[9] = { 298.082f / 256.0f, 0.0f , 408.583f / 256.0f, 298.082f / 256.0f, -100.291f / 256.0f, -208.120f / 256.0f, 298.082f / 256.0f, 516.411f / 256.0f, 0.0f, }; GF_CONSTANT(float) kRGB8u_To_601YCbCrFullRange[9] = { 76.544 / 256.0f, 150.272 / 256.0f, 29.184 / 256.0f, -43.027 / 256.0f, -84.471 / 256.0f, 127.498 / 256.0f, 127.498 / 256.0f, -106.764 / 256.0f, -20.734 / 256.0f, }; GF_CONSTANT(float) k601YCbCrFullRange_To_RGB8u[9] = { 1.0f, 0.0f , 357.510 / 256.0f, 1.0f, -87.755 / 256.0f, -182.105 / 256.0f, 1.0f, 451.860 / 256.0f, 0.0f, }; GF_CONSTANT(float) kRGB32f_To_601YCbCrFullRange[9] = { 76.245f, 149.685f, 29.07f, -42.859f, -84.141f , 127.0f, 127.0f , -106.347f, -20.653f, }; GF_CONSTANT(float) k601YCbCrFullRange_To_RGB32f[9] = { 1.0f / 255.0f, 0.0f , 357.510 / 65280.0f, 1.0f / 255.0f, -87.755 / 65280.0f, -182.105 / 65280.0f, 1.0f / 255.0f, 451.860 / 65280.0f, 0.0f, }; GF_CONSTANT(float) kRGB32f_To_709YPbPr[9] = { 0.2126f , 0.7152f , 0.0722f, -0.114572f, -0.385428f, 0.5f, 0.5f , -0.454153f, -0.045847f, }; GF_CONSTANT(float) k709YPbPr_To_RGB32f[9] = { 1.0f, 0.0f , 1.5748f, 1.0f, -0.187324f, -0.468124f, 1.0f, 1.8556f , 0.0f, }; GF_CONSTANT(float) kRGB32f_To_709YCbCr[9] = { 46.559f, 156.629f, 15.812f, -25.664f, -86.336f , 112.0f, 112.0f , -101.730f, -10.270f, }; GF_CONSTANT(float) k709YCbCr_To_RGB32f[9] = { 0.00456621f, 0.0f , 0.00703036f, 0.00456621f, -0.00083627f, -0.00208984f, 0.00456621f, 0.00828393f, 0.0f, }; GF_CONSTANT(float) k709YCbCrFullRange_To_RGB32f[9] = { 0.00392157f, 0.0f , 0.00615157f, 0.00392157f, -0.00073174f, -0.00182861f, 0.00392157f, 0.00724844f, 0.0f, }; GF_CONSTANT(float) kRGB8u_To_709YCbCr[9] = { 46.742f / 256.0f, 157.243f / 256.0f, 15.874f / 256.0f, 25.762f / 256.0f, -86.674f / 256.0f, 112.439f / 256.0f, 112.439f / 256.0f, -102.129f / 256.0f, -10.310f / 256.0f, }; GF_CONSTANT(float) k709YCbCr_To_RGB8u[9] = { 298.082f / 256.0f, 0.0f , 458.942f / 256.0f, 298.082f / 256.0f, -54.592f / 256.0f, -136.425f / 256.0f, 298.082f / 256.0f, 540.775f / 256.0f, 0.0f, }; GF_CONSTANT(float) k709YCbCr_To_601YCbCr[9] = { 1.0f, 0.099312f, 0.191700f, 0.0f, 0.989854f, -0.110653f, 0.0f, -0.072453f, 0.983398f, }; GF_CONSTANT(float) k601YCbCr_To_709YCbCr[9] = { 1.0f, -0.115550f, -0.207938f, 0.0f, 1.018640f, 0.114618f, 0.0f, 0.075049f, 1.025327f, }; GF_CONSTANT(float) kYCbCrOffset[3] = { 16.0f, 128.0f, 128.0f, }; GF_CONSTANT(float) kYCbCrFullRangeOffset[3] = { 0.0f, 128.0f, 128.0f, }; GF_DEVICE_FUNCTION float4 SwapComponentOrder( float4 inV) { float4 result = { inV.w, inV.z, inV.y, inV.x }; return result; } GF_DEVICE_FUNCTION float4 ColorSpaceConvert( float4 inPixel, GF_STATIC_CONSTANT_PTR(float) inMatrix) { return make_float4( inPixel.x, inPixel.y * inMatrix[0] + inPixel.z * inMatrix[1] + inPixel.w * inMatrix[2], inPixel.y * inMatrix[3] + inPixel.z * inMatrix[4] + inPixel.w * inMatrix[5], inPixel.y * inMatrix[6] + inPixel.z * inMatrix[7] + inPixel.w * inMatrix[8]); }
#endif

#ifndef GFKERNELSUPPORT_PIXELUTILS_H
#define GFKERNELSUPPORT_PIXELUTILS_H

#ifndef GFKERNELSUPPORT_FLOATINGPOINT_H
#define GFKERNELSUPPORT_FLOATINGPOINT_H
GF_DEVICE_FUNCTION float Power(float inX, float inP) { return inX >= 0 ? native_powr(inX, inP) : -native_powr(-inX, inP); } GF_DEVICE_FUNCTION float fdividef(float inX, float inY) { return native_divide(inX, inY); } GF_DEVICE_FUNCTION float fabsf(float inX) { return fabs(inX); } GF_DEVICE_FUNCTION float rsqrtf(float inX) { return native_rsqrt(inX); } GF_DEVICE_FUNCTION float sqrtf(float inX) { return native_sqrt(inX); } GF_DEVICE_FUNCTION float cosf(float inX) { return native_cos(inX); } GF_DEVICE_FUNCTION float sinf(float inX) { return native_sin(inX); } GF_DEVICE_FUNCTION float atan2f(float inX, float inY) { return atan2(inX, inY); }GF_DEVICE_FUNCTION float LERP(float inA, float inB, float inS) { return inA + inS * (inB - inA); } GF_DEVICE_FUNCTION GF_HOST_FUNCTION bool fIsEqual( float inValue0, float inValue1) { return fabsf(inValue0 - inValue1) < 0.000008f; } GF_DEVICE_FUNCTION GF_HOST_FUNCTION bool fIsNotEqual( float inValue0, float inValue1) { return !fIsEqual(inValue0, inValue1); } GF_DEVICE_FUNCTION GF_HOST_FUNCTION bool fIsLessThan( float inValue0, float inValue1) { return (inValue0 - 0.000008f) < inValue1; } GF_DEVICE_FUNCTION GF_HOST_FUNCTION bool fIsLessThanOrEqual( float inValue0, float inValue1) { return (inValue0 - 0.000008f) <= inValue1; } GF_DEVICE_FUNCTION GF_HOST_FUNCTION bool fIsGreaterThan( float inValue0, float inValue1) { return (inValue0 + 0.000008f) > inValue1; } GF_DEVICE_FUNCTION GF_HOST_FUNCTION bool fIsGreaterThanOrEqual( float inValue0, float inValue1) { return (inValue0 + 0.000008f) >= inValue1; }
#endif

#ifndef GFKERNELSUPPORT_PIXELRGB_H
#define GFKERNELSUPPORT_PIXELRGB_H

#ifndef GFDEVICEPIXELFORMAT_H
#define GFDEVICEPIXELFORMAT_H
typedef enum { kDevicePixelFormat_BGRA_4444_16f, kDevicePixelFormat_BGRA_4444_32f, } DevicePixelFormat;
#endif
typedef struct { float b, g, r, a; } GF_ALIGN(16) PixelRGB; GF_DEVICE_FUNCTION PixelRGB BGRA( float inB, float inG, float inR, float inA) { PixelRGB pixel; pixel.b = inB; pixel.g = inG; pixel.r = inR; pixel.a = inA; return pixel; } GF_DEVICE_FUNCTION float4 ConvertRGB_To_Components( PixelRGB inPixel) { return *(float4*)&inPixel; } GF_DEVICE_FUNCTION PixelRGB ConvertComponents_To_RGB( float4 inPixel) { return *(PixelRGB*)&inPixel; }GF_DEVICE_FUNCTION float4 ReadPixel( const GF_PTR(float4) inImage, int inPitch, DevicePixelFormat inDeviceFormat, int inX, int inY) { return GF_READ2D(inImage, inPitch, inX, inY); } GF_DEVICE_FUNCTION void WritePixel( float4 inPixel, GF_PTR(float4) outImage, int inPitch, DevicePixelFormat inDeviceFormat, int inX, int inY) { GF_WRITE2D(inPixel, outImage, inPitch, inX, inY); }GF_DEVICE_FUNCTION PixelRGB ReadRGBPixel( const GF_PTR(float4) inImage, int inPitch, DevicePixelFormat inDeviceFormat, int inX, int inY) { return ConvertComponents_To_RGB(ReadPixel(inImage, inPitch, inDeviceFormat, inX, inY)); } GF_DEVICE_FUNCTION void WriteRGBPixel( PixelRGB inPixel, GF_PTR(float4) outImage, int inPitch, DevicePixelFormat inDeviceFormat, int inX, int inY) { WritePixel(ConvertRGB_To_Components(inPixel), outImage, inPitch, inDeviceFormat, inX, inY); }
#define GF_READTEXTUREPIXEL(I, X, Y, S) ConvertComponents_To_RGB(GF_READTEXTURE(I, X, Y, S))

#endif
GF_DEVICE_FUNCTION PixelRGB AddPixels( PixelRGB inPixel0, PixelRGB inPixel1) { PixelRGB result = { inPixel0.b + inPixel1.b, inPixel0.g + inPixel1.g, inPixel0.r + inPixel1.r, inPixel0.a + inPixel1.a, }; return result; } GF_DEVICE_FUNCTION PixelRGB MultiplyPixels( PixelRGB inPixel0, PixelRGB inPixel1) { PixelRGB result = { inPixel0.b * inPixel1.b, inPixel0.g * inPixel1.g, inPixel0.r * inPixel1.r, inPixel0.a * inPixel1.a, }; return result; } GF_DEVICE_FUNCTION PixelRGB SubtractPixels( PixelRGB inPixel0, PixelRGB inPixel1) { PixelRGB result = { inPixel0.b - inPixel1.b, inPixel0.g - inPixel1.g, inPixel0.r - inPixel1.r, inPixel0.a - inPixel1.a, }; return result; } GF_DEVICE_FUNCTION PixelRGB MultiplyPixel( PixelRGB inPixel, float inS) { return MultiplyPixels(inPixel, BGRA(inS, inS, inS, inS)); } GF_DEVICE_FUNCTION PixelRGB DividePixels( PixelRGB inPixel0, PixelRGB inPixel1) { PixelRGB result = { fdividef(inPixel0.b, inPixel1.b), fdividef(inPixel0.g, inPixel1.g), fdividef(inPixel0.r, inPixel1.r), fdividef(inPixel0.a, inPixel1.a), }; return result; } GF_DEVICE_FUNCTION PixelRGB DividePixel( PixelRGB inPixel, float inS) { return DividePixels(inPixel, BGRA(inS, inS, inS, inS)); } GF_DEVICE_FUNCTION PixelRGB PowerPixels( PixelRGB inPixel, float inS) { PixelRGB result = { Power(inPixel.b, inS), Power(inPixel.g, inS), Power(inPixel.r, inS), Power(inPixel.a, inS), }; return result; } GF_DEVICE_FUNCTION PixelRGB AbsPixels( PixelRGB inPixel) { PixelRGB result = { fabsf(inPixel.b), fabsf(inPixel.g), fabsf(inPixel.r), fabsf(inPixel.a), }; return result; } GF_DEVICE_FUNCTION float MaxPixel( PixelRGB inPixel) { return max(max(max(inPixel.b, inPixel.g), inPixel.r), inPixel.a); } GF_DEVICE_FUNCTION PixelRGB ClampPixel( PixelRGB inPixel, float inMin, float inMax) { PixelRGB result = { clamp(inPixel.b, inMin, inMax), clamp(inPixel.g, inMin, inMax), clamp(inPixel.r, inMin, inMax), clamp(inPixel.a, inMin, inMax), }; return result; } GF_DEVICE_FUNCTION PixelRGB OpaquePixel( PixelRGB inPixel) { PixelRGB result = inPixel; result.a = 1.0f; return result; } GF_DEVICE_FUNCTION PixelRGB PremultiplyPixel( PixelRGB inPixel) { PixelRGB result = inPixel; result.r *= inPixel.a; result.g *= inPixel.a; result.b *= inPixel.a; return result; } GF_DEVICE_FUNCTION PixelRGB UnpremultiplyPixel( PixelRGB inPixel) { PixelRGB result = inPixel; result.a = saturate(result.a); if (!fIsLessThanOrEqual(result.a, 0.0f)) { float ra = fdividef(1.0f, result.a); result.r *= ra; result.g *= ra; result.b *= ra; } else { result.r = result.g = result.b = result.a = 0.f; } return result; } GF_DEVICE_FUNCTION float ToLinearColor(float inValue) { return Power(inValue, 2.2f); } GF_DEVICE_FUNCTION float FromLinearColor(float inValue) { return Power(inValue, 1.0f/2.2f); } GF_DEVICE_FUNCTION PixelRGB PremultiplyLinearizePixel(PixelRGB inPixel) { PixelRGB result = inPixel; result.a = saturate(result.a); result.b = ToLinearColor(result.b); result.g = ToLinearColor(result.g); result.r = ToLinearColor(result.r); return PremultiplyPixel(result); } GF_DEVICE_FUNCTION PixelRGB UnpremultiplyUnlinearizePixel(PixelRGB inPixel) { PixelRGB result = UnpremultiplyPixel(inPixel); result.b = FromLinearColor(result.b); result.g = FromLinearColor(result.g); result.r = FromLinearColor(result.r); return result; }
#endif

#ifndef GFKERNELSUPPORT_RAND_H
#define GFKERNELSUPPORT_RAND_H
GF_CONSTANT(unsigned int) kRandMax = ((1 << 15) - 1); GF_DEVICE_FUNCTION unsigned int Mix3( unsigned int a, unsigned int b, unsigned int c) { a -= b; a -= c; a ^= (c>>13); b -= c; b -= a; b ^= (a<<8); c -= a; c -= b; c ^= (b>>13); a -= b; a -= c; a ^= (c>>12); b -= c; b -= a; b ^= (a<<16); c -= a; c -= b; c ^= (b>>5); a -= b; a -= c; a ^= (c>>3); b -= c; b -= a; b ^= (a<<10); c -= a; c -= b; c ^= (b>>15); return c; } GF_DEVICE_FUNCTION int Rand( unsigned int inSeed) { inSeed *= 1103515245; inSeed += 12345; int result = (unsigned int) (inSeed / 65536) % 256; inSeed *= 1103515245; inSeed += 12345; result <<= 7; result ^= (unsigned int) (inSeed / 65536) % 256; return result; } GF_DEVICE_FUNCTION int Rand2DSeed( unsigned int inX, unsigned int inY, unsigned int inSeed) { return Rand(Mix3(inX, inY, inSeed)); } GF_DEVICE_FUNCTION int Rand2D() { return Rand2DSeed(KernelX(), KernelY(), 1); }
#endif

#define BLENDMODE_COMPOSITE_KERNEL_NAME(blend_mode) BlendMode_##blend_mode##_Kernel

#define PER_CHANNEL_BLEND_FN_NAME(blend_mode) BlendMode_ChannelFn_##blend_mode

#define PER_PIXEL_BLEND_FN_NAME(blend_mode) BlendMode_PixelFn_##blend_mode

#define PER_PIXEL_BLEND_REC_FN_NAME(blend_mode, color_coding) BlendMode_PixelRecFn_##blend_mode##color_coding

#define MAX_WIDTH_FOR_REC_601 720

#define DEFINE_PER_CHANNEL_BLEND(blend_mode) \
 GF_DEVICE_FUNCTION PixelRGB PER_PIXEL_BLEND_FN_NAME(blend_mode)(PixelRGB inSrcA, PixelRGB inSrcB, float inOpacityA, int inWidth) \
 { \
 PixelRGB result; \
 float alphaA = inOpacityA * inSrcA.a; \
 result.a = alphaA + inSrcB.a - (alphaA * inSrcB.a); \
 if (fIsLessThanOrEqual(result.a, 0.0f)) \
 { \
 result.b = 0.0f; result.g = 0.0f; result.r = 0.0f; result.a = 0.0f; \
 } \
 else \
 { \
 float invAlphaR = fdividef(1.0f, result.a); \
 result.b = (1.0f - (alphaA * invAlphaR)) * inSrcB.b + alphaA * invAlphaR * ((1.0f-inSrcB.a) * inSrcA.b + inSrcB.a * PER_CHANNEL_BLEND_FN_NAME(blend_mode)(inSrcA.b, inSrcB.b)); \
 result.g = (1.0f - (alphaA * invAlphaR)) * inSrcB.g + alphaA * invAlphaR * ((1.0f-inSrcB.a) * inSrcA.g + inSrcB.a * PER_CHANNEL_BLEND_FN_NAME(blend_mode)(inSrcA.g, inSrcB.g)); \
 result.r = (1.0f - (alphaA * invAlphaR)) * inSrcB.r + alphaA * invAlphaR * ((1.0f-inSrcB.a) * inSrcA.r + inSrcB.a * PER_CHANNEL_BLEND_FN_NAME(blend_mode)(inSrcA.r, inSrcB.r)); \
 } \
 return result; \
 }

#define DEFINE_PER_PIXEL_REC_BLEND(blend_mode) \
 GF_DEVICE_FUNCTION PixelRGB PER_PIXEL_BLEND_FN_NAME(blend_mode)(PixelRGB inSrcA, PixelRGB inSrcB, float inOpacityA, int inWidth) \
 { \
 PixelRGB dest; \
 const float alphaA = inOpacityA * inSrcA.a; \
 if (fIsLessThanOrEqual(alphaA, 0.0f)) \
 { \
 \
 dest = inSrcB; \
 } \
 else if (fIsLessThanOrEqual(inSrcB.a, 0.0f)) \
 { \
 \
 dest.b = inSrcA.b; \
 dest.g = inSrcA.g; \
 dest.r = inSrcA.r; \
 dest.a = alphaA; \
 } \
 else \
 { \
 if (inWidth <= MAX_WIDTH_FOR_REC_601) \
 { \
 dest = PER_PIXEL_BLEND_REC_FN_NAME(blend_mode, kColorCoding_Rec601)(inSrcA, inSrcB, inOpacityA, inWidth); \
 } \
 else \
 { \
 dest = PER_PIXEL_BLEND_REC_FN_NAME(blend_mode, kColorCoding_Rec709)(inSrcA, inSrcB, inOpacityA, inWidth); \
 } \
 } \
 return dest; \
 }

#define DEFINE_PER_PIXEL_BLEND(blend_mode) \
 GF_KERNEL BLENDMODE_COMPOSITE_KERNEL_NAME(blend_mode)( \
 const GF_PTR(float4) inSrc0, \
 int inSrcPitch0, \
 const GF_PTR(float4) inSrc1, \
 int inSrcPitch1, \
 GF_PTR(float4) outDest, \
 int inDestPitch, \
 DevicePixelFormat inDeviceFormat, \
 int inWidth, \
 int inHeight, \
 float inAlphaGain) \
 { \
 int x = KernelX(); \
 int y = KernelY(); \
 if (x < inWidth && y < inHeight) \
 { \
 PixelRGB destPixel; \
 PixelRGB srcPixel0 = ReadRGBPixel(inSrc0, inSrcPitch0, inDeviceFormat, x, y); \
 PixelRGB srcPixel1 = ReadRGBPixel(inSrc1, inSrcPitch1, inDeviceFormat, x, y); \
 if (blend_mode == kBlendMode_Normal) \
 { \
 destPixel = LinearComposite(srcPixel0, srcPixel1, false, inAlphaGain); \
 } \
 else \
 { \
 destPixel = PER_PIXEL_BLEND_FN_NAME(blend_mode)(srcPixel0, srcPixel1, inAlphaGain, inWidth); \
 } \
 WriteRGBPixel(destPixel, outDest, inDestPitch, inDeviceFormat, x, y); \
 } \
 }
GF_DEVICE_FUNCTION float GetLuma601( PixelRGB inPixel) { return saturate(kRGB32f_To_601YPbPr[0]*inPixel.r + kRGB32f_To_601YPbPr[1]*inPixel.g + kRGB32f_To_601YPbPr[2]*inPixel.b); } GF_DEVICE_FUNCTION float GetLuma709( PixelRGB inPixel) { return saturate(kRGB32f_To_709YPbPr[0]*inPixel.r + kRGB32f_To_709YPbPr[1]*inPixel.g + kRGB32f_To_709YPbPr[2]*inPixel.b); } GF_DEVICE_FUNCTION PixelRGB LinearComposite( PixelRGB inUpper, PixelRGB inLower, int inUpperPixelIsLinearPremultiplied, float inAlphaGain) { if (!inUpperPixelIsLinearPremultiplied) { inUpper.a = saturate(inUpper.a); } inUpper.a *= inAlphaGain; inLower.a = saturate(inLower.a); if (inUpperPixelIsLinearPremultiplied) { inUpper.b *= inAlphaGain; inUpper.g *= inAlphaGain; inUpper.r *= inAlphaGain; } else { inUpper = PremultiplyLinearizePixel(inUpper); } float da = inLower.a * (1.0f-inUpper.a); float alpha = da + inUpper.a; PixelRGB result; if (fIsLessThanOrEqual(alpha, 0.0f)) { result.b = 0.0f; result.g = 0.0f; result.r = 0.0f; result.a = 0.0f; } else { result.b = inUpper.b + ToLinearColor(inLower.b)*da; result.g = inUpper.g + ToLinearColor(inLower.g)*da; result.r = inUpper.r + ToLinearColor(inLower.r)*da; result.a = alpha; result = UnpremultiplyUnlinearizePixel(result); } return result; } GF_DEVICE_FUNCTION PixelRGB ClipColor( PixelRGB inPixel) { PixelRGB result = inPixel; float l = GetLuma601(inPixel); float n = min(inPixel.r, min(inPixel.g, inPixel.b)); float x = max(inPixel.r, max(inPixel.g, inPixel.b)); if (n < 0.0f) { result.r = l + fdividef(((result.r - l)*l), (l-n)); result.g = l + fdividef(((result.g - l)*l), (l-n)); result.b = l + fdividef(((result.b - l)*l), (l-n)); } if (x > 1.0f) { result.r = l + fdividef(((result.r - l)*(1.0f - l)), (x - l)); result.g = l + fdividef(((result.g - l)*(1.0f - l)), (x - l)); result.b = l + fdividef(((result.b - l)*(1.0f - l)), (x - l)); } return result; } GF_DEVICE_FUNCTION PixelRGB SetLuma( PixelRGB inPixel, float inLuma) { float d = inLuma - GetLuma601(inPixel); PixelRGB result; result.a = inPixel.a; result.r = inPixel.r + d; result.g = inPixel.g + d; result.b = inPixel.b + d; return ClipColor(result); } GF_DEVICE_FUNCTION float GetSaturation( PixelRGB inPixel) { return saturate(max(inPixel.r, max(inPixel.g, inPixel.b)) - min(inPixel.r, min(inPixel.g, inPixel.b))); } GF_DEVICE_FUNCTION PixelRGB SetSaturation( PixelRGB inPixel, float inSaturation) { PixelRGB result = inPixel; float n = min(result.r, min(result.g, result.b)); float x = max(result.r, max(result.g, result.b)); if (n == result.r) { if (x == result.g) { if (result.g > result.r) { result.b = fdividef(((result.b - result.r)*inSaturation), (result.g - result.r)); result.g = inSaturation; } else { result.b = result.g = 0.0f; } } else { if (result.b > result.r) { result.g = fdividef(((result.g - result.r)*inSaturation), (result.b - result.r)); result.b = inSaturation; } else { result.g = result.b = 0.0f; } } result.r = 0.0f; } else { if (x == result.r) { if (n == result.g) { if (result.r > result.g) { result.b = fdividef(((result.b - result.g)*inSaturation), (result.r - result.g)); result.r = inSaturation; } else { result.b = result.r = 0.0f; } result.g = 0.0f; } else { if (result.r > result.b) { result.g = fdividef(((result.g - result.b)*inSaturation), (result.r - result.b)); result.r = inSaturation; } else { result.g = result.r = 0.0f; } result.b = 0.0f; } } else { if (n == result.g) { if (result.b > result.g) { result.r = fdividef(((result.r - result.g)*inSaturation), (result.b - result.g)); result.b = inSaturation; } else { result.r = result.b = 0.0f; } result.g = 0.0f; } else { if (result.g > result.b) { result.r = fdividef(((result.r - result.b)*inSaturation), (result.g - result.b)); result.g = inSaturation; } else { result.r = result.g = 0.0f; } result.b = 0.0f; } } } return result; } GF_DEVICE_FUNCTION float PER_CHANNEL_BLEND_FN_NAME(kBlendMode_Normal)(float A, float B) { return A; } GF_DEVICE_FUNCTION float PER_CHANNEL_BLEND_FN_NAME(kBlendMode_Darken)(float A, float B) { return (A <= B ? A : B); } GF_DEVICE_FUNCTION float PER_CHANNEL_BLEND_FN_NAME(kBlendMode_Lighten)(float A, float B) { return (A >= B ? A : B); } GF_DEVICE_FUNCTION float PER_CHANNEL_BLEND_FN_NAME(kBlendMode_Multiply)(float A, float B) { return saturate(A * B); } GF_DEVICE_FUNCTION float PER_CHANNEL_BLEND_FN_NAME(kBlendMode_Screen)(float A, float B) { A = clamp(A, 0.0000001f, 1.0f); B = clamp(B, 0.0000001f, 1.0f); return saturate(1.0f - (1.0f - A) * (1.0f - B)); } GF_DEVICE_FUNCTION float PER_CHANNEL_BLEND_FN_NAME(kBlendMode_ColorBurn)(float A, float B) { A = clamp(A, 0.0000001f, 1.0f); B = clamp(B, 0.0f, 1.0f); return saturate(1.0f - fdividef(1.0f - B, A)); } GF_DEVICE_FUNCTION float PER_CHANNEL_BLEND_FN_NAME(kBlendMode_Overlay)(float A, float B) { A = saturate(A); B = saturate(B); return saturate(B <= 0.5f ? 2.0f * A * B : 1.0f - 2.0f * (1.0f - A) * (1.0f - B)); } GF_DEVICE_FUNCTION float PER_CHANNEL_BLEND_FN_NAME(kBlendMode_SoftLight)(float A, float B) { A = saturate(A); B = saturate(B); return saturate((A <= 0.5f ? (2.0f * A - 1.0f) * (B - B*B) + B : (2.0f * A - 1.0f) * (sqrtf(B) - B) + B)); } GF_DEVICE_FUNCTION float PER_CHANNEL_BLEND_FN_NAME(kBlendMode_HardLight)(float A, float B) { A = saturate(A); B = saturate(B); return saturate(A <= 0.5f ? 2.0f * A * B : 1.0f - 2.0f * (1.0f - A) * (1.0f - B)); } GF_DEVICE_FUNCTION float PER_CHANNEL_BLEND_FN_NAME(kBlendMode_Difference)(float A, float B) { return fabsf(A-B); } GF_DEVICE_FUNCTION float PER_CHANNEL_BLEND_FN_NAME(kBlendMode_Exclusion)(float A, float B) { A = saturate(A); B = saturate(B); return saturate(A + B - 2.0f * A * B); } GF_DEVICE_FUNCTION float PER_CHANNEL_BLEND_FN_NAME(kBlendMode_Subtract)(float A, float B) { A = saturate(A); B = saturate(B); return saturate(B - A); } GF_DEVICE_FUNCTION float PER_CHANNEL_BLEND_FN_NAME(kBlendMode_Divide)(float A, float B) { A = clamp(A, 0.0000001f, 1.0f); B = clamp(B, 0.0f, 1.0f); return saturate(fdividef(B, A)); } GF_DEVICE_FUNCTION float PER_CHANNEL_BLEND_FN_NAME(kBlendMode_ColorDodge)(float A, float B) { A = clamp(A, 0.0f, 0.99999f); B = clamp(B, 0.0f, 1.0f); return saturate(fdividef(B, 1.0f - A)); } GF_DEVICE_FUNCTION float PER_CHANNEL_BLEND_FN_NAME(kBlendMode_LinearDodgeAdd)(float A, float B) { return saturate(A + B); } GF_DEVICE_FUNCTION float PER_CHANNEL_BLEND_FN_NAME(kBlendMode_LinearBurn)(float A, float B) { A = saturate(A); B = saturate(B); return saturate(A + B - 1.0f); } GF_DEVICE_FUNCTION float PER_CHANNEL_BLEND_FN_NAME(kBlendMode_VividLight)(float A, float B) { A = clamp(A, 0.000001f, 0.999999f); B = clamp(B, 0.0f, 1.0f); if (A <= 0.5f) { return saturate(1.0f - fdividef(1.0f - B, 2.0f * A)); } else { return saturate(fdividef(B, 2.0f * (1.0f - A))); } } GF_DEVICE_FUNCTION float PER_CHANNEL_BLEND_FN_NAME(kBlendMode_LinearLight)(float A, float B) { A = saturate(A); B = saturate(B); return B + 2.0f * A - 1.0f; } GF_DEVICE_FUNCTION float PER_CHANNEL_BLEND_FN_NAME(kBlendMode_PinLight)(float A, float B) { A = saturate(A); B = saturate(B); if (B < 2.0f * A - 1.0f) { return 2.0f * A - 1.0f; } else if (B > 2.0f * A) { return 2.0f * A; } else { return B; } } GF_DEVICE_FUNCTION float PER_CHANNEL_BLEND_FN_NAME(kBlendMode_HardMix)(float A, float B) { return (A < 1.0f - B ? 0 : 1.0f); } DEFINE_PER_CHANNEL_BLEND(kBlendMode_Normal); DEFINE_PER_CHANNEL_BLEND(kBlendMode_Darken); DEFINE_PER_CHANNEL_BLEND(kBlendMode_Lighten); DEFINE_PER_CHANNEL_BLEND(kBlendMode_Multiply); DEFINE_PER_CHANNEL_BLEND(kBlendMode_Screen); DEFINE_PER_CHANNEL_BLEND(kBlendMode_ColorBurn); DEFINE_PER_CHANNEL_BLEND(kBlendMode_LinearBurn); DEFINE_PER_CHANNEL_BLEND(kBlendMode_ColorDodge); DEFINE_PER_CHANNEL_BLEND(kBlendMode_LinearDodgeAdd); DEFINE_PER_CHANNEL_BLEND(kBlendMode_Overlay); DEFINE_PER_CHANNEL_BLEND(kBlendMode_SoftLight); DEFINE_PER_CHANNEL_BLEND(kBlendMode_HardLight); DEFINE_PER_CHANNEL_BLEND(kBlendMode_VividLight); DEFINE_PER_CHANNEL_BLEND(kBlendMode_LinearLight); DEFINE_PER_CHANNEL_BLEND(kBlendMode_PinLight); DEFINE_PER_CHANNEL_BLEND(kBlendMode_HardMix); DEFINE_PER_CHANNEL_BLEND(kBlendMode_Difference); DEFINE_PER_CHANNEL_BLEND(kBlendMode_Exclusion); DEFINE_PER_CHANNEL_BLEND(kBlendMode_Subtract); DEFINE_PER_CHANNEL_BLEND(kBlendMode_Divide); GF_DEVICE_FUNCTION PixelRGB PER_PIXEL_BLEND_FN_NAME(kBlendMode_Hue)(PixelRGB inSrcA, PixelRGB inSrcB, float inOpacityA, int inWidth) { PixelRGB result = SetLuma(SetSaturation(inSrcA, GetSaturation(inSrcB)), GetLuma601(inSrcB)); return PER_PIXEL_BLEND_FN_NAME(kBlendMode_Normal)(result, inSrcB, inOpacityA, inWidth); } GF_DEVICE_FUNCTION PixelRGB PER_PIXEL_BLEND_FN_NAME(kBlendMode_Saturation)(PixelRGB inSrcA, PixelRGB inSrcB, float inOpacityA, int inWidth) { PixelRGB result = SetLuma(SetSaturation(inSrcB, GetSaturation(inSrcA)), GetLuma601(inSrcB)); result.a = inSrcA.a; return PER_PIXEL_BLEND_FN_NAME(kBlendMode_Normal)(result, inSrcB, inOpacityA, inWidth); } GF_DEVICE_FUNCTION PixelRGB PER_PIXEL_BLEND_FN_NAME(kBlendMode_Color)(PixelRGB inSrcA, PixelRGB inSrcB, float inOpacityA, int inWidth) { PixelRGB result = SetLuma(inSrcA, GetLuma601(inSrcB)); return PER_PIXEL_BLEND_FN_NAME(kBlendMode_Normal)(result, inSrcB, inOpacityA, inWidth); } GF_DEVICE_FUNCTION PixelRGB PER_PIXEL_BLEND_FN_NAME(kBlendMode_Luminosity)(PixelRGB inSrcA, PixelRGB inSrcB, float inOpacityA, int inWidth) { PixelRGB result = SetLuma(inSrcB, GetLuma601(inSrcA)); result.a = inSrcA.a; return PER_PIXEL_BLEND_FN_NAME(kBlendMode_Normal)(result, inSrcB, inOpacityA, inWidth); } GF_DEVICE_FUNCTION PixelRGB PER_PIXEL_BLEND_FN_NAME(kBlendMode_Dissolve)(PixelRGB inSrcA, PixelRGB inSrcB, float inOpacityA, int inWidth) { float alphaA = inOpacityA * inSrcA.a; if (fIsLessThanOrEqual(alphaA, 0.0f)) { return inSrcB; } else if (fIsGreaterThanOrEqual(alphaA, 1.0f)) { return inSrcA; } else { int dissolveThreshold = (alphaA * kRandMax); return Rand2D() <= dissolveThreshold ? inSrcA : inSrcB; } } GF_DEVICE_FUNCTION PixelRGB PER_PIXEL_BLEND_REC_FN_NAME(kBlendMode_DarkerColor, kColorCoding_Rec601)(PixelRGB inSrcA, PixelRGB inSrcB, float inOpacityA, int inWidth) { float srcALum = GetLuma601(inSrcA); float srcBLum = GetLuma601(inSrcB); if (srcALum < srcBLum) { return PER_PIXEL_BLEND_FN_NAME(kBlendMode_Normal)(inSrcA, inSrcB, inOpacityA, inWidth); } else { return inSrcB; } } GF_DEVICE_FUNCTION PixelRGB PER_PIXEL_BLEND_REC_FN_NAME(kBlendMode_DarkerColor, kColorCoding_Rec709)(PixelRGB inSrcA, PixelRGB inSrcB, float inOpacityA, int inWidth) { float srcALum = GetLuma709(inSrcA); float srcBLum = GetLuma709(inSrcB); if (srcALum < srcBLum) { return PER_PIXEL_BLEND_FN_NAME(kBlendMode_Normal)(inSrcA, inSrcB, inOpacityA, inWidth); } else { return inSrcB; } } GF_DEVICE_FUNCTION PixelRGB PER_PIXEL_BLEND_REC_FN_NAME(kBlendMode_LighterColor, kColorCoding_Rec601)(PixelRGB inSrcA, PixelRGB inSrcB, float inOpacityA, int inWidth) { float srcALum = GetLuma601(inSrcA); float srcBLum = GetLuma601(inSrcB); if (srcALum > srcBLum) { return PER_PIXEL_BLEND_FN_NAME(kBlendMode_Normal)(inSrcA, inSrcB, inOpacityA, inWidth); } else { return inSrcB; } } GF_DEVICE_FUNCTION PixelRGB PER_PIXEL_BLEND_REC_FN_NAME(kBlendMode_LighterColor, kColorCoding_Rec709)(PixelRGB inSrcA, PixelRGB inSrcB, float inOpacityA, int inWidth) { float srcALum = GetLuma709(inSrcA); float srcBLum = GetLuma709(inSrcB); if (srcALum > srcBLum) { return PER_PIXEL_BLEND_FN_NAME(kBlendMode_Normal)(inSrcA, inSrcB, inOpacityA, inWidth); } else { return inSrcB; } } DEFINE_PER_PIXEL_REC_BLEND(kBlendMode_DarkerColor); DEFINE_PER_PIXEL_REC_BLEND(kBlendMode_LighterColor);GF_DEVICE_FUNCTION PixelRGB CompositePixels( PixelRGB inUpper, PixelRGB inLower, int inWidth, int inHeight, float inAlphaGain, BlendMode inBlendMode, int inSrcPixelIsLinearPremultiplied) { PixelRGB result = inUpper; if (inBlendMode == kBlendMode_Normal) { result = LinearComposite(inUpper, inLower, inSrcPixelIsLinearPremultiplied, inAlphaGain); } else { if (inSrcPixelIsLinearPremultiplied) { if (fIsLessThanOrEqual(inUpper.a, 0.0f)) { inUpper.b = 0.0f; inUpper.g = 0.0f; inUpper.r = 0.0f; inUpper.a = 0.0f; } else { float ra = fdividef(1.0f, inUpper.a); inUpper.b = FromLinearColor(inUpper.b * ra); inUpper.g = FromLinearColor(inUpper.g * ra); inUpper.r = FromLinearColor(inUpper.r * ra); } } switch (inBlendMode) { case kBlendMode_Darken: result = PER_PIXEL_BLEND_FN_NAME(kBlendMode_Darken)(inUpper, inLower, inAlphaGain, inWidth); break; case kBlendMode_Lighten: result = PER_PIXEL_BLEND_FN_NAME(kBlendMode_Lighten)(inUpper, inLower, inAlphaGain, inWidth); break; case kBlendMode_Multiply: result = PER_PIXEL_BLEND_FN_NAME(kBlendMode_Multiply)(inUpper, inLower, inAlphaGain, inWidth); break; case kBlendMode_Screen: result = PER_PIXEL_BLEND_FN_NAME(kBlendMode_Screen)(inUpper, inLower, inAlphaGain, inWidth); break; case kBlendMode_Dissolve: result = PER_PIXEL_BLEND_FN_NAME(kBlendMode_Dissolve)(inUpper, inLower, inAlphaGain, inWidth); break; case kBlendMode_ColorBurn: result = PER_PIXEL_BLEND_FN_NAME(kBlendMode_ColorBurn)(inUpper, inLower, inAlphaGain, inWidth); break; case kBlendMode_LinearBurn: result = PER_PIXEL_BLEND_FN_NAME(kBlendMode_LinearBurn)(inUpper, inLower, inAlphaGain, inWidth); break; case kBlendMode_DarkerColor: result = PER_PIXEL_BLEND_FN_NAME(kBlendMode_DarkerColor)(inUpper, inLower, inAlphaGain, inWidth); break; case kBlendMode_ColorDodge: result = PER_PIXEL_BLEND_FN_NAME(kBlendMode_ColorDodge)(inUpper, inLower, inAlphaGain, inWidth); break; case kBlendMode_LinearDodgeAdd: result = PER_PIXEL_BLEND_FN_NAME(kBlendMode_LinearDodgeAdd)(inUpper, inLower, inAlphaGain, inWidth); break; case kBlendMode_LighterColor: result = PER_PIXEL_BLEND_FN_NAME(kBlendMode_LighterColor)(inUpper, inLower, inAlphaGain, inWidth); break; case kBlendMode_Overlay: result = PER_PIXEL_BLEND_FN_NAME(kBlendMode_Overlay)(inUpper, inLower, inAlphaGain, inWidth); break; case kBlendMode_SoftLight: result = PER_PIXEL_BLEND_FN_NAME(kBlendMode_SoftLight)(inUpper, inLower, inAlphaGain, inWidth); break; case kBlendMode_HardLight: result = PER_PIXEL_BLEND_FN_NAME(kBlendMode_HardLight)(inUpper, inLower, inAlphaGain, inWidth); break; case kBlendMode_VividLight: result = PER_PIXEL_BLEND_FN_NAME(kBlendMode_VividLight)(inUpper, inLower, inAlphaGain, inWidth); break; case kBlendMode_LinearLight: result = PER_PIXEL_BLEND_FN_NAME(kBlendMode_LinearLight)(inUpper, inLower, inAlphaGain, inWidth); break; case kBlendMode_PinLight: result = PER_PIXEL_BLEND_FN_NAME(kBlendMode_PinLight)(inUpper, inLower, inAlphaGain, inWidth); break; case kBlendMode_HardMix: result = PER_PIXEL_BLEND_FN_NAME(kBlendMode_HardMix)(inUpper, inLower, inAlphaGain, inWidth); break; case kBlendMode_Difference: result = PER_PIXEL_BLEND_FN_NAME(kBlendMode_Difference)(inUpper, inLower, inAlphaGain, inWidth); break; case kBlendMode_Exclusion: result = PER_PIXEL_BLEND_FN_NAME(kBlendMode_Exclusion)(inUpper, inLower, inAlphaGain, inWidth); break; case kBlendMode_Subtract: result = PER_PIXEL_BLEND_FN_NAME(kBlendMode_Subtract)(inUpper, inLower, inAlphaGain, inWidth); break; case kBlendMode_Divide: result = PER_PIXEL_BLEND_FN_NAME(kBlendMode_Divide)(inUpper, inLower, inAlphaGain, inWidth); break; case kBlendMode_Hue: result = PER_PIXEL_BLEND_FN_NAME(kBlendMode_Hue)(inUpper, inLower, inAlphaGain, inWidth); break; case kBlendMode_Saturation: result = PER_PIXEL_BLEND_FN_NAME(kBlendMode_Saturation)(inUpper, inLower, inAlphaGain, inWidth); break; case kBlendMode_Color: result = PER_PIXEL_BLEND_FN_NAME(kBlendMode_Color)(inUpper, inLower, inAlphaGain, inWidth); break; case kBlendMode_Luminosity: result = PER_PIXEL_BLEND_FN_NAME(kBlendMode_Luminosity)(inUpper, inLower, inAlphaGain, inWidth); break; default: break; } } return result; } GF_DEVICE_FUNCTION void WriteCompositedPixel( PixelRGB inPixel, GF_PTR(float4) ioImage, int inPitch, DevicePixelFormat inDeviceFormat, int inX, int inY, int inWidth, int inHeight, float inAlphaGain, BlendMode inBlendMode, int inDoCompositeOver, int inSrcPixelIsLinearPremultiplied) { if (inDoCompositeOver) { PixelRGB lower = ReadRGBPixel(ioImage, inPitch, inDeviceFormat, inX, inY); inPixel = CompositePixels(inPixel, lower, inWidth, inHeight, inAlphaGain, inBlendMode, inSrcPixelIsLinearPremultiplied); } else if (inBlendMode == kBlendMode_Normal) { if (!inSrcPixelIsLinearPremultiplied) { inPixel.a = saturate(inPixel.a); } float alpha = inPixel.a * inAlphaGain; if (inSrcPixelIsLinearPremultiplied) { if (fIsLessThanOrEqual(alpha, 0.0f)) { inPixel.b = 0.0f; inPixel.g = 0.0f; inPixel.r = 0.0f; inPixel.a = 0.0f; } else { float ra = fdividef(1.0f, inPixel.a); inPixel.b = FromLinearColor(inPixel.b * ra); inPixel.g = FromLinearColor(inPixel.g * ra); inPixel.r = FromLinearColor(inPixel.r * ra); } } inPixel.a = alpha; } WriteRGBPixel( inPixel, ioImage, inPitch, inDeviceFormat, inX, inY); }
#endif
DEFINE_PER_PIXEL_BLEND(kBlendMode_Color) DEFINE_PER_PIXEL_BLEND(kBlendMode_ColorBurn) DEFINE_PER_PIXEL_BLEND(kBlendMode_ColorDodge) DEFINE_PER_PIXEL_BLEND(kBlendMode_Darken) DEFINE_PER_PIXEL_BLEND(kBlendMode_DarkerColor) DEFINE_PER_PIXEL_BLEND(kBlendMode_Difference) DEFINE_PER_PIXEL_BLEND(kBlendMode_Dissolve) DEFINE_PER_PIXEL_BLEND(kBlendMode_Exclusion) DEFINE_PER_PIXEL_BLEND(kBlendMode_HardLight) DEFINE_PER_PIXEL_BLEND(kBlendMode_HardMix) DEFINE_PER_PIXEL_BLEND(kBlendMode_Hue) DEFINE_PER_PIXEL_BLEND(kBlendMode_Lighten) DEFINE_PER_PIXEL_BLEND(kBlendMode_LighterColor) DEFINE_PER_PIXEL_BLEND(kBlendMode_LinearBurn) DEFINE_PER_PIXEL_BLEND(kBlendMode_LinearDodgeAdd) DEFINE_PER_PIXEL_BLEND(kBlendMode_LinearLight) DEFINE_PER_PIXEL_BLEND(kBlendMode_Luminosity) DEFINE_PER_PIXEL_BLEND(kBlendMode_Multiply) DEFINE_PER_PIXEL_BLEND(kBlendMode_Normal) DEFINE_PER_PIXEL_BLEND(kBlendMode_Overlay) DEFINE_PER_PIXEL_BLEND(kBlendMode_PinLight) DEFINE_PER_PIXEL_BLEND(kBlendMode_Saturation) DEFINE_PER_PIXEL_BLEND(kBlendMode_Screen) DEFINE_PER_PIXEL_BLEND(kBlendMode_SoftLight) DEFINE_PER_PIXEL_BLEND(kBlendMode_VividLight) DEFINE_PER_PIXEL_BLEND(kBlendMode_Subtract) DEFINE_PER_PIXEL_BLEND(kBlendMode_Divide)

// buildOptions= -cl-single-precision-constant -cl-fast-relaxed-math
// RUN: %occ-cli %s --cl-options="-I%cwd -I%S  -cl-single-precision-constant -cl-fast-relaxed-math" %cfg_path --cl-device=%cl_device 2>&1
