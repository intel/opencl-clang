
#ifndef COLORCORRECTOR_COMMON_H
#define COLORCORRECTOR_COMMON_H

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
GF_DEVICE_FUNCTION float Power(float inX, float inP) { return inX >= 0 ? native_powr(inX, inP) : -native_powr(-inX, inP); } GF_DEVICE_FUNCTION float fdividef(float inX, float inY) { return native_divide(inX, inY); } GF_DEVICE_FUNCTION float fabsf(float inX) { return fabs(inX); } GF_DEVICE_FUNCTION float rsqrtf(float inX) { return native_rsqrt(inX); } GF_DEVICE_FUNCTION float sqrtf(float inX) { return native_sqrt(inX); } GF_DEVICE_FUNCTION float cosf(float inX) { return native_cos(inX); } GF_DEVICE_FUNCTION float sinf(float inX) { return native_sin(inX); } GF_DEVICE_FUNCTION float atan2f(float inX, float inY) { return atan2(inX, inY); }GF_DEVICE_FUNCTION float LERP(float inA, float inB, float inS) { return inA + inS * (inB - inA); } GF_DEVICE_FUNCTION GF_HOST_FUNCTION bool fIsEqual( float inValue0, float inValue1) { return fabsf(inValue0 - inValue1) < 0.000008f; } GF_DEVICE_FUNCTION GF_HOST_FUNCTION bool fIsNotEqual( float inValue0, float inValue1) { return !fIsEqual(inValue0, inValue1); } GF_DEVICE_FUNCTION GF_HOST_FUNCTION bool fIsLessThan( float inValue0, float inValue1) { return (inValue0 - 0.000008f) < inValue1; } GF_DEVICE_FUNCTION GF_HOST_FUNCTION bool fIsLessThanOrEqual( float inValue0, float inValue1) { return (inValue0 - 0.000008f) <= inValue1; } GF_DEVICE_FUNCTION GF_HOST_FUNCTION bool fIsGreaterThan( float inValue0, float inValue1) { return (inValue0 + 0.000008f) > inValue1; } GF_DEVICE_FUNCTION GF_HOST_FUNCTION bool fIsGreaterThanOrEqual( float inValue0, float inValue1) { return (inValue0 + 0.000008f) >= inValue1; }
#endif
GF_DEVICE_FUNCTION float CalculateShadowsWeight( float inValue, float inShadowsThreshold, float inShadowsSoftness) { if (inValue <= inShadowsThreshold) { return 1.0f; } else if (inValue >= inShadowsThreshold + inShadowsSoftness) { return 0.0f; } else { return fdividef(inValue - inShadowsThreshold, inShadowsSoftness); } } GF_DEVICE_FUNCTION float CalculateHighlightsWeight( float inValue, float inHighlightsThreshold, float inHighlightsSoftness) { if (inValue < inHighlightsThreshold - inHighlightsSoftness) { return 0.0f; } else if (inValue > inHighlightsThreshold) { return 1.0f; } else { return fdividef(inValue - (inHighlightsThreshold - inHighlightsSoftness), inHighlightsSoftness); } }
#endif

#ifndef COLORCORRECTOR_CURVES_H
#define COLORCORRECTOR_CURVES_H
enum { kMaxWaveFormPoints = 16 }; typedef struct { float mPointsX[kMaxWaveFormPoints]; float mPointsY[kMaxWaveFormPoints]; float mPointsY2[kMaxWaveFormPoints]; size_t mSize; } WaveformCurveParameters; GF_DEVICE_FUNCTION float InterpolateNaturalCubicSpline2D( GF_CONSTANT_PTR(float) xa, GF_CONSTANT_PTR(float) ya, GF_CONSTANT_PTR(float) y2a, size_t n, float x) { float value = x; size_t k = 0; size_t klo = 0; size_t khi = n - 1; float h, b, a; while (khi - klo > 1) { k = (khi + klo) >> 1; if (xa[k] > x) { khi = k; } else { klo = k; } } h = xa[khi] - xa[klo]; if (h != 0.0f) { a = (xa[khi] - x) / h; b = (x - xa[klo]) / h; value = (float)(a * ya[klo] + b * ya[khi] + ((a*a*a-a) * y2a[klo] + (b*b*b-b) * y2a[khi]) * (h*h) / 6.0f); } return value; } GF_DEVICE_FUNCTION float ApplyCurve( GF_CONSTANT_PTR(WaveformCurveParameters) inSpline, float inX) { float value = inX; if (inX < inSpline->mPointsX[0]) { value = inX + inSpline->mPointsY[0]; } else if (inX > inSpline->mPointsX[inSpline->mSize-1]) { value = inX - (1.0f - inSpline->mPointsY[inSpline->mSize-1]); } else { value = InterpolateNaturalCubicSpline2D(inSpline->mPointsX, inSpline->mPointsY, inSpline->mPointsY2, inSpline->mSize, inX); } return value; }
#endif

#ifndef GFKERNELSUPPORT_PIXELYUV_H
#define GFKERNELSUPPORT_PIXELYUV_H

#ifndef GFKERNELSUPPORT_PIXELRGB_H
#define GFKERNELSUPPORT_PIXELRGB_H

#ifndef GFDEVICEPIXELFORMAT_H
#define GFDEVICEPIXELFORMAT_H
typedef enum { kDevicePixelFormat_BGRA_4444_16f, kDevicePixelFormat_BGRA_4444_32f, } DevicePixelFormat;
#endif
typedef struct { float b, g, r, a; } GF_ALIGN(16) PixelRGB; GF_DEVICE_FUNCTION PixelRGB BGRA( float inB, float inG, float inR, float inA) { PixelRGB pixel; pixel.b = inB; pixel.g = inG; pixel.r = inR; pixel.a = inA; return pixel; } GF_DEVICE_FUNCTION float4 ConvertRGB_To_Components( PixelRGB inPixel) { return *(float4*)&inPixel; } GF_DEVICE_FUNCTION PixelRGB ConvertComponents_To_RGB( float4 inPixel) { return *(PixelRGB*)&inPixel; }GF_DEVICE_FUNCTION float4 ReadPixel( const GF_PTR(float4) inImage, int inPitch, DevicePixelFormat inDeviceFormat, int inX, int inY) { return GF_READ2D(inImage, inPitch, inX, inY); } GF_DEVICE_FUNCTION void WritePixel( float4 inPixel, GF_PTR(float4) outImage, int inPitch, DevicePixelFormat inDeviceFormat, int inX, int inY) { GF_WRITE2D(inPixel, outImage, inPitch, inX, inY); }GF_DEVICE_FUNCTION PixelRGB ReadRGBPixel( const GF_PTR(float4) inImage, int inPitch, DevicePixelFormat inDeviceFormat, int inX, int inY) { return ConvertComponents_To_RGB(ReadPixel(inImage, inPitch, inDeviceFormat, inX, inY)); } GF_DEVICE_FUNCTION void WriteRGBPixel( PixelRGB inPixel, GF_PTR(float4) outImage, int inPitch, DevicePixelFormat inDeviceFormat, int inX, int inY) { WritePixel(ConvertRGB_To_Components(inPixel), outImage, inPitch, inDeviceFormat, inX, inY); }
#define GF_READTEXTUREPIXEL(I, X, Y, S) ConvertComponents_To_RGB(GF_READTEXTURE(I, X, Y, S))

#endif

#ifndef GFKERNELSUPPORT_COLORSPACECONVERT_H
#define GFKERNELSUPPORT_COLORSPACECONVERT_H
GF_CONSTANT(float) kRGB32f_To_601YPbPr[9] = { 0.299f , 0.587f , 0.114f, -0.168736f, -0.331264f, 0.5f, 0.5f , -0.418688f, -0.081312f, }; GF_CONSTANT(float) k601YPbPr_To_RGB32f[9] = { 1.0f, 0.0f , 1.402f, 1.0f, -0.344136f, -0.714136f, 1.0f, 1.772f , 0.0f, }; GF_CONSTANT(float) kRGB32f_To_601YCbCr[9] = { 65.481f, 128.553f, 24.966f, -37.797f, -74.203f , 112.0f, 112.0f , -93.786f , -18.214f, }; GF_CONSTANT(float) k601YCbCr_To_RGB32f[9] = { 0.00456621f, 0.0f , 0.00625893f, 0.00456621f, -0.00153396f, -0.00318811f, 0.00456621f, 0.00791071f, 0.0f, }; GF_CONSTANT(float) kRGB8u_To_601YCbCr[9] = { 65.738f / 256.0f, 129.057f / 256.0f, 25.064f / 256.0f, -37.945f / 256.0f, -74.494f / 256.0f, 112.439f / 256.0f, 112.439f / 256.0f, -94.154f / 256.0f, -18.285f / 256.0f, }; GF_CONSTANT(float) k601YCbCr_To_RGB8u[9] = { 298.082f / 256.0f, 0.0f , 408.583f / 256.0f, 298.082f / 256.0f, -100.291f / 256.0f, -208.120f / 256.0f, 298.082f / 256.0f, 516.411f / 256.0f, 0.0f, }; GF_CONSTANT(float) kRGB8u_To_601YCbCrFullRange[9] = { 76.544 / 256.0f, 150.272 / 256.0f, 29.184 / 256.0f, -43.027 / 256.0f, -84.471 / 256.0f, 127.498 / 256.0f, 127.498 / 256.0f, -106.764 / 256.0f, -20.734 / 256.0f, }; GF_CONSTANT(float) k601YCbCrFullRange_To_RGB8u[9] = { 1.0f, 0.0f , 357.510 / 256.0f, 1.0f, -87.755 / 256.0f, -182.105 / 256.0f, 1.0f, 451.860 / 256.0f, 0.0f, }; GF_CONSTANT(float) kRGB32f_To_601YCbCrFullRange[9] = { 76.245f, 149.685f, 29.07f, -42.859f, -84.141f , 127.0f, 127.0f , -106.347f, -20.653f, }; GF_CONSTANT(float) k601YCbCrFullRange_To_RGB32f[9] = { 1.0f / 255.0f, 0.0f , 357.510 / 65280.0f, 1.0f / 255.0f, -87.755 / 65280.0f, -182.105 / 65280.0f, 1.0f / 255.0f, 451.860 / 65280.0f, 0.0f, }; GF_CONSTANT(float) kRGB32f_To_709YPbPr[9] = { 0.2126f , 0.7152f , 0.0722f, -0.114572f, -0.385428f, 0.5f, 0.5f , -0.454153f, -0.045847f, }; GF_CONSTANT(float) k709YPbPr_To_RGB32f[9] = { 1.0f, 0.0f , 1.5748f, 1.0f, -0.187324f, -0.468124f, 1.0f, 1.8556f , 0.0f, }; GF_CONSTANT(float) kRGB32f_To_709YCbCr[9] = { 46.559f, 156.629f, 15.812f, -25.664f, -86.336f , 112.0f, 112.0f , -101.730f, -10.270f, }; GF_CONSTANT(float) k709YCbCr_To_RGB32f[9] = { 0.00456621f, 0.0f , 0.00703036f, 0.00456621f, -0.00083627f, -0.00208984f, 0.00456621f, 0.00828393f, 0.0f, }; GF_CONSTANT(float) k709YCbCrFullRange_To_RGB32f[9] = { 0.00392157f, 0.0f , 0.00615157f, 0.00392157f, -0.00073174f, -0.00182861f, 0.00392157f, 0.00724844f, 0.0f, }; GF_CONSTANT(float) kRGB8u_To_709YCbCr[9] = { 46.742f / 256.0f, 157.243f / 256.0f, 15.874f / 256.0f, 25.762f / 256.0f, -86.674f / 256.0f, 112.439f / 256.0f, 112.439f / 256.0f, -102.129f / 256.0f, -10.310f / 256.0f, }; GF_CONSTANT(float) k709YCbCr_To_RGB8u[9] = { 298.082f / 256.0f, 0.0f , 458.942f / 256.0f, 298.082f / 256.0f, -54.592f / 256.0f, -136.425f / 256.0f, 298.082f / 256.0f, 540.775f / 256.0f, 0.0f, }; GF_CONSTANT(float) k709YCbCr_To_601YCbCr[9] = { 1.0f, 0.099312f, 0.191700f, 0.0f, 0.989854f, -0.110653f, 0.0f, -0.072453f, 0.983398f, }; GF_CONSTANT(float) k601YCbCr_To_709YCbCr[9] = { 1.0f, -0.115550f, -0.207938f, 0.0f, 1.018640f, 0.114618f, 0.0f, 0.075049f, 1.025327f, }; GF_CONSTANT(float) kYCbCrOffset[3] = { 16.0f, 128.0f, 128.0f, }; GF_CONSTANT(float) kYCbCrFullRangeOffset[3] = { 0.0f, 128.0f, 128.0f, }; GF_DEVICE_FUNCTION float4 SwapComponentOrder( float4 inV) { float4 result = { inV.w, inV.z, inV.y, inV.x }; return result; } GF_DEVICE_FUNCTION float4 ColorSpaceConvert( float4 inPixel, GF_STATIC_CONSTANT_PTR(float) inMatrix) { return make_float4( inPixel.x, inPixel.y * inMatrix[0] + inPixel.z * inMatrix[1] + inPixel.w * inMatrix[2], inPixel.y * inMatrix[3] + inPixel.z * inMatrix[4] + inPixel.w * inMatrix[5], inPixel.y * inMatrix[6] + inPixel.z * inMatrix[7] + inPixel.w * inMatrix[8]); }
#endif
typedef struct { float a, v, u, y; } GF_ALIGN(16) PixelYUV; GF_DEVICE_FUNCTION PixelYUV ConvertRGB_To_YUV( PixelRGB inPixel) { float4 floatPixel = ColorSpaceConvert( SwapComponentOrder( ConvertRGB_To_Components(inPixel)), kRGB32f_To_601YPbPr); PixelYUV result; result.a = floatPixel.x; result.y = floatPixel.y; result.u = floatPixel.z; result.v = floatPixel.w; return result; } GF_DEVICE_FUNCTION PixelRGB ConvertYUV_To_RGB( PixelYUV inPixel) { return ConvertComponents_To_RGB( SwapComponentOrder( ColorSpaceConvert( make_float4( inPixel.a, inPixel.y, inPixel.u, inPixel.v), k601YPbPr_To_RGB32f))); }
#endif
GF_CUDA_CONSTANT(WaveformCurveParameters, inSpline) GF_DEVICE_FUNCTION float CalculateLuma( GF_CONSTANT_PTR(WaveformCurveParameters) inSpline, float inY, float inSecondaryWeight) { float luma = inY; if (inSecondaryWeight > 0.001f) { luma = ApplyCurve(inSpline, inY); luma = LERP(inY, luma, inSecondaryWeight); } return luma; } GF_KERNEL LumaCurve_MaskKernel( GF_PTR(float4) inImage, int inPitch, GF_PTR(float) inSecondaryMask, int inSecondaryPitch, DevicePixelFormat inDeviceFormat, int inWidth, int inHeight) { int x = KernelX(); int y = KernelY(); if (x < inWidth && y < inHeight) { PixelYUV pixel = ConvertRGB_To_YUV(ReadRGBPixel(inImage, inPitch, inDeviceFormat, x, y)); float secondaryWeight = inSecondaryMask ? GF_READ2D(inSecondaryMask, inSecondaryPitch, x, y) : 1.0f; pixel.y = secondaryWeight; pixel.u = pixel.v = 0.0f; pixel.a = 1.0f; WriteRGBPixel(ConvertYUV_To_RGB(pixel), inImage, inPitch, inDeviceFormat, x, y); } } GF_KERNEL LumaCurve_LumaKernel( GF_PTR(float4) inImage, int inPitch, GF_PTR(float) inSecondaryMask, int inSecondaryPitch, DevicePixelFormat inDeviceFormat, int inWidth, int inHeight, GF_OPENCL_CONSTANT(WaveformCurveParameters, inSpline)) { int x = KernelX(); int y = KernelY(); if (x < inWidth && y < inHeight) { PixelYUV pixel = ConvertRGB_To_YUV(ReadRGBPixel(inImage, inPitch, inDeviceFormat, x, y)); float secondaryWeight = inSecondaryMask ? GF_READ2D(inSecondaryMask, inSecondaryPitch, x, y) : 1.0f; pixel.y = CalculateLuma(GF_GET_CONSTANT(inSpline), pixel.y, secondaryWeight); pixel.u = pixel.v = 0.0f; pixel.a = 1.0f; WriteRGBPixel(ConvertYUV_To_RGB(pixel), inImage, inPitch, inDeviceFormat, x, y); } } GF_KERNEL LumaCurve_CompositeKernel( GF_PTR(float4) inImage, int inPitch, GF_PTR(float) inSecondaryMask, int inSecondaryPitch, DevicePixelFormat inDeviceFormat, int inWidth, int inHeight, GF_OPENCL_CONSTANT(WaveformCurveParameters, inSpline)) { int x = KernelX(); int y = KernelY(); if (x < inWidth && y < inHeight) { PixelYUV pixel = ConvertRGB_To_YUV(ReadRGBPixel(inImage, inPitch, inDeviceFormat, x, y)); float secondaryWeight = inSecondaryMask ? GF_READ2D(inSecondaryMask, inSecondaryPitch, x, y) : 1.0f; pixel.y = CalculateLuma(GF_GET_CONSTANT(inSpline), pixel.y, secondaryWeight); WriteRGBPixel(ConvertYUV_To_RGB(pixel), inImage, inPitch, inDeviceFormat, x, y); } }

// buildOptions= -cl-single-precision-constant -cl-fast-relaxed-math
// RUN: %occ-cli %s --cl-options="-I%cwd -I%S  -cl-single-precision-constant -cl-fast-relaxed-math" %cfg_path --cl-device=%cl_device 2>&1
