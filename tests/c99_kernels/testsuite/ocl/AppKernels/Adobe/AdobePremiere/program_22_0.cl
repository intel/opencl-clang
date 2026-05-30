
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

#ifndef GFKERNELSUPPORT_PIXELHSL_H
#define GFKERNELSUPPORT_PIXELHSL_H

#ifndef GFKERNELSUPPORT_FLOATINGPOINT_H
#define GFKERNELSUPPORT_FLOATINGPOINT_H
GF_DEVICE_FUNCTION float Power(float inX, float inP) { return inX >= 0 ? native_powr(inX, inP) : -native_powr(-inX, inP); } GF_DEVICE_FUNCTION float fdividef(float inX, float inY) { return native_divide(inX, inY); } GF_DEVICE_FUNCTION float fabsf(float inX) { return fabs(inX); } GF_DEVICE_FUNCTION float rsqrtf(float inX) { return native_rsqrt(inX); } GF_DEVICE_FUNCTION float sqrtf(float inX) { return native_sqrt(inX); } GF_DEVICE_FUNCTION float cosf(float inX) { return native_cos(inX); } GF_DEVICE_FUNCTION float sinf(float inX) { return native_sin(inX); } GF_DEVICE_FUNCTION float atan2f(float inX, float inY) { return atan2(inX, inY); }GF_DEVICE_FUNCTION float LERP(float inA, float inB, float inS) { return inA + inS * (inB - inA); } GF_DEVICE_FUNCTION GF_HOST_FUNCTION bool fIsEqual( float inValue0, float inValue1) { return fabsf(inValue0 - inValue1) < 0.000008f; } GF_DEVICE_FUNCTION GF_HOST_FUNCTION bool fIsNotEqual( float inValue0, float inValue1) { return !fIsEqual(inValue0, inValue1); } GF_DEVICE_FUNCTION GF_HOST_FUNCTION bool fIsLessThan( float inValue0, float inValue1) { return (inValue0 - 0.000008f) < inValue1; } GF_DEVICE_FUNCTION GF_HOST_FUNCTION bool fIsLessThanOrEqual( float inValue0, float inValue1) { return (inValue0 - 0.000008f) <= inValue1; } GF_DEVICE_FUNCTION GF_HOST_FUNCTION bool fIsGreaterThan( float inValue0, float inValue1) { return (inValue0 + 0.000008f) > inValue1; } GF_DEVICE_FUNCTION GF_HOST_FUNCTION bool fIsGreaterThanOrEqual( float inValue0, float inValue1) { return (inValue0 + 0.000008f) >= inValue1; }
#endif

#ifndef GFKERNELSUPPORT_PIXELYUV_H
#define GFKERNELSUPPORT_PIXELYUV_H

#ifndef GFKERNELSUPPORT_COLORSPACECONVERT_H
#define GFKERNELSUPPORT_COLORSPACECONVERT_H
GF_CONSTANT(float) kRGB32f_To_601YPbPr[9] = { 0.299f , 0.587f , 0.114f, -0.168736f, -0.331264f, 0.5f, 0.5f , -0.418688f, -0.081312f, }; GF_CONSTANT(float) k601YPbPr_To_RGB32f[9] = { 1.0f, 0.0f , 1.402f, 1.0f, -0.344136f, -0.714136f, 1.0f, 1.772f , 0.0f, }; GF_CONSTANT(float) kRGB32f_To_601YCbCr[9] = { 65.481f, 128.553f, 24.966f, -37.797f, -74.203f , 112.0f, 112.0f , -93.786f , -18.214f, }; GF_CONSTANT(float) k601YCbCr_To_RGB32f[9] = { 0.00456621f, 0.0f , 0.00625893f, 0.00456621f, -0.00153396f, -0.00318811f, 0.00456621f, 0.00791071f, 0.0f, }; GF_CONSTANT(float) kRGB8u_To_601YCbCr[9] = { 65.738f / 256.0f, 129.057f / 256.0f, 25.064f / 256.0f, -37.945f / 256.0f, -74.494f / 256.0f, 112.439f / 256.0f, 112.439f / 256.0f, -94.154f / 256.0f, -18.285f / 256.0f, }; GF_CONSTANT(float) k601YCbCr_To_RGB8u[9] = { 298.082f / 256.0f, 0.0f , 408.583f / 256.0f, 298.082f / 256.0f, -100.291f / 256.0f, -208.120f / 256.0f, 298.082f / 256.0f, 516.411f / 256.0f, 0.0f, }; GF_CONSTANT(float) kRGB8u_To_601YCbCrFullRange[9] = { 76.544 / 256.0f, 150.272 / 256.0f, 29.184 / 256.0f, -43.027 / 256.0f, -84.471 / 256.0f, 127.498 / 256.0f, 127.498 / 256.0f, -106.764 / 256.0f, -20.734 / 256.0f, }; GF_CONSTANT(float) k601YCbCrFullRange_To_RGB8u[9] = { 1.0f, 0.0f , 357.510 / 256.0f, 1.0f, -87.755 / 256.0f, -182.105 / 256.0f, 1.0f, 451.860 / 256.0f, 0.0f, }; GF_CONSTANT(float) kRGB32f_To_601YCbCrFullRange[9] = { 76.245f, 149.685f, 29.07f, -42.859f, -84.141f , 127.0f, 127.0f , -106.347f, -20.653f, }; GF_CONSTANT(float) k601YCbCrFullRange_To_RGB32f[9] = { 1.0f / 255.0f, 0.0f , 357.510 / 65280.0f, 1.0f / 255.0f, -87.755 / 65280.0f, -182.105 / 65280.0f, 1.0f / 255.0f, 451.860 / 65280.0f, 0.0f, }; GF_CONSTANT(float) kRGB32f_To_709YPbPr[9] = { 0.2126f , 0.7152f , 0.0722f, -0.114572f, -0.385428f, 0.5f, 0.5f , -0.454153f, -0.045847f, }; GF_CONSTANT(float) k709YPbPr_To_RGB32f[9] = { 1.0f, 0.0f , 1.5748f, 1.0f, -0.187324f, -0.468124f, 1.0f, 1.8556f , 0.0f, }; GF_CONSTANT(float) kRGB32f_To_709YCbCr[9] = { 46.559f, 156.629f, 15.812f, -25.664f, -86.336f , 112.0f, 112.0f , -101.730f, -10.270f, }; GF_CONSTANT(float) k709YCbCr_To_RGB32f[9] = { 0.00456621f, 0.0f , 0.00703036f, 0.00456621f, -0.00083627f, -0.00208984f, 0.00456621f, 0.00828393f, 0.0f, }; GF_CONSTANT(float) k709YCbCrFullRange_To_RGB32f[9] = { 0.00392157f, 0.0f , 0.00615157f, 0.00392157f, -0.00073174f, -0.00182861f, 0.00392157f, 0.00724844f, 0.0f, }; GF_CONSTANT(float) kRGB8u_To_709YCbCr[9] = { 46.742f / 256.0f, 157.243f / 256.0f, 15.874f / 256.0f, 25.762f / 256.0f, -86.674f / 256.0f, 112.439f / 256.0f, 112.439f / 256.0f, -102.129f / 256.0f, -10.310f / 256.0f, }; GF_CONSTANT(float) k709YCbCr_To_RGB8u[9] = { 298.082f / 256.0f, 0.0f , 458.942f / 256.0f, 298.082f / 256.0f, -54.592f / 256.0f, -136.425f / 256.0f, 298.082f / 256.0f, 540.775f / 256.0f, 0.0f, }; GF_CONSTANT(float) k709YCbCr_To_601YCbCr[9] = { 1.0f, 0.099312f, 0.191700f, 0.0f, 0.989854f, -0.110653f, 0.0f, -0.072453f, 0.983398f, }; GF_CONSTANT(float) k601YCbCr_To_709YCbCr[9] = { 1.0f, -0.115550f, -0.207938f, 0.0f, 1.018640f, 0.114618f, 0.0f, 0.075049f, 1.025327f, }; GF_CONSTANT(float) kYCbCrOffset[3] = { 16.0f, 128.0f, 128.0f, }; GF_CONSTANT(float) kYCbCrFullRangeOffset[3] = { 0.0f, 128.0f, 128.0f, }; GF_DEVICE_FUNCTION float4 SwapComponentOrder( float4 inV) { float4 result = { inV.w, inV.z, inV.y, inV.x }; return result; } GF_DEVICE_FUNCTION float4 ColorSpaceConvert( float4 inPixel, GF_STATIC_CONSTANT_PTR(float) inMatrix) { return make_float4( inPixel.x, inPixel.y * inMatrix[0] + inPixel.z * inMatrix[1] + inPixel.w * inMatrix[2], inPixel.y * inMatrix[3] + inPixel.z * inMatrix[4] + inPixel.w * inMatrix[5], inPixel.y * inMatrix[6] + inPixel.z * inMatrix[7] + inPixel.w * inMatrix[8]); }
#endif
typedef struct { float a, v, u, y; } GF_ALIGN(16) PixelYUV; GF_DEVICE_FUNCTION PixelYUV ConvertRGB_To_YUV( PixelRGB inPixel) { float4 floatPixel = ColorSpaceConvert( SwapComponentOrder( ConvertRGB_To_Components(inPixel)), kRGB32f_To_601YPbPr); PixelYUV result; result.a = floatPixel.x; result.y = floatPixel.y; result.u = floatPixel.z; result.v = floatPixel.w; return result; } GF_DEVICE_FUNCTION PixelRGB ConvertYUV_To_RGB( PixelYUV inPixel) { return ConvertComponents_To_RGB( SwapComponentOrder( ColorSpaceConvert( make_float4( inPixel.a, inPixel.y, inPixel.u, inPixel.v), k601YPbPr_To_RGB32f))); }
#endif
typedef struct { float h, s, l, a; } GF_ALIGN(16) PixelHSL; GF_DEVICE_FUNCTION void ConvertUVToHue( float inPb, float inPr, float* outHue) { const float localPI = 3.1415926535898f; const float localRecip2PI = 1.0f / (2.0f * localPI); float normPb = (inPb * -0.319754879f) + (inPr * 0.947500299f); float normPr = (inPb * -0.947500299f) - (inPr * 0.319754879f); float radPbPrAngleFromXAxis = atan2f(normPr, normPb); if (radPbPrAngleFromXAxis < 0) { *outHue = (2 * localPI) + radPbPrAngleFromXAxis; } else { *outHue = radPbPrAngleFromXAxis; } *outHue *= localRecip2PI; } GF_DEVICE_FUNCTION PixelHSL ConvertYUVToHSL( PixelYUV inYUV) { PixelHSL result; ConvertUVToHue(inYUV.u, inYUV.v, &result.h); result.s = fdividef(sqrtf((inYUV.u * inYUV.u) + (inYUV.v * inYUV.v)), 0.707106781f); result.l = inYUV.y; result.h = saturate(result.h); result.s = saturate(result.s); result.l = saturate(result.l); return result; }
#endif

#ifndef INVERT_H
#define INVERT_H
typedef enum { kInvertChannel_RGB = 0, kInvertChannel_RED, kInvertChannel_GREEN, kInvertChannel_BLUE, kInvertPADDING1, kInvertChannel_HLS, kInvertChannel_HUE, kInvertChannel_LIGHTNESS, kInvertChannel_SATURATION, kInvertPADDING2, kInvertChannel_YIQ, kInvertChannel_LUMINANCE, kInvertChannel_IN_PHASE_CHROMINANCE, kInvertChannel_QUADRATURE_CHROMINANCE, kInvertPADDING3, kInvertChannel_ALPHA, }InvertChannel; typedef struct { InvertChannel mChannel; float mBlend; }InvertParameters;
#endif
GF_DEVICE_FUNCTION PixelHSL ConvertRGBtoHSL( PixelRGB inRGB); GF_DEVICE_FUNCTION PixelRGB ConvertHSLtoRGB( PixelHSL inHSL); GF_DEVICE_FUNCTION float4 ConvertRGBtoYIQ( PixelRGB inPixel); GF_DEVICE_FUNCTION PixelRGB ConvertYIQtoRGB( float4 inPixel); GF_KERNEL InvertKernel( DevicePixelFormat inDeviceFormat, GF_PTR(float4) inOutput, int inWidth, int inHeight, int inOutputPitch, const GF_PTR(float4) inInput, int inInputPitch, InvertChannel inChannel, float inBlend) { int x = KernelX(); int y = KernelY(); if (x >= inWidth || y >= inHeight) { return; } PixelRGB p = ReadRGBPixel(inInput, inInputPitch, inDeviceFormat, x, y); p.r = saturate(p.r); p.g = saturate(p.g); p.b = saturate(p.b); p.a = saturate(p.a); PixelRGB inv; PixelHSL hsl; float4 yiq; switch (inChannel) { case kInvertChannel_ALPHA: p.a = inBlend * p.a + (1.0f - inBlend) * (1.0f - p.a); break; case kInvertChannel_RGB: inv.r = 1.0f - p.r; inv.g = 1.0f - p.g; inv.b = 1.0f - p.b; break; case kInvertChannel_RED: inv.r = 1.0f - p.r; inv.g = p.g; inv.b = p.b; break; case kInvertChannel_GREEN: inv.r = p.r; inv.g = 1.0f - p.g; inv.b = p.b; break; case kInvertChannel_BLUE: inv.r = p.r; inv.g = p.g; inv.b = 1.0f - p.b; break; case kInvertChannel_HLS: case kInvertChannel_HUE: case kInvertChannel_LIGHTNESS: case kInvertChannel_SATURATION: hsl = ConvertRGBtoHSL(p); switch (inChannel) { case kInvertChannel_HLS: hsl.h = 0.5f - hsl.h; if (hsl.h < 0.f) { hsl.h += 1.f; } hsl.l = 1.f - hsl.l; hsl.s = 1.f - hsl.s; break; case kInvertChannel_HUE: hsl.h = 0.5f - hsl.h; if (hsl.h < 0.f) { hsl.h += 1.f; } break; case kInvertChannel_LIGHTNESS: hsl.l = 1.f - hsl.l; break; case kInvertChannel_SATURATION: hsl.s = 1.f - hsl.s; break; } inv = ConvertHSLtoRGB(hsl); break; case kInvertChannel_YIQ: case kInvertChannel_LUMINANCE: case kInvertChannel_IN_PHASE_CHROMINANCE: case kInvertChannel_QUADRATURE_CHROMINANCE: yiq = ConvertRGBtoYIQ(p); switch (inChannel) { case kInvertChannel_YIQ: yiq.y = 1.f - yiq.y; yiq.z *= -1.f; yiq.w *= -1.f; break; case kInvertChannel_LUMINANCE: yiq.y = 1.f - yiq.y; break; case kInvertChannel_IN_PHASE_CHROMINANCE: yiq.z *= -1.f; break; case kInvertChannel_QUADRATURE_CHROMINANCE: yiq.w *= -1.f; break; } inv = ConvertYIQtoRGB(yiq); break; } if (inChannel != kInvertChannel_ALPHA) { p.r = inv.r + inBlend * (p.r - inv.r); p.g = inv.g + inBlend * (p.g - inv.g); p.b = inv.b + inBlend * (p.b - inv.b); } WriteRGBPixel(p, inOutput, inOutputPitch, inDeviceFormat, x, y); } GF_DEVICE_FUNCTION PixelHSL ConvertRGBtoHSL( PixelRGB inRGB) { PixelHSL result; const float kFloatDisplayEpsilon = 0.0001f; float sextant = 0.f; float cMax = inRGB.r; float cMin = inRGB.r; if ((inRGB.r >= inRGB.g) && (inRGB.r >= inRGB.b)) { cMax = inRGB.r; result.h = inRGB.g - inRGB.b; sextant = 0.f; } if ((inRGB.g >= inRGB.r) && (inRGB.g >= inRGB.b)) { cMax = inRGB.g; result.h = inRGB.b - inRGB.r; sextant = 2.f; } if ((inRGB.b >= inRGB.r) && (inRGB.b >= inRGB.g)) { cMax = inRGB.b; result.h = inRGB.r - inRGB.g; sextant = 4.f; } if ((inRGB.r <= inRGB.g) && (inRGB.r <= inRGB.b)) { cMin = inRGB.r; } if ((inRGB.g <= inRGB.r) && (inRGB.g <= inRGB.b)) { cMin = inRGB.g; } if ((inRGB.b <= inRGB.r) && (inRGB.b <= inRGB.g)) { cMin = inRGB.b; } result.l = (cMax + cMin) / 2; result.s = 0.f; if (result.l > kFloatDisplayEpsilon) { result.s = cMax - cMin; if (result.s > kFloatDisplayEpsilon) { result.h /= result.s; result.h += sextant; if (result.h < 0) { result.h += 6.f; } result.h /= 6.f; } else { result.s = 0.f; result.h = 0.f; } } else { result.h = 0.f; } return result; } GF_DEVICE_FUNCTION PixelRGB ConvertHSLtoRGB( PixelHSL inHSL) { PixelRGB result = { 0.0f, 0.0f, 0.0f, 0.0f }; float v = (inHSL.l <= 0.5f) ? (inHSL.l * (1.0f + inHSL.s)) : (inHSL.l + inHSL.s - inHSL.l * inHSL.s); if (v > 0) { float m; float sv; int sextant; float fract, vsf, mid1, mid2; m = inHSL.l + inHSL.l - v; sv = (v - m ) / v; inHSL.h *= 6.0f; sextant = (int)(inHSL.h); fract = inHSL.h - sextant; vsf = v * sv * fract; mid1 = m + vsf; mid2 = v - vsf; switch (sextant) { case 0: result.r = v; result.g = mid1; result.b = m; break; case 1: result.r = mid2; result.g = v; result.b = m; break; case 2: result.r = m; result.g = v; result.b = mid1; break; case 3: result.r = m; result.g = mid2; result.b = v; break; case 4: result.r = mid1; result.g = m; result.b = v; break; case 5: result.r = v; result.g = m; result.b = mid2; break; } } return result; } GF_CONSTANT(float) kRGB32f_To_YIQ[9] = { 0.299f , 0.587f , 0.114f, 0.595716f, -0.274453f, -0.321263f, 0.211456f, -0.522591f, 0.311135f, }; GF_CONSTANT(float) kYIQ_To_RGB32f[9] = { 1.f , 0.9563f , 0.6210f, 1.f , -0.2721f , -0.6474f, 1.f , -1.1070f , 1.7046f, }; GF_DEVICE_FUNCTION float4 ConvertRGBtoYIQ( PixelRGB inPixel) { return ColorSpaceConvert( SwapComponentOrder( ConvertRGB_To_Components(inPixel)), kRGB32f_To_YIQ); } GF_DEVICE_FUNCTION PixelRGB ConvertYIQtoRGB( float4 inPixel) { return ConvertComponents_To_RGB( SwapComponentOrder( ColorSpaceConvert(inPixel, kYIQ_To_RGB32f))); }

// buildOptions= -cl-single-precision-constant -cl-fast-relaxed-math
// RUN: %occ-cli %s --cl-options="-I%cwd -I%S  -cl-single-precision-constant -cl-fast-relaxed-math" %cfg_path --cl-device=%cl_device 2>&1
