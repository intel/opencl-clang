
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

#ifndef GFKERNELSUPPORT_PIXELUTILS_H
#define GFKERNELSUPPORT_PIXELUTILS_H

#ifndef GFKERNELSUPPORT_FLOATINGPOINT_H
#define GFKERNELSUPPORT_FLOATINGPOINT_H
GF_DEVICE_FUNCTION float Power(float inX, float inP) { return inX >= 0 ? native_powr(inX, inP) : -native_powr(-inX, inP); } GF_DEVICE_FUNCTION float fdividef(float inX, float inY) { return native_divide(inX, inY); } GF_DEVICE_FUNCTION float fabsf(float inX) { return fabs(inX); } GF_DEVICE_FUNCTION float rsqrtf(float inX) { return native_rsqrt(inX); } GF_DEVICE_FUNCTION float sqrtf(float inX) { return native_sqrt(inX); } GF_DEVICE_FUNCTION float cosf(float inX) { return native_cos(inX); } GF_DEVICE_FUNCTION float sinf(float inX) { return native_sin(inX); } GF_DEVICE_FUNCTION float atan2f(float inX, float inY) { return atan2(inX, inY); }GF_DEVICE_FUNCTION float LERP(float inA, float inB, float inS) { return inA + inS * (inB - inA); } GF_DEVICE_FUNCTION GF_HOST_FUNCTION bool fIsEqual( float inValue0, float inValue1) { return fabsf(inValue0 - inValue1) < 0.000008f; } GF_DEVICE_FUNCTION GF_HOST_FUNCTION bool fIsNotEqual( float inValue0, float inValue1) { return !fIsEqual(inValue0, inValue1); } GF_DEVICE_FUNCTION GF_HOST_FUNCTION bool fIsLessThan( float inValue0, float inValue1) { return (inValue0 - 0.000008f) < inValue1; } GF_DEVICE_FUNCTION GF_HOST_FUNCTION bool fIsLessThanOrEqual( float inValue0, float inValue1) { return (inValue0 - 0.000008f) <= inValue1; } GF_DEVICE_FUNCTION GF_HOST_FUNCTION bool fIsGreaterThan( float inValue0, float inValue1) { return (inValue0 + 0.000008f) > inValue1; } GF_DEVICE_FUNCTION GF_HOST_FUNCTION bool fIsGreaterThanOrEqual( float inValue0, float inValue1) { return (inValue0 + 0.000008f) >= inValue1; }
#endif
GF_DEVICE_FUNCTION PixelRGB AddPixels( PixelRGB inPixel0, PixelRGB inPixel1) { PixelRGB result = { inPixel0.b + inPixel1.b, inPixel0.g + inPixel1.g, inPixel0.r + inPixel1.r, inPixel0.a + inPixel1.a, }; return result; } GF_DEVICE_FUNCTION PixelRGB MultiplyPixels( PixelRGB inPixel0, PixelRGB inPixel1) { PixelRGB result = { inPixel0.b * inPixel1.b, inPixel0.g * inPixel1.g, inPixel0.r * inPixel1.r, inPixel0.a * inPixel1.a, }; return result; } GF_DEVICE_FUNCTION PixelRGB SubtractPixels( PixelRGB inPixel0, PixelRGB inPixel1) { PixelRGB result = { inPixel0.b - inPixel1.b, inPixel0.g - inPixel1.g, inPixel0.r - inPixel1.r, inPixel0.a - inPixel1.a, }; return result; } GF_DEVICE_FUNCTION PixelRGB MultiplyPixel( PixelRGB inPixel, float inS) { return MultiplyPixels(inPixel, BGRA(inS, inS, inS, inS)); } GF_DEVICE_FUNCTION PixelRGB DividePixels( PixelRGB inPixel0, PixelRGB inPixel1) { PixelRGB result = { fdividef(inPixel0.b, inPixel1.b), fdividef(inPixel0.g, inPixel1.g), fdividef(inPixel0.r, inPixel1.r), fdividef(inPixel0.a, inPixel1.a), }; return result; } GF_DEVICE_FUNCTION PixelRGB DividePixel( PixelRGB inPixel, float inS) { return DividePixels(inPixel, BGRA(inS, inS, inS, inS)); } GF_DEVICE_FUNCTION PixelRGB PowerPixels( PixelRGB inPixel, float inS) { PixelRGB result = { Power(inPixel.b, inS), Power(inPixel.g, inS), Power(inPixel.r, inS), Power(inPixel.a, inS), }; return result; } GF_DEVICE_FUNCTION PixelRGB AbsPixels( PixelRGB inPixel) { PixelRGB result = { fabsf(inPixel.b), fabsf(inPixel.g), fabsf(inPixel.r), fabsf(inPixel.a), }; return result; } GF_DEVICE_FUNCTION float MaxPixel( PixelRGB inPixel) { return max(max(max(inPixel.b, inPixel.g), inPixel.r), inPixel.a); } GF_DEVICE_FUNCTION PixelRGB ClampPixel( PixelRGB inPixel, float inMin, float inMax) { PixelRGB result = { clamp(inPixel.b, inMin, inMax), clamp(inPixel.g, inMin, inMax), clamp(inPixel.r, inMin, inMax), clamp(inPixel.a, inMin, inMax), }; return result; } GF_DEVICE_FUNCTION PixelRGB OpaquePixel( PixelRGB inPixel) { PixelRGB result = inPixel; result.a = 1.0f; return result; } GF_DEVICE_FUNCTION PixelRGB PremultiplyPixel( PixelRGB inPixel) { PixelRGB result = inPixel; result.r *= inPixel.a; result.g *= inPixel.a; result.b *= inPixel.a; return result; } GF_DEVICE_FUNCTION PixelRGB UnpremultiplyPixel( PixelRGB inPixel) { PixelRGB result = inPixel; result.a = saturate(result.a); if (!fIsLessThanOrEqual(result.a, 0.0f)) { float ra = fdividef(1.0f, result.a); result.r *= ra; result.g *= ra; result.b *= ra; } else { result.r = result.g = result.b = result.a = 0.f; } return result; } GF_DEVICE_FUNCTION float ToLinearColor(float inValue) { return Power(inValue, 2.2f); } GF_DEVICE_FUNCTION float FromLinearColor(float inValue) { return Power(inValue, 1.0f/2.2f); } GF_DEVICE_FUNCTION PixelRGB PremultiplyLinearizePixel(PixelRGB inPixel) { PixelRGB result = inPixel; result.a = saturate(result.a); result.b = ToLinearColor(result.b); result.g = ToLinearColor(result.g); result.r = ToLinearColor(result.r); return PremultiplyPixel(result); } GF_DEVICE_FUNCTION PixelRGB UnpremultiplyUnlinearizePixel(PixelRGB inPixel) { PixelRGB result = UnpremultiplyPixel(inPixel); result.b = FromLinearColor(result.b); result.g = FromLinearColor(result.g); result.r = FromLinearColor(result.r); return result; }
#endif

#ifndef POINTWISEFILTERHOST_H
#define POINTWISEFILTERHOST_H
typedef enum { kPointwiseFilter_AlphaAdjust, kPointwiseFilter_BlackAndWhite, kPointwiseFilter_BrightnessAndContrast, kPointwiseFilter_ColorBalanceRGB, kPointwiseFilter_ColorPass, kPointwiseFilter_ColorReplace, kPointwiseFilter_EdgeFeather, kPointwiseFilter_Extract, kPointwiseFilter_FastColorCorrector_Composite, kPointwiseFilter_FastColorCorrector_Luma, kPointwiseFilter_FastColorCorrector_Mask, kPointwiseFilter_GammaCorrection, kPointwiseFilter_HorizontalFlip, kPointwiseFilter_Noise, kPointwiseFilter_ProcAmp, kPointwiseFilter_Tint, kPointwiseFilter_VerticalFlip, }PointwiseFilterID; typedef struct { float mOpacity; float mIgnoreAlpha; float mInvertAlpha; float mMaskOnly; }AlphaAdjustParameters; typedef struct { float mSlopeExists; float mSlope; float mX1; float mX2; float mY1; float mY2; }BrightnessAndContrastParameters; typedef struct { float mShadowB; float mShadowG; float mShadowR; float mMidtoneB; float mMidtoneG; float mMidtoneR; float mHighlightB; float mHighlightG; float mHighlightR; float mPreserveLuma; }ColorBalanceParameters; typedef struct { float mHue; float mLightness; float mSaturation; }ColorBalanceHLSParameters; typedef struct { float mScaleB; float mScaleG; float mScaleR; }ColorBalanceRGBParameters; typedef struct { float mReverse; float mErrorTolerance; float mTargetColorB; float mTargetColorG; float mTargetColorR; }ColorPassParameters; typedef struct { float mSolid; float mErrorTolerance; float mTargetColorB; float mTargetColorG; float mTargetColorR; float mReplaceColorB; float mReplaceColorG; float mReplaceColorR; }ColorReplaceParameters; typedef struct { float mAmount; }EdgeFeatherParameters; typedef struct { float mInvert; float mBlackLevel; float mWhiteLevel; float mSoftness; }ExtractParameters;typedef struct { float mInputWhiteLevel; float mInputBlackLevel; float mOutputWhiteLevel; float mOutputBlackLevel; float mInputGrayLevel; float mSaturation; float mHueRadians; float mMaxBalanceX; float mMaxBalanceY; float mMagnitude; float mSplitScreenPercent; }FastColorCorrectorParameters; typedef struct { float mGamma; }GammaCorrectionParameters; typedef struct { float mAmount; float mUseColorNoise; float mClipResult; float mRandSeed; }NoiseParameters; typedef struct { float mBrightness; float mContrast; float mHueCosSaturation; float mHueSinSaturation; float mSplitScreenPercent; }ProcAmpParameters; typedef struct { float mBlackColorB; float mBlackColorG; float mBlackColorR; float mWhiteColorB; float mWhiteColorG; float mWhiteColorR; float mAmount; }TintParameters; typedef union { AlphaAdjustParameters mAlphaAdjustParameters; BrightnessAndContrastParameters mBrightnessAndContrastParameters; ColorBalanceParameters mColorBalanceParameters; ColorBalanceHLSParameters mColorBalanceHLSParameters; ColorBalanceRGBParameters mColorBalanceRGBParameters; ColorPassParameters mColorPassParameters; ColorReplaceParameters mColorReplaceParameters; EdgeFeatherParameters mEdgeFeatherParameters; ExtractParameters mExtractParameters; FastColorCorrectorParameters mFastColorCorrectorParameters; GammaCorrectionParameters mGammaCorrectionParameters; NoiseParameters mNoiseParameters; ProcAmpParameters mProcAmpParameters; TintParameters mTintParameters; }PointwiseFilterParameters; typedef struct { PointwiseFilterID mFilterID; PointwiseFilterParameters mParameters; }PointwiseFilter;
#endif

#ifndef ALPHAADJUST_H
#define ALPHAADJUST_H
GF_DEVICE_FUNCTION void AlphaAdjust( PixelRGB* ioPixel, int* ioX, int* ioY, int inWidth, int inHeight, GF_CONSTANT_PTR(AlphaAdjustParameters) inParameters) { ioPixel->a = saturate(ioPixel->a); if (inParameters->mMaskOnly == 1.0f) { if (inParameters->mIgnoreAlpha == 1.0f) { ioPixel->a = inParameters->mOpacity; } else { ioPixel->a *= inParameters->mOpacity; } if (inParameters->mInvertAlpha == 1.0f) { ioPixel->a = 1.0f - ioPixel->a; } ioPixel->r = ioPixel->g = ioPixel->b = ioPixel->a; } else if (inParameters->mIgnoreAlpha == 1.0f) { ioPixel->a = inParameters->mOpacity; if (inParameters->mInvertAlpha == 1.0f) { ioPixel->a = 1.0f - ioPixel->a; } } else { if (inParameters->mInvertAlpha == 1.0f) { ioPixel->a = 1.0f - ioPixel->a; } ioPixel->a *= inParameters->mOpacity; } }
#endif

#ifndef BLACKANDWHITE_H
#define BLACKANDWHITE_H

#ifndef GFKERNELSUPPORT_PIXELYUV_H
#define GFKERNELSUPPORT_PIXELYUV_H

#ifndef GFKERNELSUPPORT_COLORSPACECONVERT_H
#define GFKERNELSUPPORT_COLORSPACECONVERT_H
GF_CONSTANT(float) kRGB32f_To_601YPbPr[9] = { 0.299f , 0.587f , 0.114f, -0.168736f, -0.331264f, 0.5f, 0.5f , -0.418688f, -0.081312f, }; GF_CONSTANT(float) k601YPbPr_To_RGB32f[9] = { 1.0f, 0.0f , 1.402f, 1.0f, -0.344136f, -0.714136f, 1.0f, 1.772f , 0.0f, }; GF_CONSTANT(float) kRGB32f_To_601YCbCr[9] = { 65.481f, 128.553f, 24.966f, -37.797f, -74.203f , 112.0f, 112.0f , -93.786f , -18.214f, }; GF_CONSTANT(float) k601YCbCr_To_RGB32f[9] = { 0.00456621f, 0.0f , 0.00625893f, 0.00456621f, -0.00153396f, -0.00318811f, 0.00456621f, 0.00791071f, 0.0f, }; GF_CONSTANT(float) kRGB8u_To_601YCbCr[9] = { 65.738f / 256.0f, 129.057f / 256.0f, 25.064f / 256.0f, -37.945f / 256.0f, -74.494f / 256.0f, 112.439f / 256.0f, 112.439f / 256.0f, -94.154f / 256.0f, -18.285f / 256.0f, }; GF_CONSTANT(float) k601YCbCr_To_RGB8u[9] = { 298.082f / 256.0f, 0.0f , 408.583f / 256.0f, 298.082f / 256.0f, -100.291f / 256.0f, -208.120f / 256.0f, 298.082f / 256.0f, 516.411f / 256.0f, 0.0f, }; GF_CONSTANT(float) kRGB8u_To_601YCbCrFullRange[9] = { 76.544 / 256.0f, 150.272 / 256.0f, 29.184 / 256.0f, -43.027 / 256.0f, -84.471 / 256.0f, 127.498 / 256.0f, 127.498 / 256.0f, -106.764 / 256.0f, -20.734 / 256.0f, }; GF_CONSTANT(float) k601YCbCrFullRange_To_RGB8u[9] = { 1.0f, 0.0f , 357.510 / 256.0f, 1.0f, -87.755 / 256.0f, -182.105 / 256.0f, 1.0f, 451.860 / 256.0f, 0.0f, }; GF_CONSTANT(float) kRGB32f_To_601YCbCrFullRange[9] = { 76.245f, 149.685f, 29.07f, -42.859f, -84.141f , 127.0f, 127.0f , -106.347f, -20.653f, }; GF_CONSTANT(float) k601YCbCrFullRange_To_RGB32f[9] = { 1.0f / 255.0f, 0.0f , 357.510 / 65280.0f, 1.0f / 255.0f, -87.755 / 65280.0f, -182.105 / 65280.0f, 1.0f / 255.0f, 451.860 / 65280.0f, 0.0f, }; GF_CONSTANT(float) kRGB32f_To_709YPbPr[9] = { 0.2126f , 0.7152f , 0.0722f, -0.114572f, -0.385428f, 0.5f, 0.5f , -0.454153f, -0.045847f, }; GF_CONSTANT(float) k709YPbPr_To_RGB32f[9] = { 1.0f, 0.0f , 1.5748f, 1.0f, -0.187324f, -0.468124f, 1.0f, 1.8556f , 0.0f, }; GF_CONSTANT(float) kRGB32f_To_709YCbCr[9] = { 46.559f, 156.629f, 15.812f, -25.664f, -86.336f , 112.0f, 112.0f , -101.730f, -10.270f, }; GF_CONSTANT(float) k709YCbCr_To_RGB32f[9] = { 0.00456621f, 0.0f , 0.00703036f, 0.00456621f, -0.00083627f, -0.00208984f, 0.00456621f, 0.00828393f, 0.0f, }; GF_CONSTANT(float) k709YCbCrFullRange_To_RGB32f[9] = { 0.00392157f, 0.0f , 0.00615157f, 0.00392157f, -0.00073174f, -0.00182861f, 0.00392157f, 0.00724844f, 0.0f, }; GF_CONSTANT(float) kRGB8u_To_709YCbCr[9] = { 46.742f / 256.0f, 157.243f / 256.0f, 15.874f / 256.0f, -25.765f / 256.0f, -86.674f / 256.0f, 112.439f / 256.0f, 112.439f / 256.0f, -102.129f / 256.0f, -10.310f / 256.0f, }; GF_CONSTANT(float) k709YCbCr_To_RGB8u[9] = { 298.082f / 256.0f, 0.0f , 458.942f / 256.0f, 298.082f / 256.0f, -54.592f / 256.0f, -136.425f / 256.0f, 298.082f / 256.0f, 540.775f / 256.0f, 0.0f, }; GF_CONSTANT(float) k709YCbCr_To_601YCbCr[9] = { 1.0f, 0.099312f, 0.191700f, 0.0f, 0.989854f, -0.110653f, 0.0f, -0.072453f, 0.983398f, }; GF_CONSTANT(float) k601YCbCr_To_709YCbCr[9] = { 1.0f, -0.115550f, -0.207938f, 0.0f, 1.018640f, 0.114618f, 0.0f, 0.075049f, 1.025327f, }; GF_CONSTANT(float) kYCbCrOffset[3] = { 16.0f, 128.0f, 128.0f, }; GF_CONSTANT(float) kYCbCrFullRangeOffset[3] = { 0.0f, 128.0f, 128.0f, }; GF_DEVICE_FUNCTION float4 SwapComponentOrder( float4 inV) { float4 result = { inV.w, inV.z, inV.y, inV.x }; return result; } GF_DEVICE_FUNCTION float4 ColorSpaceConvert( float4 inPixel, GF_STATIC_CONSTANT_PTR(float) inMatrix) { return make_float4( inPixel.x, inPixel.y * inMatrix[0] + inPixel.z * inMatrix[1] + inPixel.w * inMatrix[2], inPixel.y * inMatrix[3] + inPixel.z * inMatrix[4] + inPixel.w * inMatrix[5], inPixel.y * inMatrix[6] + inPixel.z * inMatrix[7] + inPixel.w * inMatrix[8]); }
#endif
typedef struct { float a, v, u, y; } GF_ALIGN(16) PixelYUV; GF_DEVICE_FUNCTION PixelYUV ConvertRGB_To_YUV( PixelRGB inPixel) { float4 floatPixel = ColorSpaceConvert( SwapComponentOrder( ConvertRGB_To_Components(inPixel)), kRGB32f_To_601YPbPr); PixelYUV result; result.a = floatPixel.x; result.y = floatPixel.y; result.u = floatPixel.z; result.v = floatPixel.w; return result; } GF_DEVICE_FUNCTION PixelRGB ConvertYUV_To_RGB( PixelYUV inPixel) { return ConvertComponents_To_RGB( SwapComponentOrder( ColorSpaceConvert( make_float4( inPixel.a, inPixel.y, inPixel.u, inPixel.v), k601YPbPr_To_RGB32f))); }
#endif
GF_DEVICE_FUNCTION void BlackAndWhite( PixelRGB* ioPixel, int* ioX, int* ioY, int inWidth, int inHeight) { PixelYUV pixel = ConvertRGB_To_YUV(*ioPixel); pixel.u = 0.0f; pixel.v = 0.0f; *ioPixel = ConvertYUV_To_RGB(pixel); }
#endif

#ifndef BRIGTHNESSANDCONTRAST_H
#define BRIGTHNESSANDCONTRAST_H
GF_DEVICE_FUNCTION void BrightnessAndContrast( PixelRGB* ioPixel, int* ioX, int* ioY, int inWidth, int inHeight, GF_CONSTANT_PTR(BrightnessAndContrastParameters) inParameters) { if (inParameters->mSlopeExists != 0.0f) { ioPixel->r = (inParameters->mSlope*(ioPixel->r - inParameters->mX1) + inParameters->mY1); ioPixel->g = (inParameters->mSlope*(ioPixel->g - inParameters->mX1) + inParameters->mY1); ioPixel->b = (inParameters->mSlope*(ioPixel->b - inParameters->mX1) + inParameters->mY1); } else { ioPixel->r = (ioPixel->r > inParameters->mX1) ? inParameters->mY2 : inParameters->mY1; ioPixel->g = (ioPixel->g > inParameters->mX1) ? inParameters->mY2 : inParameters->mY1; ioPixel->b = (ioPixel->b > inParameters->mX1) ? inParameters->mY2 : inParameters->mY1; } }
#endif

#ifndef COLORBALANCERGB_H
#define COLORBALANCERGB_H
GF_DEVICE_FUNCTION void ColorBalanceRGB( PixelRGB* ioPixel, int* ioX, int* ioY, int inWidth, int inHeight, GF_CONSTANT_PTR(ColorBalanceRGBParameters) inParameters) { PixelRGB scale = BGRA( inParameters->mScaleB, inParameters->mScaleG, inParameters->mScaleR, 1.0f); *ioPixel = MultiplyPixels(*ioPixel, scale); }
#endif

#ifndef COLORPASS_H
#define COLORPASS_H
GF_DEVICE_FUNCTION void ColorPass( PixelRGB* ioPixel, int* ioX, int* ioY, int inWidth, int inHeight, GF_CONSTANT_PTR(ColorPassParameters) inParameters) { PixelRGB targetColor = BGRA( inParameters->mTargetColorB, inParameters->mTargetColorG, inParameters->mTargetColorR, ioPixel->a); bool reverse = inParameters->mReverse == 0.0f; float difference = MaxPixel(AbsPixels(SubtractPixels(ClampPixel(*ioPixel, 0.0f, 1.0f), targetColor))); if (difference <= inParameters->mErrorTolerance != reverse) { BlackAndWhite(ioPixel, ioX, ioY, inWidth, inHeight); } }
#endif

#ifndef COLORREPLACE_H
#define COLORREPLACE_H
GF_DEVICE_FUNCTION void ColorReplace( PixelRGB* ioPixel, int* ioX, int* ioY, int inWidth, int inHeight, GF_CONSTANT_PTR(ColorReplaceParameters) inParameters) { PixelRGB targetColor = BGRA( inParameters->mTargetColorB, inParameters->mTargetColorG, inParameters->mTargetColorR, ioPixel->a); float difference = MaxPixel(AbsPixels(SubtractPixels(ClampPixel(*ioPixel, 0.0f, 1.0f), targetColor))); if (difference <= inParameters->mErrorTolerance) { PixelRGB replaceColor = BGRA( inParameters->mReplaceColorB, inParameters->mReplaceColorG, inParameters->mReplaceColorR, ioPixel->a); if (inParameters->mSolid == 0.0f) { PixelYUV pixelYUV = ConvertRGB_To_YUV(*ioPixel); replaceColor.b *= pixelYUV.y; replaceColor.g *= pixelYUV.y; replaceColor.r *= pixelYUV.y; } *ioPixel = replaceColor; } }
#endif

#ifndef EDGEFEATHER_H
#define EDGEFEATHER_H
GF_DEVICE_FUNCTION void EdgeFeather( PixelRGB* ioPixel, int* ioX, int* ioY, int inWidth, int inHeight, GF_CONSTANT_PTR(EdgeFeatherParameters) inParameters) { int leftDistance = inParameters->mAmount - *ioX; int topDistance = inParameters->mAmount - *ioY; int rightDistance = inParameters->mAmount - (inWidth - *ioX); int bottomDistance = inParameters->mAmount - (inHeight - *ioY); int distance = max(max(max(leftDistance, topDistance), rightDistance), bottomDistance); if (distance > 0) { ioPixel->a *= fdividef(inParameters->mAmount-distance, inParameters->mAmount); } }
#endif

#ifndef EXTRACT_H
#define EXTRACT_H
GF_DEVICE_FUNCTION void Extract( PixelRGB* ioPixel, int* ioX, int* ioY, int inWidth, int inHeight, GF_CONSTANT_PTR(ExtractParameters) inParameters) { PixelYUV pixel = ConvertRGB_To_YUV(*ioPixel); float dif = (inParameters->mWhiteLevel - inParameters->mBlackLevel) * inParameters->mSoftness; float blackLeft = saturate(inParameters->mBlackLevel - dif); float blackRight = saturate(inParameters->mBlackLevel + dif); float whiteLeft = saturate(inParameters->mWhiteLevel - dif); float whiteRight = saturate(inParameters->mWhiteLevel + dif); if (pixel.y < blackLeft || pixel.y >= whiteRight) { pixel.y = 0.0f; } else if (blackRight <= pixel.y && pixel.y < whiteLeft) { pixel.y = 1.0f; } else if (pixel.y < blackRight) { pixel.y = fdividef((pixel.y - blackLeft), (2 * dif)); } else { pixel.y = fdividef((whiteRight - pixel.y), (2 * dif)); } if (inParameters->mInvert != 0.0f) { pixel.y = 1.0f - pixel.y; } pixel.u = 0.0f; pixel.v = 0.0f; *ioPixel = ConvertYUV_To_RGB(pixel); }
#endif

#ifndef FASTCOLORCORRECTOR_H
#define FASTCOLORCORRECTOR_H

#ifndef GFKERNELSUPPORT_RAND_H
#define GFKERNELSUPPORT_RAND_H
GF_CONSTANT(unsigned int) kRandMax = ((1 << 15) - 1); GF_DEVICE_FUNCTION unsigned int Mix3( unsigned int a, unsigned int b, unsigned int c) { a -= b; a -= c; a ^= (c>>13); b -= c; b -= a; b ^= (a<<8); c -= a; c -= b; c ^= (b>>13); a -= b; a -= c; a ^= (c>>12); b -= c; b -= a; b ^= (a<<16); c -= a; c -= b; c ^= (b>>5); a -= b; a -= c; a ^= (c>>3); b -= c; b -= a; b ^= (a<<10); c -= a; c -= b; c ^= (b>>15); return c; } GF_DEVICE_FUNCTION int Rand( unsigned int inSeed) { inSeed *= 1103515245; inSeed += 12345; int result = (unsigned int) (inSeed / 65536) % 256; inSeed *= 1103515245; inSeed += 12345; result <<= 7; result ^= (unsigned int) (inSeed / 65536) % 256; return result; } GF_DEVICE_FUNCTION int Rand2DSeed( unsigned int inX, unsigned int inY, unsigned int inSeed) { return Rand(Mix3(inX, inY, inSeed)); } GF_DEVICE_FUNCTION int Rand2D() { return Rand2DSeed(KernelX(), KernelY(), 1); }
#endif
GF_DEVICE_FUNCTION void FastColorCorrector_Composite( PixelRGB* ioPixel, int* ioX, int* ioY, int inWidth, int inHeight, GF_CONSTANT_PTR(FastColorCorrectorParameters) inParameters) { if (inParameters->mSplitScreenPercent >= 0.0f && *ioX < inParameters->mSplitScreenPercent*inWidth || inParameters->mSplitScreenPercent < 0.0f && *ioY < -inParameters->mSplitScreenPercent*inHeight) { PixelYUV srcPixel = ConvertRGB_To_YUV(*ioPixel); PixelYUV destPixel = srcPixel; float inputRange = (inParameters->mInputWhiteLevel - inParameters->mInputBlackLevel); float outputRange = (inParameters->mOutputWhiteLevel - inParameters->mOutputBlackLevel); float invInputRange = 1.0f / inputRange; if (inputRange != 1.0f || outputRange != 1.0f) { float randPlusMinusOne = fdividef(Rand2D(), (kRandMax * 0.5f)) - 1.0f; const float k8BitBucketSize = 1.3f / 255.0f; destPixel.y += randPlusMinusOne * (k8BitBucketSize * 0.5f); } float tempBlackLevel = destPixel.y - inParameters->mInputBlackLevel; if (inParameters->mInputGrayLevel != 1.0f) { if (tempBlackLevel < 0.0f) { destPixel.y = inParameters->mOutputBlackLevel; } else { destPixel.y = inParameters->mOutputBlackLevel + (outputRange * Power(tempBlackLevel * invInputRange, inParameters->mInputGrayLevel)); } } else { destPixel.y = (tempBlackLevel * invInputRange) * outputRange + inParameters->mOutputBlackLevel; } destPixel.u = srcPixel.u * cosf(inParameters->mHueRadians) - srcPixel.v * sinf(inParameters->mHueRadians); destPixel.v = srcPixel.v * cosf(inParameters->mHueRadians) + srcPixel.u * sinf(inParameters->mHueRadians); destPixel.u = LERP(destPixel.u, inParameters->mMaxBalanceX, inParameters->mMagnitude); destPixel.v = LERP(destPixel.v, inParameters->mMaxBalanceY, inParameters->mMagnitude); destPixel.u *= inParameters->mSaturation; destPixel.v *= inParameters->mSaturation; *ioPixel = ConvertYUV_To_RGB(destPixel); } } GF_DEVICE_FUNCTION void FastColorCorrector_Luma( PixelRGB* ioPixel, int* ioX, int* ioY, int inWidth, int inHeight, GF_CONSTANT_PTR(FastColorCorrectorParameters) inParameters) { if (inParameters->mSplitScreenPercent >= 0.0f && *ioX < inParameters->mSplitScreenPercent*inWidth || inParameters->mSplitScreenPercent < 0.0f && *ioY < -inParameters->mSplitScreenPercent*inHeight) { PixelYUV srcPixel = ConvertRGB_To_YUV(*ioPixel); PixelYUV destPixel = srcPixel; float inputRange = (inParameters->mInputWhiteLevel - inParameters->mInputBlackLevel); float outputRange = (inParameters->mOutputWhiteLevel - inParameters->mOutputBlackLevel); float tempBlackLevel = srcPixel.y - inParameters->mInputBlackLevel; if (inParameters->mInputGrayLevel != 1.0f) { destPixel.y = inParameters->mOutputBlackLevel + (outputRange * Power( max(0.0f, tempBlackLevel) / inputRange, inParameters->mInputGrayLevel)); } else { destPixel.y = (tempBlackLevel / inputRange) * outputRange + inParameters->mOutputBlackLevel; } destPixel.u = 0.0f; destPixel.v = 0.0f; *ioPixel = ConvertYUV_To_RGB(destPixel); } } GF_DEVICE_FUNCTION void FastColorCorrector_Mask( PixelRGB* ioPixel, int* ioX, int* ioY, int inWidth, int inHeight, GF_CONSTANT_PTR(FastColorCorrectorParameters) inParameters) { if (inParameters->mSplitScreenPercent >= 0.0f && *ioX < inParameters->mSplitScreenPercent*inWidth || inParameters->mSplitScreenPercent < 0.0f && *ioY < -inParameters->mSplitScreenPercent*inHeight) { PixelYUV srcPixel = ConvertRGB_To_YUV(*ioPixel); PixelYUV destPixel = srcPixel; destPixel.y = 1.0f; destPixel.u = 0.0f; destPixel.v = 0.0f; *ioPixel = ConvertYUV_To_RGB(destPixel); } }
#endif

#ifndef GAMMACORRECTION_H
#define GAMMACORRECTION_H
GF_DEVICE_FUNCTION void GammaCorrection( PixelRGB* ioPixel, int* ioX, int* ioY, int inWidth, int inHeight, GF_CONSTANT_PTR(GammaCorrectionParameters) inParameters) { *ioPixel = PowerPixels(*ioPixel, inParameters->mGamma); }
#endif

#ifndef HORIZONTALFLIP_H
#define HORIZONTALFLIP_H
GF_DEVICE_FUNCTION void HorizontalFlip( PixelRGB* ioPixel, int* ioX, int* ioY, int inWidth, int inHeight) { *ioX = inWidth - *ioX - 1; }
#endif

#ifndef NOISE_H
#define NOISE_H
GF_DEVICE_FUNCTION void Noise( PixelRGB* ioPixel, int* ioX, int* ioY, int inWidth, int inHeight, GF_CONSTANT_PTR(NoiseParameters) inParameters) { float randR; float randG; float randB; float negHalfAmount = -inParameters->mAmount * 0.5f; if (inParameters->mUseColorNoise == 1.0f) { randR = fdividef(Rand2DSeed(*ioX*3+0, *ioY, inParameters->mRandSeed), kRandMax) * inParameters->mAmount + negHalfAmount; randG = fdividef(Rand2DSeed(*ioX*3+1, *ioY, inParameters->mRandSeed), kRandMax) * inParameters->mAmount + negHalfAmount; randB = fdividef(Rand2DSeed(*ioX*3+2, *ioY, inParameters->mRandSeed), kRandMax) * inParameters->mAmount + negHalfAmount; } else { randR = randG = randB = fdividef(Rand2DSeed(*ioX, *ioY, inParameters->mRandSeed), kRandMax) * inParameters->mAmount + negHalfAmount; } ioPixel->r += randR; ioPixel->g += randG; ioPixel->b += randB; if (inParameters->mClipResult == 1.0f) { *ioPixel = ClampPixel(*ioPixel, 0.0f, 1.0f); } }
#endif

#ifndef PROCAMP_H
#define PROCAMP_H
GF_DEVICE_FUNCTION void ProcAmp( PixelRGB* ioPixel, int* ioX, int* ioY, int inWidth, int inHeight, GF_CONSTANT_PTR(ProcAmpParameters) inParameters) { if (*ioX < inParameters->mSplitScreenPercent*inWidth) { PixelYUV srcPixel = ConvertRGB_To_YUV(*ioPixel); PixelYUV destPixel; destPixel.a = srcPixel.a; destPixel.y = (inParameters->mContrast * srcPixel.y) + inParameters->mBrightness; destPixel.u = (srcPixel.u * inParameters->mHueCosSaturation) + (srcPixel.v * -inParameters->mHueSinSaturation); destPixel.v = (srcPixel.v * inParameters->mHueCosSaturation) + (srcPixel.u * inParameters->mHueSinSaturation); *ioPixel = ConvertYUV_To_RGB(destPixel); } }
#endif

#ifndef TINT_H
#define TINT_H
GF_DEVICE_FUNCTION void Tint( PixelRGB* ioPixel, int* ioX, int* ioY, int inWidth, int inHeight, GF_CONSTANT_PTR(TintParameters) inParameters) { float luma = ConvertRGB_To_YUV(*ioPixel).y; float tintB = luma * (inParameters->mWhiteColorB - inParameters->mBlackColorB) + inParameters->mBlackColorB; float tintG = luma * (inParameters->mWhiteColorG - inParameters->mBlackColorG) + inParameters->mBlackColorG; float tintR = luma * (inParameters->mWhiteColorR - inParameters->mBlackColorR) + inParameters->mBlackColorR; ioPixel->b = ioPixel->b + inParameters->mAmount * (tintB - ioPixel->b); ioPixel->g = ioPixel->g + inParameters->mAmount * (tintG - ioPixel->g); ioPixel->r = ioPixel->r + inParameters->mAmount * (tintR - ioPixel->r); }
#endif

#ifndef VERTICALFLIP_H
#define VERTICALFLIP_H
GF_DEVICE_FUNCTION void VerticalFlip( PixelRGB* ioPixel, int* ioX, int* ioY, int inWidth, int inHeight) { *ioY = inHeight - *ioY - 1; }
#endif
GF_CUDA_CONSTANT(PointwiseFilter, inFilter0) GF_CUDA_CONSTANT(PointwiseFilter, inFilter1) GF_CUDA_CONSTANT(PointwiseFilter, inFilter2) GF_CUDA_CONSTANT(PointwiseFilter, inFilter3) GF_DEVICE_FUNCTION void ApplyFilter( PixelRGB* ioPixel, int* ioX, int* ioY, int inWidth, int inHeight, GF_CONSTANT_PTR(PointwiseFilter) inFilter) { switch (inFilter->mFilterID) { case kPointwiseFilter_AlphaAdjust: AlphaAdjust(ioPixel, ioX, ioY, inWidth, inHeight, &inFilter->mParameters.mAlphaAdjustParameters); break; case kPointwiseFilter_BlackAndWhite: BlackAndWhite(ioPixel, ioX, ioY, inWidth, inHeight); break; case kPointwiseFilter_BrightnessAndContrast: BrightnessAndContrast(ioPixel, ioX, ioY, inWidth, inHeight, &inFilter->mParameters.mBrightnessAndContrastParameters); break; case kPointwiseFilter_ColorBalanceRGB: ColorBalanceRGB(ioPixel, ioX, ioY, inWidth, inHeight, &inFilter->mParameters.mColorBalanceRGBParameters); break; case kPointwiseFilter_ColorPass: ColorPass(ioPixel, ioX, ioY, inWidth, inHeight, &inFilter->mParameters.mColorPassParameters); break; case kPointwiseFilter_ColorReplace: ColorReplace(ioPixel, ioX, ioY, inWidth, inHeight, &inFilter->mParameters.mColorReplaceParameters); break; case kPointwiseFilter_EdgeFeather: EdgeFeather(ioPixel, ioX, ioY, inWidth, inHeight, &inFilter->mParameters.mEdgeFeatherParameters); break; case kPointwiseFilter_Extract: Extract(ioPixel, ioX, ioY, inWidth, inHeight, &inFilter->mParameters.mExtractParameters); break; case kPointwiseFilter_FastColorCorrector_Composite: FastColorCorrector_Composite(ioPixel, ioX, ioY, inWidth, inHeight, &inFilter->mParameters.mFastColorCorrectorParameters); break; case kPointwiseFilter_FastColorCorrector_Luma: FastColorCorrector_Luma(ioPixel, ioX, ioY, inWidth, inHeight, &inFilter->mParameters.mFastColorCorrectorParameters); break; case kPointwiseFilter_FastColorCorrector_Mask: FastColorCorrector_Mask(ioPixel, ioX, ioY, inWidth, inHeight, &inFilter->mParameters.mFastColorCorrectorParameters); break; case kPointwiseFilter_GammaCorrection: GammaCorrection(ioPixel, ioX, ioY, inWidth, inHeight, &inFilter->mParameters.mGammaCorrectionParameters); break; case kPointwiseFilter_HorizontalFlip: HorizontalFlip(ioPixel, ioX, ioY, inWidth, inHeight); break; case kPointwiseFilter_Noise: Noise(ioPixel, ioX, ioY, inWidth, inHeight, &inFilter->mParameters.mNoiseParameters); break; case kPointwiseFilter_ProcAmp: ProcAmp(ioPixel, ioX, ioY, inWidth, inHeight, &inFilter->mParameters.mProcAmpParameters); break; case kPointwiseFilter_Tint: Tint(ioPixel, ioX, ioY, inWidth, inHeight, &inFilter->mParameters.mTintParameters); break; case kPointwiseFilter_VerticalFlip: VerticalFlip(ioPixel, ioX, ioY, inWidth, inHeight); break; } } GF_KERNEL PointwiseFilterHostKernel1( const GF_PTR(float4) inSrcImage, int inSrcPitch, GF_PTR(float4) inDestImage, int inDestPitch, DevicePixelFormat inDeviceFormat, int inWidth, int inHeight, GF_OPENCL_CONSTANT(PointwiseFilter, inFilter0)) { int x = KernelX(); int y = KernelY(); if (x < inWidth && y < inHeight) { PixelRGB pixel = ReadRGBPixel(inSrcImage, inSrcPitch, inDeviceFormat, x, y); ApplyFilter(&pixel, &x, &y, inWidth, inHeight, GF_GET_CONSTANT(inFilter0)); WriteRGBPixel(pixel, inDestImage, inDestPitch, inDeviceFormat, x, y); } } GF_KERNEL PointwiseFilterHostKernel2( const GF_PTR(float4) inSrcImage, int inSrcPitch, GF_PTR(float4) inDestImage, int inDestPitch, DevicePixelFormat inDeviceFormat, int inWidth, int inHeight, GF_OPENCL_CONSTANT(PointwiseFilter, inFilter0), GF_OPENCL_CONSTANT(PointwiseFilter, inFilter1)) { int x = KernelX(); int y = KernelY(); if (x < inWidth && y < inHeight) { PixelRGB pixel = ReadRGBPixel(inSrcImage, inSrcPitch, inDeviceFormat, x, y); ApplyFilter(&pixel, &x, &y, inWidth, inHeight, GF_GET_CONSTANT(inFilter1)); ApplyFilter(&pixel, &x, &y, inWidth, inHeight, GF_GET_CONSTANT(inFilter0)); WriteRGBPixel(pixel, inDestImage, inDestPitch, inDeviceFormat, x, y); } } GF_KERNEL PointwiseFilterHostKernel3( const GF_PTR(float4) inSrcImage, int inSrcPitch, GF_PTR(float4) inDestImage, int inDestPitch, DevicePixelFormat inDeviceFormat, int inWidth, int inHeight, GF_OPENCL_CONSTANT(PointwiseFilter, inFilter0), GF_OPENCL_CONSTANT(PointwiseFilter, inFilter1), GF_OPENCL_CONSTANT(PointwiseFilter, inFilter2)) { int x = KernelX(); int y = KernelY(); if (x < inWidth && y < inHeight) { PixelRGB pixel = ReadRGBPixel(inSrcImage, inSrcPitch, inDeviceFormat, x, y); ApplyFilter(&pixel, &x, &y, inWidth, inHeight, GF_GET_CONSTANT(inFilter2)); ApplyFilter(&pixel, &x, &y, inWidth, inHeight, GF_GET_CONSTANT(inFilter1)); ApplyFilter(&pixel, &x, &y, inWidth, inHeight, GF_GET_CONSTANT(inFilter0)); WriteRGBPixel(pixel, inDestImage, inDestPitch, inDeviceFormat, x, y); } } GF_KERNEL PointwiseFilterHostKernel4( const GF_PTR(float4) inSrcImage, int inSrcPitch, GF_PTR(float4) inDestImage, int inDestPitch, DevicePixelFormat inDeviceFormat, int inWidth, int inHeight, GF_OPENCL_CONSTANT(PointwiseFilter, inFilter0), GF_OPENCL_CONSTANT(PointwiseFilter, inFilter1), GF_OPENCL_CONSTANT(PointwiseFilter, inFilter2), GF_OPENCL_CONSTANT(PointwiseFilter, inFilter3)) { int x = KernelX(); int y = KernelY(); if (x < inWidth && y < inHeight) { PixelRGB pixel = ReadRGBPixel(inSrcImage, inSrcPitch, inDeviceFormat, x, y); ApplyFilter(&pixel, &x, &y, inWidth, inHeight, GF_GET_CONSTANT(inFilter3)); ApplyFilter(&pixel, &x, &y, inWidth, inHeight, GF_GET_CONSTANT(inFilter2)); ApplyFilter(&pixel, &x, &y, inWidth, inHeight, GF_GET_CONSTANT(inFilter1)); ApplyFilter(&pixel, &x, &y, inWidth, inHeight, GF_GET_CONSTANT(inFilter0)); WriteRGBPixel(pixel, inDestImage, inDestPitch, inDeviceFormat, x, y); } }


// buildOptions=-cl-single-precision-constant -cl-fast-relaxed-math -cl-denorms-are-zero -cl-mad-enable -D GF_OPENCL_SUPPORTS_16F
// RUN: %occ-cli %s --cl-options="-I%cwd -I%S -cl-single-precision-constant -cl-fast-relaxed-math -cl-denorms-are-zero -cl-mad-enable -D GF_OPENCL_SUPPORTS_16F" %cfg_path --cl-device=%cl_device 2>&1
