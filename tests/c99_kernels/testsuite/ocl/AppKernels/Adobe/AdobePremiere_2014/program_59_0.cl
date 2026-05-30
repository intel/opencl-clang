
#ifndef IRGPGPUSHADERS_H
#define IRGPGPUSHADERS_H

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

#define GF_TEXTURE_1D(N, S) __read_only image2d_t N, sampler_t S

#define GF_TEXTURE_2D(N, S) __read_only image2d_t N, sampler_t S

#define GF_TEXTURE_3D(N, S) __read_only image3d_t N, sampler_t S

#define GF_CUDA_TEXTURE(C, N)

#define GF_CUDA_TEXTURE_1D(C, N)

#define GF_CUDA_TEXTURE_3D(C, N)

#define GF_OPENCL_TEXTURE_1D(N) __read_only image2d_t N

#define GF_OPENCL_TEXTURE_3D(N) __read_only image3d_t N

#define GF_READTEXTURERECT(I, X, Y, S) read_imagef(I, S, (float2)(X, Y))

#define GF_READTEXTURE1D(I, X, S) read_imagef(I, S, (float2)(X, 0.5f))

#define GF_READTEXTURE2D(I, X, Y, S) read_imagef(I, S, (float2)(X, Y))

#define GF_READTEXTURE3D(I, X, Y, Z, S) read_imagef(I, S, (float4)(X, Y, Z, 1.0f))

#define floorf floor

#define TEMP float4

#define PARAMC float4

#define PARAM(p, v) float4 p = v;

#define program_local inParameters

#define c4 make_float4

#define c3(p0, p1, p2) make_float4(p0, p1, p2, 0)

#define c1(p0) make_float4(p0, p0, p0, p0)

#define co_xyxy(p0, p1, p2, p3) make_float4(p0, -p1, p2, -p3)

#define co_xyyy(p0, p1, p2, p3) make_float4(p0, -p1, -p2, -p3)

#define co_xxxy(p0, p1, p2, p3) make_float4(p0, p1, p2, -p3)

#define co_yyyx(p0, p1, p2, p3) make_float4(-p0, -p1, -p2, p3)

#define neg(v) make_float4(-v.x, -v.y, -v.z, -v.w)

#define vflip(v) -v

#define s(v, p) p(v)

#define Arriscan 1

#define LogCV2 2

#define LogCV3 3

#define SLogA 4

#define Cineon 5

#define REDlog 6

#define Panalog 7

#define JPEGGamma 8

#define COMMON_PARAMS __global float4* outDest, int inDestPitch, DevicePixelFormat inDeviceFormat, int inWidth, int inHeight, __global float4* inParameters, __read_only image2d_t texture0_RECT


#define BEGIN_NORMAL int x = KernelX(); \
 int y = KernelY(); \
 if (x < inWidth && y < inHeight) \
 { \
 float4 fragment_texcoord0; \
 float4 result_color; \
 fragment_texcoord0 = MakeCoords(x, y);\
 sampler_t texSamplerRECT = CLK_NORMALIZED_COORDS_FALSE|CLK_ADDRESS_CLAMP_TO_EDGE|CLK_FILTER_NEAREST;\
 sampler_t texSampler1D = CLK_NORMALIZED_COORDS_TRUE|CLK_ADDRESS_CLAMP_TO_EDGE|CLK_FILTER_LINEAR;\
 sampler_t texSampler2D = CLK_NORMALIZED_COORDS_TRUE|CLK_ADDRESS_CLAMP_TO_EDGE|CLK_FILTER_LINEAR;\
 sampler_t texSampler3D = CLK_NORMALIZED_COORDS_TRUE|CLK_ADDRESS_CLAMP_TO_EDGE|CLK_FILTER_LINEAR;


#define BEGIN_MULTITEXTURE int x = KernelX(); \
 int y = KernelY(); \
 if (x < inWidth && y < inHeight) \
 { \
 float4 fragment_texcoord0; \
 float4 fragment_texcoord1; \
 float4 result_color; \
 fragment_texcoord0 = MakeCoords(x, y); \
 fragment_texcoord1 = fragment_texcoord0;\
 sampler_t texSamplerRECT = CLK_NORMALIZED_COORDS_FALSE|CLK_ADDRESS_CLAMP_TO_EDGE|CLK_FILTER_NEAREST;\
 sampler_t texSampler1D = CLK_NORMALIZED_COORDS_TRUE|CLK_ADDRESS_CLAMP_TO_EDGE|CLK_FILTER_LINEAR;\
 sampler_t texSampler2D = CLK_NORMALIZED_COORDS_TRUE|CLK_ADDRESS_CLAMP_TO_EDGE|CLK_FILTER_LINEAR;\
 sampler_t texSampler3D = CLK_NORMALIZED_COORDS_TRUE|CLK_ADDRESS_CLAMP_TO_EDGE|CLK_FILTER_LINEAR;


#define LOAD_PARAMS(C)


#define END WriteVector(result_color, outDest, inDestPitch, inDeviceFormat, x, y);}
GF_DEVICE_FUNCTION float4 MakeCoords(float inX, float inY) { float4 Coords; Coords.x = 0.5f + inX; Coords.y = 0.5f + inY; Coords.z = 0; Coords.w = 0; return Coords; } GF_DEVICE_FUNCTION void WriteVector( float4 inVector, GF_PTR(float4) outImage, int inPitch, DevicePixelFormat inDeviceFormat, int inX, int inY) { WritePixel(make_float4(inVector.z, inVector.y, inVector.x, inVector.w), outImage, inPitch, inDeviceFormat, inX, inY); }
 GF_DEVICE_FUNCTION float nanf(uint inX) { return nan(inX); } GF_DEVICE_FUNCTION float fast_powf(float inX, float inP) { return native_powr(inX, inP); } GF_DEVICE_FUNCTION float fast_log2f(float inX) { return native_log2(inX); } GF_DEVICE_FUNCTION float recipf(float inX) { return native_recip(inX); }GF_DEVICE_FUNCTION float4 xxxy(float4 inSrc) { return c4(inSrc.x, inSrc.x, inSrc.x, inSrc.y); } GF_DEVICE_FUNCTION float4 xyxy(float4 inSrc) { return c4(inSrc.x, inSrc.y, inSrc.x, inSrc.y); } GF_DEVICE_FUNCTION float4 xyyy(float4 inSrc) { return c4(inSrc.x, inSrc.y, inSrc.y, inSrc.y); } GF_DEVICE_FUNCTION float4 xzxz(float4 inSrc) { return c4(inSrc.x, inSrc.z, inSrc.x, inSrc.z); } GF_DEVICE_FUNCTION float4 xwww(float4 inSrc) { return c4(inSrc.x, inSrc.w, inSrc.w, inSrc.w); } GF_DEVICE_FUNCTION float4 xwxw(float4 inSrc) { return c4(inSrc.x, inSrc.w, inSrc.x, inSrc.w); } GF_DEVICE_FUNCTION float4 yyzz(float4 inSrc) { return c4(inSrc.y, inSrc.y, inSrc.z, inSrc.z); } GF_DEVICE_FUNCTION float4 yzxx(float4 inSrc) { return c4(inSrc.y, inSrc.z, inSrc.x, inSrc.x); } GF_DEVICE_FUNCTION float4 yyyx(float4 inSrc) { return c4(inSrc.y, inSrc.y, inSrc.y, inSrc.x); } GF_DEVICE_FUNCTION float4 yzyz(float4 inSrc) { return c4(inSrc.y, inSrc.z, inSrc.y, inSrc.z); } GF_DEVICE_FUNCTION float4 yzww(float4 inSrc) { return c4(inSrc.y, inSrc.z, inSrc.w, inSrc.w); } GF_DEVICE_FUNCTION float4 ywww(float4 inSrc) { return c4(inSrc.y, inSrc.w, inSrc.w, inSrc.w); } GF_DEVICE_FUNCTION float4 ywyw(float4 inSrc) { return c4(inSrc.y, inSrc.w, inSrc.y, inSrc.w); } GF_DEVICE_FUNCTION float4 zxyx(float4 inSrc) { return c4(inSrc.z, inSrc.x, inSrc.y, inSrc.x); } GF_DEVICE_FUNCTION float4 zyzy(float4 inSrc) { return c4(inSrc.z, inSrc.y, inSrc.z, inSrc.y); } GF_DEVICE_FUNCTION float4 zwzw(float4 inSrc) { return c4(inSrc.z, inSrc.w, inSrc.z, inSrc.w); } GF_DEVICE_FUNCTION float4 wxwx(float4 inSrc) { return c4(inSrc.w, inSrc.x, inSrc.w, inSrc.x); } GF_DEVICE_FUNCTION float4 wxww(float4 inSrc) { return c4(inSrc.w, inSrc.x, inSrc.w, inSrc.w); } GF_DEVICE_FUNCTION float4 wywy(float4 inSrc) { return c4(inSrc.w, inSrc.y, inSrc.w, inSrc.y); } GF_DEVICE_FUNCTION float4 wyww(float4 inSrc) { return c4(inSrc.w, inSrc.y, inSrc.w, inSrc.w); } GF_DEVICE_FUNCTION float4 wzwz(float4 inSrc) { return c4(inSrc.w, inSrc.z, inSrc.w, inSrc.z); } GF_DEVICE_FUNCTION float4 wwzz(float4 inSrc) { return c4(inSrc.w, inSrc.w, inSrc.z, inSrc.z); }GF_DEVICE_FUNCTION void TEX_(float4 *outDest, float4 inCoords, GF_TEXTURE_2D(inTexture, texSamplerRECT)) { float4 tex = GF_READTEXTURERECT(inTexture, inCoords.x, inCoords.y, texSamplerRECT); (*outDest).x = tex.z; (*outDest).y = tex.y; (*outDest).z = tex.x; (*outDest).w = tex.w; } GF_DEVICE_FUNCTION float TEXs_x_(float4 inCoords, GF_TEXTURE_2D(inTexture, texSamplerRECT)) { float4 tex = GF_READTEXTURERECT(inTexture, inCoords.x, inCoords.y, texSamplerRECT); return tex.z; } GF_DEVICE_FUNCTION float TEXs_y_(float4 inCoords, GF_TEXTURE_2D(inTexture, texSamplerRECT)) { float4 tex = GF_READTEXTURERECT(inTexture, inCoords.x, inCoords.y, texSamplerRECT); return tex.y; } GF_DEVICE_FUNCTION float TEXs_z_(float4 inCoords, GF_TEXTURE_2D(inTexture, texSamplerRECT)) { float4 tex = GF_READTEXTURERECT(inTexture, inCoords.x, inCoords.y, texSamplerRECT); return tex.x; } GF_DEVICE_FUNCTION float TEXs_w_(float4 inCoords, GF_TEXTURE_2D(inTexture, texSamplerRECT)) { float4 tex = GF_READTEXTURERECT(inTexture, inCoords.x, inCoords.y, texSamplerRECT); return tex.w; } GF_DEVICE_FUNCTION void TEX_1d_(float4 *outDest, float4 inCoords, GF_TEXTURE_1D(inTexture, texSampler1D)) { *outDest = GF_READTEXTURE1D(inTexture, inCoords.x, texSampler1D); } GF_DEVICE_FUNCTION float TEXs_1d_x_(float inCoords, GF_TEXTURE_1D(inTexture, texSampler1D)) { float4 tex = GF_READTEXTURE1D(inTexture, inCoords, texSampler1D); return tex.x; } GF_DEVICE_FUNCTION float TEXs_1d_y_(float inCoords, GF_TEXTURE_1D(inTexture, texSampler1D)) { float4 tex = GF_READTEXTURE1D(inTexture, inCoords, texSampler1D); return tex.y; } GF_DEVICE_FUNCTION float TEXs_1d_z_(float inCoords, GF_TEXTURE_1D(inTexture, texSampler1D)) { float4 tex = GF_READTEXTURE1D(inTexture, inCoords, texSampler1D); return tex.z; } GF_DEVICE_FUNCTION void TEX_2d_(float4 *outDest, float4 inCoords, GF_TEXTURE_2D(inTexture, texSampler2D)) { *outDest = GF_READTEXTURE2D(inTexture, inCoords.x, inCoords.y, texSampler2D); } GF_DEVICE_FUNCTION void TEX_3d_(float4 *outDest, float4 inCoords, GF_TEXTURE_3D(inTexture, texSampler3D)) { *outDest = GF_READTEXTURE3D(inTexture, inCoords.x, inCoords.y, inCoords.z, texSampler3D); } GF_DEVICE_FUNCTION void TEX_3d_xyz_(float4 *outDest, float4 inCoords, GF_TEXTURE_3D(inTexture, texSampler3D)) { float4 tex = GF_READTEXTURE3D(inTexture, inCoords.x, inCoords.y, inCoords.z, texSampler3D); (*outDest).x = tex.x; (*outDest).y = tex.y; (*outDest).z = tex.z; }GF_DEVICE_FUNCTION void ADD(float4 *outDest, float4 inSrc0, float4 inSrc1) { (*outDest).x = inSrc0.x + inSrc1.x; (*outDest).y = inSrc0.y + inSrc1.y; (*outDest).z = inSrc0.z + inSrc1.z; (*outDest).w = inSrc0.w + inSrc1.w; } GF_DEVICE_FUNCTION void ADDvvs(float4 *outDest, float4 inSrc0, float inSrc1) { (*outDest).x = inSrc0.x + inSrc1; (*outDest).y = inSrc0.y + inSrc1; (*outDest).z = inSrc0.z + inSrc1; (*outDest).w = inSrc0.w + inSrc1; } GF_DEVICE_FUNCTION float ADDs_(float inSrc0, float inSrc1) { return (inSrc0 + inSrc1); } GF_DEVICE_FUNCTION void ADD_xyz(float4 *outDest, float4 inSrc0, float4 inSrc1) { (*outDest).x = inSrc0.x + inSrc1.x; (*outDest).y = inSrc0.y + inSrc1.y; (*outDest).z = inSrc0.z + inSrc1.z; } GF_DEVICE_FUNCTION void ADDvvs_xyz(float4 *outDest, float4 inSrc0, float inSrc1) { (*outDest).x = inSrc0.x + inSrc1; (*outDest).y = inSrc0.y + inSrc1; (*outDest).z = inSrc0.z + inSrc1; } GF_DEVICE_FUNCTION void ADD_SAT(float4 *outDest, float4 inSrc0, float4 inSrc1) { (*outDest).x = saturate(inSrc0.x + inSrc1.x); (*outDest).y = saturate(inSrc0.y + inSrc1.y); (*outDest).z = saturate(inSrc0.z + inSrc1.z); (*outDest).w = saturate(inSrc0.w + inSrc1.w); } GF_DEVICE_FUNCTION void SUB(float4 *outDest, float4 inSrc0, float4 inSrc1) { (*outDest).x = inSrc0.x - inSrc1.x; (*outDest).y = inSrc0.y - inSrc1.y; (*outDest).z = inSrc0.z - inSrc1.z; (*outDest).w = inSrc0.w - inSrc1.w; } GF_DEVICE_FUNCTION void SUBvvs(float4 *outDest, float4 inSrc0, float inSrc1) { (*outDest).x = inSrc0.x - inSrc1; (*outDest).y = inSrc0.y - inSrc1; (*outDest).z = inSrc0.z - inSrc1; (*outDest).w = inSrc0.w - inSrc1; } GF_DEVICE_FUNCTION void SUBvsv(float4 *outDest, float inSrc0, float4 inSrc1) { (*outDest).x = inSrc0 - inSrc1.x; (*outDest).y = inSrc0 - inSrc1.y; (*outDest).z = inSrc0 - inSrc1.z; (*outDest).w = inSrc0 - inSrc1.w; } GF_DEVICE_FUNCTION float SUBs_(float inSrc0, float inSrc1) { return (inSrc0 - inSrc1); } GF_DEVICE_FUNCTION void SUBvss_xyz(float4 *outDest, float inSrc0, float inSrc1) { float sub = inSrc0 - inSrc1; (*outDest).x = sub; (*outDest).y = sub; (*outDest).z = sub; } GF_DEVICE_FUNCTION void SUB_SAT(float4 *outDest, float4 inSrc0, float4 inSrc1) { (*outDest).x = saturate(inSrc0.x - inSrc1.x); (*outDest).y = saturate(inSrc0.y - inSrc1.y); (*outDest).z = saturate(inSrc0.z - inSrc1.z); (*outDest).w = saturate(inSrc0.w - inSrc1.w); } GF_DEVICE_FUNCTION void MUL(float4 *outDest, float4 inSrc0, float4 inSrc1) { (*outDest).x = inSrc0.x * inSrc1.x; (*outDest).y = inSrc0.y * inSrc1.y; (*outDest).z = inSrc0.z * inSrc1.z; (*outDest).w = inSrc0.w * inSrc1.w; } GF_DEVICE_FUNCTION void MULvvs(float4 *outDest, float4 inSrc0, float inSrc1) { (*outDest).x = inSrc0.x * inSrc1; (*outDest).y = inSrc0.y * inSrc1; (*outDest).z = inSrc0.z * inSrc1; (*outDest).w = inSrc0.w * inSrc1; } GF_DEVICE_FUNCTION void MULvsv(float4 *outDest, float inSrc0, float4 inSrc1) { (*outDest).x = inSrc0 * inSrc1.x; (*outDest).y = inSrc0 * inSrc1.y; (*outDest).z = inSrc0 * inSrc1.z; (*outDest).w = inSrc0 * inSrc1.w; } GF_DEVICE_FUNCTION void MULvss(float4 *outDest, float inSrc0, float inSrc1) { float mul = inSrc0 * inSrc1; (*outDest).x = mul; (*outDest).y = mul; (*outDest).z = mul; (*outDest).w = mul; } GF_DEVICE_FUNCTION float MULs_(float inSrc0, float inSrc1) { return (inSrc0 * inSrc1); } GF_DEVICE_FUNCTION void MULvsv_xyz(float4 *outDest, float inSrc0, float4 inSrc1) { (*outDest).x = inSrc0 * inSrc1.x; (*outDest).y = inSrc0 * inSrc1.y; (*outDest).z = inSrc0 * inSrc1.z; } GF_DEVICE_FUNCTION void MULvss_xyz(float4 *outDest, float inSrc0, float inSrc1) { float mul = inSrc0 * inSrc1; (*outDest).x = mul; (*outDest).y = mul; (*outDest).z = mul; } GF_DEVICE_FUNCTION void MULvvs_xz(float4 *outDest, float4 inSrc0, float inSrc1) { (*outDest).x = inSrc0.x * inSrc1; (*outDest).z = inSrc0.z * inSrc1; } GF_DEVICE_FUNCTION void MUL_xy(float4 *outDest, float4 inSrc0, float4 inSrc1) { (*outDest).x = inSrc0.x * inSrc1.x; (*outDest).y = inSrc0.y * inSrc1.y; } GF_DEVICE_FUNCTION void MULvsv_yz(float4 *outDest, float inSrc0, float4 inSrc1) { (*outDest).y = inSrc0 * inSrc1.y; (*outDest).z = inSrc0 * inSrc1.z; } GF_DEVICE_FUNCTION void MUL_xyz(float4 *outDest, float4 inSrc0, float4 inSrc1) { (*outDest).x = inSrc0.x * inSrc1.x; (*outDest).y = inSrc0.y * inSrc1.y; (*outDest).z = inSrc0.z * inSrc1.z; } GF_DEVICE_FUNCTION void MUL_SAT(float4 *outDest, float4 inSrc0, float4 inSrc1) { (*outDest).x = saturate(inSrc0.x * inSrc1.x); (*outDest).y = saturate(inSrc0.y * inSrc1.y); (*outDest).z = saturate(inSrc0.z * inSrc1.z); (*outDest).w = saturate(inSrc0.w * inSrc1.w); } GF_DEVICE_FUNCTION float MULs_SAT_(float inSrc0, float inSrc1) { return saturate(inSrc0 * inSrc1); }GF_DEVICE_FUNCTION void MAX(float4 *outDest, float4 inSrc0, float4 inSrc1) { (*outDest).x = (inSrc0.x > inSrc1.x) ? inSrc0.x : inSrc1.x; (*outDest).y = (inSrc0.y > inSrc1.y) ? inSrc0.y : inSrc1.y; (*outDest).z = (inSrc0.z > inSrc1.z) ? inSrc0.z : inSrc1.z; (*outDest).w = (inSrc0.w > inSrc1.w) ? inSrc0.w : inSrc1.w; } GF_DEVICE_FUNCTION void MAXvvs(float4 *outDest, float4 inSrc0, float inSrc1) { (*outDest).x = (inSrc0.x > inSrc1) ? inSrc0.x : inSrc1; (*outDest).y = (inSrc0.y > inSrc1) ? inSrc0.y : inSrc1; (*outDest).z = (inSrc0.z > inSrc1) ? inSrc0.z : inSrc1; (*outDest).w = (inSrc0.w > inSrc1) ? inSrc0.w : inSrc1; } GF_DEVICE_FUNCTION void MAXvsv(float4 *outDest, float inSrc0, float4 inSrc1) { (*outDest).x = (inSrc0 > inSrc1.x) ? inSrc0 : inSrc1.x; (*outDest).y = (inSrc0 > inSrc1.y) ? inSrc0 : inSrc1.y; (*outDest).z = (inSrc0 > inSrc1.z) ? inSrc0 : inSrc1.z; (*outDest).w = (inSrc0 > inSrc1.w) ? inSrc0 : inSrc1.w; } GF_DEVICE_FUNCTION float MAXs_(float inSrc0, float inSrc1) { return ((inSrc0 > inSrc1) ? inSrc0 : inSrc1); } GF_DEVICE_FUNCTION void MAXvvs_xyz(float4 *outDest, float4 inSrc0, float inSrc1) { (*outDest).x = (inSrc0.x > inSrc1) ? inSrc0.x : inSrc1; (*outDest).y = (inSrc0.y > inSrc1) ? inSrc0.y : inSrc1; (*outDest).z = (inSrc0.z > inSrc1) ? inSrc0.z : inSrc1; } GF_DEVICE_FUNCTION float MAXs_SAT_(float inSrc0, float inSrc1) { return saturate((inSrc0 > inSrc1) ? inSrc0 : inSrc1); } GF_DEVICE_FUNCTION void MIN(float4 *outDest, float4 inSrc0, float4 inSrc1) { (*outDest).x = (inSrc0.x > inSrc1.x) ? inSrc1.x : inSrc0.x; (*outDest).y = (inSrc0.y > inSrc1.y) ? inSrc1.y : inSrc0.y; (*outDest).z = (inSrc0.z > inSrc1.z) ? inSrc1.z : inSrc0.z; (*outDest).w = (inSrc0.w > inSrc1.w) ? inSrc1.w : inSrc0.w; } GF_DEVICE_FUNCTION float MINs_(float inSrc0, float inSrc1) { return ((inSrc0 > inSrc1) ? inSrc1 : inSrc0); } GF_DEVICE_FUNCTION void MINvvs_SAT(float4 *outDest, float4 inSrc0, float inSrc1) { (*outDest).x = saturate((inSrc0.x > inSrc1) ? inSrc1 : inSrc0.x); (*outDest).y = saturate((inSrc0.y > inSrc1) ? inSrc1 : inSrc0.y); (*outDest).z = saturate((inSrc0.z > inSrc1) ? inSrc1 : inSrc0.z); (*outDest).w = saturate((inSrc0.w > inSrc1) ? inSrc1 : inSrc0.w); } GF_DEVICE_FUNCTION float MINs_SAT_(float inSrc0, float inSrc1) { return saturate((inSrc0 > inSrc1) ? inSrc1 : inSrc0); } GF_DEVICE_FUNCTION void SLT(float4 *outDest, float4 inSrc0, float4 inSrc1) { (*outDest).x = (inSrc0.x < inSrc1.x) ? 1.0f : 0.0f; (*outDest).y = (inSrc0.y < inSrc1.y) ? 1.0f : 0.0f; (*outDest).z = (inSrc0.z < inSrc1.z) ? 1.0f : 0.0f; (*outDest).w = (inSrc0.w < inSrc1.w) ? 1.0f : 0.0f; } GF_DEVICE_FUNCTION float SLTs_(float inSrc0, float inSrc1) { return ((inSrc0 < inSrc1) ? 1.0f : 0.0f); } GF_DEVICE_FUNCTION void SGE(float4 *outDest, float4 inSrc0, float4 inSrc1) { (*outDest).x = (inSrc0.x >= inSrc1.x) ? 1.0f : 0.0f; (*outDest).y = (inSrc0.y >= inSrc1.y) ? 1.0f : 0.0f; (*outDest).z = (inSrc0.z >= inSrc1.z) ? 1.0f : 0.0f; (*outDest).w = (inSrc0.w >= inSrc1.w) ? 1.0f : 0.0f; }GF_DEVICE_FUNCTION void MAD(float4 *outDest, float4 inSrc0, float4 inSrc1, float4 inSrc2) { (*outDest).x = inSrc0.x * inSrc1.x + inSrc2.x; (*outDest).y = inSrc0.y * inSrc1.y + inSrc2.y; (*outDest).z = inSrc0.z * inSrc1.z + inSrc2.z; (*outDest).w = inSrc0.w * inSrc1.w + inSrc2.w; } GF_DEVICE_FUNCTION void MADvvvs(float4 *outDest, float4 inSrc0, float4 inSrc1, float inSrc2) { (*outDest).x = inSrc0.x * inSrc1.x + inSrc2; (*outDest).y = inSrc0.y * inSrc1.y + inSrc2; (*outDest).z = inSrc0.z * inSrc1.z + inSrc2; (*outDest).w = inSrc0.w * inSrc1.w + inSrc2; } GF_DEVICE_FUNCTION void MADvvsv(float4 *outDest, float4 inSrc0, float inSrc1, float4 inSrc2) { (*outDest).x = inSrc0.x * inSrc1 + inSrc2.x; (*outDest).y = inSrc0.y * inSrc1 + inSrc2.y; (*outDest).z = inSrc0.z * inSrc1 + inSrc2.z; (*outDest).w = inSrc0.w * inSrc1 + inSrc2.w; } GF_DEVICE_FUNCTION void MADvvss(float4 *outDest, float4 inSrc0, float inSrc1, float inSrc2) { (*outDest).x = inSrc0.x * inSrc1 + inSrc2; (*outDest).y = inSrc0.y * inSrc1 + inSrc2; (*outDest).z = inSrc0.z * inSrc1 + inSrc2; (*outDest).w = inSrc0.w * inSrc1 + inSrc2; } GF_DEVICE_FUNCTION void MADvsvv(float4 *outDest, float inSrc0, float4 inSrc1, float4 inSrc2) { (*outDest).x = inSrc0 * inSrc1.x + inSrc2.x; (*outDest).y = inSrc0 * inSrc1.y + inSrc2.y; (*outDest).z = inSrc0 * inSrc1.z + inSrc2.z; (*outDest).w = inSrc0 * inSrc1.w + inSrc2.w; } GF_DEVICE_FUNCTION void MADvsvs(float4 *outDest, float inSrc0, float4 inSrc1, float inSrc2) { (*outDest).x = inSrc0 * inSrc1.x + inSrc2; (*outDest).y = inSrc0 * inSrc1.y + inSrc2; (*outDest).z = inSrc0 * inSrc1.z + inSrc2; (*outDest).w = inSrc0 * inSrc1.w + inSrc2; } GF_DEVICE_FUNCTION float MADs_(float inSrc0, float inSrc1, float inSrc2) { return (inSrc0 * inSrc1 + inSrc2); } GF_DEVICE_FUNCTION void MAD_xyz(float4 *outDest, float4 inSrc0, float4 inSrc1, float4 inSrc2) { (*outDest).x = inSrc0.x * inSrc1.x + inSrc2.x; (*outDest).y = inSrc0.y * inSrc1.y + inSrc2.y; (*outDest).z = inSrc0.z * inSrc1.z + inSrc2.z; } GF_DEVICE_FUNCTION void MADvsvv_xyz(float4 *outDest, float inSrc0, float4 inSrc1, float4 inSrc2) { (*outDest).x = inSrc0 * inSrc1.x + inSrc2.x; (*outDest).y = inSrc0 * inSrc1.y + inSrc2.y; (*outDest).z = inSrc0 * inSrc1.z + inSrc2.z; } GF_DEVICE_FUNCTION void MADvsvs_yz(float4 *outDest, float inSrc0, float4 inSrc1, float inSrc2) { (*outDest).y = inSrc0 * inSrc1.y + inSrc2; (*outDest).z = inSrc0 * inSrc1.z + inSrc2; } GF_DEVICE_FUNCTION void MADvsvs_zw(float4 *outDest, float inSrc0, float4 inSrc1, float inSrc2) { (*outDest).z = inSrc0 * inSrc1.z + inSrc2; (*outDest).w = inSrc0 * inSrc1.w + inSrc2; } GF_DEVICE_FUNCTION void MAD_SAT(float4 *outDest, float4 inSrc0, float4 inSrc1, float4 inSrc2) { (*outDest).x = saturate(inSrc0.x * inSrc1.x + inSrc2.x); (*outDest).y = saturate(inSrc0.y * inSrc1.y + inSrc2.y); (*outDest).z = saturate(inSrc0.z * inSrc1.z + inSrc2.z); (*outDest).w = saturate(inSrc0.w * inSrc1.w + inSrc2.w); } GF_DEVICE_FUNCTION void MADvsvv_SAT(float4 *outDest, float inSrc0, float4 inSrc1, float4 inSrc2) { (*outDest).x = saturate(inSrc0 * inSrc1.x + inSrc2.x); (*outDest).y = saturate(inSrc0 * inSrc1.y + inSrc2.y); (*outDest).z = saturate(inSrc0 * inSrc1.z + inSrc2.z); (*outDest).w = saturate(inSrc0 * inSrc1.w + inSrc2.w); }GF_DEVICE_FUNCTION void CMP(float4 *outDest, float4 inSrc0, float4 inSrc1, float4 inSrc2) { (*outDest).x = (inSrc0.x < 0.0f) ? inSrc1.x : inSrc2.x; (*outDest).y = (inSrc0.y < 0.0f) ? inSrc1.y : inSrc2.y; (*outDest).z = (inSrc0.z < 0.0f) ? inSrc1.z : inSrc2.z; (*outDest).w = (inSrc0.w < 0.0f) ? inSrc1.w : inSrc2.w; } GF_DEVICE_FUNCTION void CMPvvvs(float4 *outDest, float4 inSrc0, float4 inSrc1, float inSrc2) { (*outDest).x = (inSrc0.x < 0.0f) ? inSrc1.x : inSrc2; (*outDest).y = (inSrc0.y < 0.0f) ? inSrc1.y : inSrc2; (*outDest).z = (inSrc0.z < 0.0f) ? inSrc1.z : inSrc2; (*outDest).w = (inSrc0.w < 0.0f) ? inSrc1.w : inSrc2; } GF_DEVICE_FUNCTION void CMPvsvv(float4 *outDest, float inSrc0, float4 inSrc1, float4 inSrc2) { if (inSrc0 < 0.0f) { (*outDest).x = inSrc1.x; (*outDest).y = inSrc1.y; (*outDest).z = inSrc1.z; (*outDest).w = inSrc1.w; } else { (*outDest).x = inSrc2.x; (*outDest).y = inSrc2.y; (*outDest).z = inSrc2.z; (*outDest).w = inSrc2.w; } } GF_DEVICE_FUNCTION float CMPs_(float inSrc0, float inSrc1, float inSrc2) { return ((inSrc0 < 0.0f) ? inSrc1 : inSrc2); } GF_DEVICE_FUNCTION void LRP(float4 *outDest, float4 inSrc0, float4 inSrc1, float4 inSrc2) { (*outDest).x = inSrc0.x * inSrc1.x + (1.0f - inSrc0.x) * inSrc2.x; (*outDest).y = inSrc0.y * inSrc1.y + (1.0f - inSrc0.y) * inSrc2.y; (*outDest).z = inSrc0.z * inSrc1.z + (1.0f - inSrc0.z) * inSrc2.z; (*outDest).w = inSrc0.w * inSrc1.w + (1.0f - inSrc0.w) * inSrc2.w; } GF_DEVICE_FUNCTION void LRPvvss(float4 *outDest, float4 inSrc0, float inSrc1, float inSrc2) { (*outDest).x = inSrc0.x * inSrc1 + (1.0f - inSrc0.x) * inSrc2; (*outDest).y = inSrc0.y * inSrc1 + (1.0f - inSrc0.y) * inSrc2; (*outDest).z = inSrc0.z * inSrc1 + (1.0f - inSrc0.z) * inSrc2; (*outDest).w = inSrc0.w * inSrc1 + (1.0f - inSrc0.w) * inSrc2; } GF_DEVICE_FUNCTION void LRPvsvv(float4 *outDest, float inSrc0, float4 inSrc1, float4 inSrc2) { (*outDest).x = inSrc0 * inSrc1.x + (1.0f - inSrc0) * inSrc2.x; (*outDest).y = inSrc0 * inSrc1.y + (1.0f - inSrc0) * inSrc2.y; (*outDest).z = inSrc0 * inSrc1.z + (1.0f - inSrc0) * inSrc2.z; (*outDest).w = inSrc0 * inSrc1.w + (1.0f - inSrc0) * inSrc2.w; } GF_DEVICE_FUNCTION void LRPvsss(float4 *outDest, float inSrc0, float inSrc1, float inSrc2) { float lerp = inSrc0 * inSrc1 + (1.0f - inSrc0) * inSrc2; (*outDest).x = lerp; (*outDest).y = lerp; (*outDest).z = lerp; (*outDest).w = lerp; } GF_DEVICE_FUNCTION float LRPsvss_(float4 inSrc0, float inSrc1, float inSrc2) { return (inSrc0.x * inSrc1 + (1.0f - inSrc0.x) * inSrc2); } GF_DEVICE_FUNCTION void LRPvsvv_xyz(float4 *outDest, float inSrc0, float4 inSrc1, float4 inSrc2) { (*outDest).x = inSrc0 * inSrc1.x + (1.0f - inSrc0) * inSrc2.x; (*outDest).y = inSrc0 * inSrc1.y + (1.0f - inSrc0) * inSrc2.y; (*outDest).z = inSrc0 * inSrc1.z + (1.0f - inSrc0) * inSrc2.z; }GF_DEVICE_FUNCTION void ABS(float4 *outDest, float4 inSrc0) { (*outDest).x = fabsf(inSrc0.x); (*outDest).y = fabsf(inSrc0.y); (*outDest).z = fabsf(inSrc0.z); (*outDest).w = fabsf(inSrc0.w); } GF_DEVICE_FUNCTION float ABSs_(float inSrc0) { return fabsf(inSrc0); } GF_DEVICE_FUNCTION void POWvss(float4 *outDest, float inSrc0, float inSrc1) { float pwr; if ((inSrc0 == 0.0f) && (inSrc1 == 0.0f)) pwr = nanf(0); else pwr = inSrc1 < 0.0f ? 1.0f : fast_powf(inSrc0, inSrc1); (*outDest).x = pwr; (*outDest).y = pwr; (*outDest).z = pwr; (*outDest).w = pwr; } GF_DEVICE_FUNCTION float POWs_(float inSrc0, float inSrc1) { if ((inSrc0 == 0.0f) && (inSrc1 == 0.0f)) return nanf(0); else return (inSrc1 < 0.0f ? 1.0f : fast_powf(inSrc0, inSrc1)); } GF_DEVICE_FUNCTION void RSQvs(float4 *outDest, float inSrc0) { float rsq = rsqrtf(inSrc0); (*outDest).x = rsq; (*outDest).y = rsq; (*outDest).z = rsq; (*outDest).w = rsq; } GF_DEVICE_FUNCTION float RSQs_(float inSrc0) { return rsqrtf(inSrc0); } GF_DEVICE_FUNCTION float RCPs_(float inSrc0) { return recipf(inSrc0); } GF_DEVICE_FUNCTION float LG2s_(float inSrc0) { return fast_log2f(inSrc0); } GF_DEVICE_FUNCTION void FLR(float4 *outDest, float4 inSrc0) { (*outDest).x = floorf(inSrc0.x); (*outDest).y = floorf(inSrc0.y); (*outDest).z = floorf(inSrc0.z); (*outDest).w = floorf(inSrc0.w); } GF_DEVICE_FUNCTION float FLRs_(float inSrc0) { return floorf(inSrc0); } GF_DEVICE_FUNCTION float FLTs_(float inSrc0) { return floorf(inSrc0); } GF_DEVICE_FUNCTION void FRC(float4 *outDest, float4 inSrc0) { (*outDest).x = inSrc0.x - floorf(inSrc0.x); (*outDest).y = inSrc0.y - floorf(inSrc0.y); (*outDest).z = inSrc0.z - floorf(inSrc0.z); (*outDest).w = inSrc0.w - floorf(inSrc0.w); } GF_DEVICE_FUNCTION float FRCs_(float inSrc0) { return (inSrc0 - floorf(inSrc0)); }GF_DEVICE_FUNCTION void DP3(float4 *outDest, float4 inSrc0, float4 inSrc1) { float dot = (inSrc0.x * inSrc1.x) + (inSrc0.y * inSrc1.y) + (inSrc0.z * inSrc1.z); (*outDest).x = dot; (*outDest).y = dot; (*outDest).z = dot; (*outDest).w = dot; } GF_DEVICE_FUNCTION void DP3_xyz(float4 *outDest, float4 inSrc0, float4 inSrc1) { float dot = (inSrc0.x * inSrc1.x) + (inSrc0.y * inSrc1.y) + (inSrc0.z * inSrc1.z); (*outDest).x = dot; (*outDest).y = dot; (*outDest).z = dot; } GF_DEVICE_FUNCTION float DP3svv_(float4 inSrc0, float4 inSrc1) { return ((inSrc0.x * inSrc1.x) + (inSrc0.y * inSrc1.y) + (inSrc0.z * inSrc1.z)); } GF_DEVICE_FUNCTION float DP3svs_(float4 inSrc0, float inSrc1) { return ((inSrc0.x * inSrc1) + (inSrc0.y * inSrc1) + (inSrc0.z * inSrc1)); } GF_DEVICE_FUNCTION void DP3_yz(float4 *outDest, float4 inSrc0, float4 inSrc1) { float dot = (inSrc0.x * inSrc1.x) + (inSrc0.y * inSrc1.y) + (inSrc0.z * inSrc1.z); (*outDest).y = dot; (*outDest).z = dot; } GF_DEVICE_FUNCTION void DP3vvs_SAT(float4 *outDest, float4 inSrc0, float inSrc1) { float dot = saturate((inSrc0.x * inSrc1) + (inSrc0.y * inSrc1) + (inSrc0.z * inSrc1)); (*outDest).x = dot; (*outDest).y = dot; (*outDest).z = dot; (*outDest).w = dot; } GF_DEVICE_FUNCTION float DP3svv_SAT_(float4 inSrc0, float4 inSrc1) { return saturate((inSrc0.x * inSrc1.x) + (inSrc0.y * inSrc1.y) + (inSrc0.z * inSrc1.z)); } GF_DEVICE_FUNCTION float DP3svs_SAT_(float4 inSrc0, float inSrc1) { return saturate((inSrc0.x * inSrc1) + (inSrc0.y * inSrc1) + (inSrc0.z * inSrc1)); } GF_DEVICE_FUNCTION float DP4svs_(float4 inSrc0, float inSrc1) { return ((inSrc0.x * inSrc1) + (inSrc0.y * inSrc1) + (inSrc0.z * inSrc1) + (inSrc0.w * inSrc1)); } GF_DEVICE_FUNCTION float DPHsvv_(float4 inSrc0, float4 inSrc1) { return ((inSrc0.x * inSrc1.x) + (inSrc0.y * inSrc1.y) + (inSrc0.z * inSrc1.z) + inSrc1.w); } GF_DEVICE_FUNCTION float DPHsvv_SAT_(float4 inSrc0, float4 inSrc1) { return saturate((inSrc0.x * inSrc1.x) + (inSrc0.y * inSrc1.y) + (inSrc0.z * inSrc1.z) + inSrc1.w); } GF_DEVICE_FUNCTION void XPD(float4 *outDest, float4 inSrc0, float4 inSrc1) { (*outDest).x = inSrc0.y * inSrc1.z - inSrc0.z * inSrc1.y; (*outDest).y = inSrc0.z * inSrc1.x - inSrc0.x * inSrc1.z; (*outDest).z = inSrc0.x * inSrc1.y - inSrc0.y * inSrc1.x; } GF_DEVICE_FUNCTION void MOV(float4 *outDest, float4 inSrc0) { (*outDest).x = inSrc0.x; (*outDest).y = inSrc0.y; (*outDest).z = inSrc0.z; (*outDest).w = inSrc0.w; } GF_DEVICE_FUNCTION float MOVs_(float inSrc0) { return inSrc0; } GF_DEVICE_FUNCTION void MOV_xy(float4 *outDest, float4 inSrc0) { (*outDest).x = inSrc0.x; (*outDest).y = inSrc0.y; } GF_DEVICE_FUNCTION void MOV_yz(float4 *outDest, float4 inSrc0) { (*outDest).y = inSrc0.y; (*outDest).z = inSrc0.z; } GF_DEVICE_FUNCTION void MOV_xyz(float4 *outDest, float4 inSrc0) { (*outDest).x = inSrc0.x; (*outDest).y = inSrc0.y; (*outDest).z = inSrc0.z; } GF_DEVICE_FUNCTION void MOV_SAT(float4 *outDest, float4 inSrc0) { (*outDest).x = saturate(inSrc0.x); (*outDest).y = saturate(inSrc0.y); (*outDest).z = saturate(inSrc0.z); (*outDest).w = saturate(inSrc0.w); } GF_DEVICE_FUNCTION void MOV_SAT_xyz(float4 *outDest, float4 inSrc0) { (*outDest).x = saturate(inSrc0.x); (*outDest).y = saturate(inSrc0.y); (*outDest).z = saturate(inSrc0.z); }
#define TEXs_x(outDest, inCoords, inTexture) outDest = TEXs_x_(inCoords, inTexture, texSamplerRECT)

#define TEXs_y(outDest, inCoords, inTexture) outDest = TEXs_y_(inCoords, inTexture, texSamplerRECT)

#define TEXs_z(outDest, inCoords, inTexture) outDest = TEXs_z_(inCoords, inTexture, texSamplerRECT)

#define TEXs_w(outDest, inCoords, inTexture) outDest = TEXs_w_(inCoords, inTexture, texSamplerRECT)

#define TEXs_1d_x(outDest, inCoords, inTexture) outDest = TEXs_1d_x_(inCoords, inTexture, texSampler1D)

#define TEXs_1d_y(outDest, inCoords, inTexture) outDest = TEXs_1d_y_(inCoords, inTexture, texSampler1D)

#define TEXs_1d_z(outDest, inCoords, inTexture) outDest = TEXs_1d_z_(inCoords, inTexture, texSampler1D)

#define TEX(outDest, inCoords, inTexture) TEX_(outDest, inCoords, inTexture, texSamplerRECT)

#define TEX_1d(outDest, inCoords, inTexture) TEX_1d_(outDest, inCoords, inTexture, texSampler1D)

#define TEX_2d(outDest, inCoords, inTexture) TEX_2d_(outDest, inCoords, inTexture, texSampler2D)

#define TEX_3d(outDest, inCoords, inTexture) TEX_3d_(outDest, inCoords, inTexture, texSampler3D)

#define TEX_3d_xyz(outDest, inCoords, inTexture) TEX_3d_xyz_(outDest, inCoords, inTexture, texSampler3D)

#define ADDs(outDest, inSrc0, inSrc1) outDest = ADDs_(inSrc0, inSrc1)

#define SUBs(outDest, inSrc0, inSrc1) outDest = SUBs_(inSrc0, inSrc1)

#define MULs(outDest, inSrc0, inSrc1) outDest = MULs_(inSrc0, inSrc1)

#define MULs_SAT(outDest, inSrc0, inSrc1) outDest = MULs_SAT_(inSrc0, inSrc1)

#define MAXs(outDest, inSrc0, inSrc1) outDest = MAXs_(inSrc0, inSrc1)

#define MAXs_SAT(outDest, inSrc0, inSrc1) outDest = MAXs_SAT_(inSrc0, inSrc1)

#define MINs(outDest, inSrc0, inSrc1) outDest = MINs_(inSrc0, inSrc1)

#define MINs_SAT(outDest, inSrc0, inSrc1) outDest = MINs_SAT_(inSrc0, inSrc1)

#define SLTs(outDest, inSrc0, inSrc1) outDest = SLTs_(inSrc0, inSrc1)

#define MADs(outDest, inSrc0, inSrc1, inSrc2) outDest = MADs_(inSrc0, inSrc1, inSrc2)

#define CMPs(outDest, inSrc0, inSrc1, inSrc2) outDest = CMPs_(inSrc0, inSrc1, inSrc2)

#define LRPsvss(outDest, inSrc0, inSrc1, inSrc2) outDest = LRPsvss_(inSrc0, inSrc1, inSrc2)

#define ABSs(outDest, inSrc0) outDest = ABSs_(inSrc0)

#define POWs(outDest, inSrc0, inSrc1) outDest = POWs_(inSrc0, inSrc1)

#define RSQs(outDest, inSrc0) outDest = RSQs_(inSrc0)

#define RCPs(outDest, inSrc0) outDest = RCPs_(inSrc0)

#define LG2s(outDest, inSrc0) outDest = LG2s_(inSrc0)

#define FLRs(outDest, inSrc0) outDest = FLRs_(inSrc0)

#define FLTs(outDest, inSrc0) outDest = FLTs_(inSrc0)

#define FRCs(outDest, inSrc0) outDest = FRCs_(inSrc0)

#define DP3svv(outDest, inSrc0, inSrc1) outDest = DP3svv_(inSrc0, inSrc1)

#define DP3svs(outDest, inSrc0, inSrc1) outDest = DP3svs_(inSrc0, inSrc1)

#define DP3svv_SAT(outDest, inSrc0, inSrc1) outDest = DP3svv_SAT_(inSrc0, inSrc1)

#define DP3svs_SAT(outDest, inSrc0, inSrc1) outDest = DP3svs_SAT_(inSrc0, inSrc1)

#define DP4svs(outDest, inSrc0, inSrc1) outDest = DP4svs_(inSrc0, inSrc1)

#define DPHsvv(outDest, inSrc0, inSrc1) outDest = DPHsvv_(inSrc0, inSrc1)

#define DPHsvv_SAT(outDest, inSrc0, inSrc1) outDest = DPHsvv_SAT_(inSrc0, inSrc1)

#define MOVs(outDest, inSrc0) outDest = MOVs_(inSrc0)

#endif
GF_CUDA_TEXTURE(float4, texture0_RECT) GF_KERNEL ShaderKernel_fxDithering(COMMON_PARAMS) { BEGIN_NORMAL LOAD_PARAMS(2) PARAM (numOfColors , program_local[0]) PARAM (invNumOfColors, program_local[1]) TEMP r0, r1, r2, r3; FLR (&r1, fragment_texcoord0); MULvvs (&r1, r1, 0.5); FRC (&r1, r1); SUB (&r2, c4(0.5, 0.25, 0, 0), r1); CMPs (r1.x, vflip(r2.y), r2.x, r1.x); SUBs (r1.y, 0.5, r1.x); ADDvvs (&r1, s(r1, xyxy), 0.25); TEX (&r0, fragment_texcoord0, texture0_RECT); MOV_SAT (&r3, r0); MAD (&r2, r3, numOfColors, r1); FLR (&r2, r2); MUL_xyz (&result_color, r2, invNumOfColors); MOVs (result_color.w, r0.w); END }


// buildOptions=-cl-single-precision-constant -cl-fast-relaxed-math -cl-denorms-are-zero -cl-mad-enable -D GF_OPENCL_SUPPORTS_16F
// RUN: %occ-cli %s --cl-options="-I%cwd -I%S -cl-single-precision-constant -cl-fast-relaxed-math -cl-denorms-are-zero -cl-mad-enable -D GF_OPENCL_SUPPORTS_16F" %cfg_path --cl-device=%cl_device 2>&1
