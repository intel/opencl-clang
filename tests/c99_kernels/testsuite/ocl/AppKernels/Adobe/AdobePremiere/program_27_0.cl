
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
GF_CUDA_TEXTURE(float4, inTexture) GF_DEVICE_FUNCTION float4 SampleTexture(float u, float v, GF_OPENCL_TEXTURE(inTexture)) { return GF_READTEXTURE(inTexture, u, v, CLK_NORMALIZED_COORDS_FALSE | CLK_ADDRESS_CLAMP_TO_EDGE | CLK_FILTER_LINEAR); } GF_DEVICE_FUNCTION float Distance(float x, float y, float2 o, float2 d) { float result = (d.x * (o.y - y) - d.y *(o.x - x)); return result; } GF_DEVICE_FUNCTION float Lerp(float a, float b, float t) { float result = a + t*(b-a); return result; } GF_DEVICE_FUNCTION float2 Average(float2 a, float2 b) { a.x = (a.x+b.x)*.5f; a.y = (a.y+b.y)*.5f; return a; } GF_DEVICE_FUNCTION float2 Average2(float2 a, float2 b, float2 c, float2 d) { a.x = (a.x+b.x+c.x+d.x)*.25f; a.y = (a.y+b.y+c.y+d.y)*.25f; return a; } GF_DEVICE_FUNCTION float4 Sum(float4 a, float4 b) { a.x += b.x; a.y += b.y; a.z += b.z; a.w += b.w; return a; } GF_DEVICE_FUNCTION float4 Weight(float4 color, float w) { color.x *= w; color.y *= w; color.z *= w; color.w *= w; return color; } GF_DEVICE_FUNCTION float3 Normalize(float3 v) { float ln = rsqrtf(v.x*v.x + v.y*v.y + v.z*v.z); v.x *= ln; v.y *= ln; v.z *= ln; return v; } GF_DEVICE_FUNCTION float3 Vector(float3 b, float3 c) { float3 a; a.x = b.x - c.x; a.y = b.y - c.y; a.z = b.z - c.z; return a; } GF_DEVICE_FUNCTION float3 CrossProduct(float3 b, float3 c) { float3 a; a.x = b.y * c.z - c.y * b.z; a.y = b.z * c.x - c.z * b.x; a.z = b.x * c.y - c.x * b.y; return a; } GF_DEVICE_FUNCTION float InnerProduct(float3 a, float3 b) { return a.x * b.x + a.y * b.y + a.z * b.z; } GF_DEVICE_FUNCTION float GetW0(float i) { const float A = -0.5; return (A + (-2*A + A*i)*i)*i; } GF_DEVICE_FUNCTION float GetW1(float i) { const float A = -0.5; return (((A+2)*i - (A+3))*i*i + 1); } GF_DEVICE_FUNCTION float4 bicubicTex2D(float u, float v, GF_OPENCL_TEXTURE(inTexture)) { float uw0,uw1,uw2,uw3; float vw0,vw1,vw2,vw3; float ui, vi; float uf, vf; float4 color; u -= .5f; v -= .5f; ui = floor(u); vi = floor(v); uf = u-ui; vf = v-vi; uw0 = GetW0(uf); uw1 = GetW1(uf); uw2 = GetW1(1-uf); uw3 = GetW0(1-uf); vw0 = GetW0(vf); vw1 = GetW1(vf); vw2 = GetW1(1-vf); vw3 = GetW0(1-vf); ui -= 0.5f; vi -= 0.5f; color = Weight(SampleTexture(ui+0, vi+0, GF_GET_TEXTURE(inTexture)), uw0*vw0); color = Sum(color, Weight(SampleTexture(ui+1, vi+0, GF_GET_TEXTURE(inTexture)), uw1*vw0)); color = Sum(color, Weight(SampleTexture(ui+2, vi+0, GF_GET_TEXTURE(inTexture)), uw2*vw0)); color = Sum(color, Weight(SampleTexture(ui+3, vi+0, GF_GET_TEXTURE(inTexture)), uw3*vw0)); color = Sum(color, Weight(SampleTexture(ui+0, vi+1, GF_GET_TEXTURE(inTexture)), uw0*vw1)); color = Sum(color, Weight(SampleTexture(ui+1, vi+1, GF_GET_TEXTURE(inTexture)), uw1*vw1)); color = Sum(color, Weight(SampleTexture(ui+2, vi+1, GF_GET_TEXTURE(inTexture)), uw2*vw1)); color = Sum(color, Weight(SampleTexture(ui+3, vi+1, GF_GET_TEXTURE(inTexture)), uw3*vw1)); color = Sum(color, Weight(SampleTexture(ui+0, vi+2, GF_GET_TEXTURE(inTexture)), uw0*vw2)); color = Sum(color, Weight(SampleTexture(ui+1, vi+2, GF_GET_TEXTURE(inTexture)), uw1*vw2)); color = Sum(color, Weight(SampleTexture(ui+2, vi+2, GF_GET_TEXTURE(inTexture)), uw2*vw2)); color = Sum(color, Weight(SampleTexture(ui+3, vi+2, GF_GET_TEXTURE(inTexture)), uw3*vw2)); color = Sum(color, Weight(SampleTexture(ui-0, vi+3, GF_GET_TEXTURE(inTexture)), uw0*vw3)); color = Sum(color, Weight(SampleTexture(ui+1, vi+3, GF_GET_TEXTURE(inTexture)), uw1*vw3)); color = Sum(color, Weight(SampleTexture(ui+2, vi+3, GF_GET_TEXTURE(inTexture)), uw2*vw3)); color = Sum(color, Weight(SampleTexture(ui+3, vi+3, GF_GET_TEXTURE(inTexture)), uw3*vw3)); return color; } GF_DEVICE_FUNCTION float2 ComputeUV(float3 p, float3 v0, float3 e1, float3 e2, float x, float y) { float3 d; float3 h, s, q; float a; float2 uv; d.x = x - p.x; d.y = y - p.y; d.z = 0 - p.z; d = Normalize(d); h = CrossProduct(d,e2); a = 1.0f / InnerProduct(e1,h); s = Vector(p,v0); uv.x = InnerProduct(s,h) * a; q = CrossProduct(s,e1); uv.y = InnerProduct(d,q) * a; return uv; } GF_DEVICE_FUNCTION float4 QuadCoverage(float2 qa, float2 qb, float2 qc, float2 qd, GF_OPENCL_TEXTURE(inTexture)) { typedef struct { float2 a, b, c, d; } localQuad; localQuad quads[7]; int i = 0; int s = 0; int sl[4]; int sc[4]; float t = 0.0f; float4 color = {0,0,0,0}; sl[0] = 0; sc[0] = 1; quads[0].a = qa; quads[0].b = qb; quads[0].c = qc; quads[0].d = qd; do { float2 a, b, c, d; float2 ab, bc, cd, da; float2 abcd; float2 uv, l; a = quads[i].a; b = quads[i].b; c = quads[i].c; d = quads[i].d; ab = Average(a, b); bc = Average(b, c); cd = Average(c, d); da = Average(d, a); abcd = Average(ab, cd); int subdivide = 0; uv.x = (da.x - bc.x); uv.y = (da.y - bc.y); l.x = uv.x*uv.x + uv.y*uv.y; if(l.x > 1.0f) subdivide |= 1; uv.x = (cd.x - ab.x); uv.y = (cd.y - ab.y); l.y = uv.x*uv.x + uv.y*uv.y; if(l.y > 1.0f) subdivide |= 2; if(!subdivide) { i -= 1; t += 1; color = Sum(color, SampleTexture(abcd.x, abcd.y, GF_GET_TEXTURE(inTexture))); sc[s] -= 1; if(sc[s] == 0) s -= 1; } else { if((sl[s] == 2) || ((l.x < 4.0f) && (l.y < 4.0f))) { i -= 1; if(subdivide == 3) { t += 4; uv = Average2(abcd, da, a, ab); color = Sum(color, SampleTexture(uv.x, uv.y, GF_GET_TEXTURE(inTexture))); uv = Average2(abcd, ab, b, bc); color = Sum(color, SampleTexture(uv.x, uv.y, GF_GET_TEXTURE(inTexture))); uv = Average2(abcd, bc, c, cd); color = Sum(color, SampleTexture(uv.x, uv.y, GF_GET_TEXTURE(inTexture))); uv = Average2(abcd, cd, d, da); color = Sum(color, SampleTexture(uv.x, uv.y, GF_GET_TEXTURE(inTexture))); } else if(subdivide == 2) { t += 2; uv = Average2(a, b, bc, da); color = Sum(color, SampleTexture(uv.x, uv.y, GF_GET_TEXTURE(inTexture))); uv = Average2(da, bc, c, d); color = Sum(color, SampleTexture(uv.x, uv.y, GF_GET_TEXTURE(inTexture))); } else { t += 2; uv = Average2(a, ab, cd, d); color = Sum(color, SampleTexture(uv.x, uv.y, GF_GET_TEXTURE(inTexture))); uv = Average2(ab, b, c, cd); color = Sum(color, SampleTexture(uv.x, uv.y, GF_GET_TEXTURE(inTexture))); } sc[s] -= 1; if(sc[s] == 0) s -= 1; } else { int count = 4; if(subdivide == 3) { quads[i+0].a = abcd; quads[i+0].b = da; quads[i+0].c = a; quads[i+0].d = ab; quads[i+1].a = abcd; quads[i+1].b = ab; quads[i+1].c = b; quads[i+1].d = bc; quads[i+2].a = abcd; quads[i+2].b = bc; quads[i+2].c = c; quads[i+2].d = cd; quads[i+3].a = abcd; quads[i+3].b = cd; quads[i+3].c = d; quads[i+3].d = da; } else if(subdivide == 2) { quads[i+0].a = a; quads[i+0].b = b; quads[i+0].c = bc; quads[i+0].d = da; quads[i+1].a = da; quads[i+1].b = bc; quads[i+1].c = c; quads[i+1].d = d; count = 2; } else { quads[i+0].a = a; quads[i+0].b = ab; quads[i+0].c = cd; quads[i+0].d = d; quads[i+1].a = ab; quads[i+1].b = b; quads[i+1].c = c; quads[i+1].d = cd; count = 2; } i += count-1; sc[s] -= 1; int l = sl[s]; if(sc[s] != 0) s += 1; sl[s] = l+1; sc[s] = count; } } } while(i >= 0); return Weight(color, 1.0f/t); } GF_DEVICE_FUNCTION float4 SampleQuad(float2 a, float2 b, float2 c, float2 d, GF_OPENCL_TEXTURE(inTexture)) { float2 abcd, ab, bc, cd, da; float2 uv, l; ab = Average(a, b); bc = Average(b, c); cd = Average(c, d); da = Average(d, a); abcd = Average(ab, cd); int subdivide = 0; uv.x = (da.x - bc.x); uv.y = (da.y - bc.y); l.x = uv.x*uv.x + uv.y*uv.y; if(l.x > 1.001f) subdivide |= 1; uv.x = (ab.x - cd.x); uv.y = (ab.y - cd.y); l.y = uv.x*uv.x + uv.y*uv.y; if(l.y > 1.001f) subdivide |= 2; if(!subdivide) return bicubicTex2D(abcd.x, abcd.y, GF_GET_TEXTURE(inTexture)); if((l.x > 4) || (l.y > 4)) return QuadCoverage(a, b, c, d, GF_GET_TEXTURE(inTexture)); uv = Average2(abcd, ab, a, da); float4 color = SampleTexture(uv.x, uv.y, GF_GET_TEXTURE(inTexture)); uv = Average2(abcd, ab, b, bc); color = Sum(color, SampleTexture(uv.x, uv.y, GF_GET_TEXTURE(inTexture))); uv = Average2(abcd, cd, c, bc); color = Sum(color, SampleTexture(uv.x, uv.y, GF_GET_TEXTURE(inTexture))); uv = Average2(abcd, cd, d, da); color = Sum(color, SampleTexture(uv.x, uv.y, GF_GET_TEXTURE(inTexture))); color = Weight(color, .25f); l.x = max(l.x, l.y); if(l.x < (1.2f*1.2f)) { float t = (l.x-1.0f)/((1.2f*1.2f)-1.0f); float4 colorB = bicubicTex2D(abcd.x, abcd.y, GF_GET_TEXTURE(inTexture)); color.x = Lerp(colorB.x, color.x, t); color.y = Lerp(colorB.y, color.y, t); color.z = Lerp(colorB.z, color.z, t); color.w = Lerp(colorB.w, color.w, t); } return color; } GF_KERNEL cuda_kernel_renderquad(GF_PTR(float4) dstFrame, int width, int height, float tWidth, float tHeight, int srcPitch, int dstPitch, DevicePixelFormat inDeviceFormat, float4 quadv0F4, float4 quade1F4, float4 quade2F4, float4 quadpF4, float2 quadc0, float2 quadc1, float2 quadc2, float2 quadc3, float2 quadd0, float2 quadd1, float2 quadd2, float2 quadd3, int quadlight, GF_OPENCL_TEXTURE(inTexture)) { float3 quadv0; quadv0.x = quadv0F4.x; quadv0.y = quadv0F4.y; quadv0.z = quadv0F4.z; float3 quade1; quade1.x = quade1F4.x; quade1.y = quade1F4.y; quade1.z = quade1F4.z; float3 quade2; quade2.x = quade2F4.x; quade2.y = quade2F4.y; quade2.z = quade2F4.z; float3 quadp; quadp.x = quadpF4.x; quadp.y = quadpF4.y; quadp.z = quadpF4.z; int x = KernelX(); int y = KernelY(); if(x >= width || y >= height) return; float edge; edge = 1.0f - saturate(Distance(x+.5f, y+.5f, quadc0, quadd0)+.5f); edge *= 1.0f - saturate(Distance(x+.5f, y+.5f, quadc1, quadd1)+.5f); edge *= 1.0f - saturate(Distance(x+.5f, y+.5f, quadc2, quadd2)+.5f); edge *= 1.0f - saturate(Distance(x+.5f, y+.5f, quadc3, quadd3)+.5f); if (edge == 0.0f) { WriteRGBPixel(BGRA(0,0,0,0), dstFrame, dstPitch, inDeviceFormat, x, y); return; } float2 a = ComputeUV(quadp, quadv0, quade1, quade2, x+0, y+0); float2 b = ComputeUV(quadp, quadv0, quade1, quade2, x+1, y+0); float2 c = ComputeUV(quadp, quadv0, quade1, quade2, x+1, y+1); float2 d = ComputeUV(quadp, quadv0, quade1, quade2, x+0, y+1); a.x *= tWidth; a.y *= tHeight; b.x *= tWidth; b.y *= tHeight; c.x *= tWidth; c.y *= tHeight; d.x *= tWidth; d.y *= tHeight; float4 color = SampleQuad(a, b, c, d, GF_GET_TEXTURE(inTexture)); color = Weight(color, edge); if (quadlight) { float3 n, i, l, v; float nl, nv; float3 lightPoint = {-100,-100,-100}; float3 e1 = Normalize(quade1); float3 e2 = Normalize(quade2); n = CrossProduct(e1, e2); i.x = quadv0.x + e1.x*a.x + e2.x*a.y; i.y = quadv0.y + e1.y*a.x + e2.y*a.y; i.z = quadv0.z + e1.z*a.x + e2.z*a.y; l = Vector(i, lightPoint); v = Vector(i, quadp); l = Normalize(l); v = Normalize(v); nl = InnerProduct(n, l); n.x *= nl*2; n.y *= nl*2; n.z *= nl*2; n = Vector(n, l); nv = InnerProduct(n, v); nv = max(nv, 0.0f); nv = Power(nv, 8.0f*2.2f); nv *= color.w; color.x += nv; color.y += nv; color.z += nv; } color.w = saturate(color.w); if (color.w == 0.0f) { color.x = color.y = color.z = 0.0f; } else { float ra = 1.0f / color.w; color.x = FromLinearColor(color.x*ra); color.y = FromLinearColor(color.y*ra); color.z = FromLinearColor(color.z*ra); } WritePixel(color, dstFrame, dstPitch, inDeviceFormat, x, y); } GF_KERNEL cuda_kernel_prepsource(const GF_PTR(float4) srcFrame, GF_PTR(float4) dstFrame, int width, int height, int srcPitch, int dstPitch, DevicePixelFormat inDeviceFormat) { int x = KernelX(); int y = KernelY(); if (x < width && y < height) { PixelRGB pixel = ReadRGBPixel(srcFrame, srcPitch, inDeviceFormat, x, y); pixel.a = saturate(pixel.a); pixel.r = ToLinearColor(pixel.r)*pixel.a; pixel.g = ToLinearColor(pixel.g)*pixel.a; pixel.b = ToLinearColor(pixel.b)*pixel.a; WriteRGBPixel(pixel, dstFrame, dstPitch, inDeviceFormat, x, y); } }

// buildOptions= -cl-single-precision-constant -cl-fast-relaxed-math
// RUN: %occ-cli %s --cl-options="-I%cwd -I%S  -cl-single-precision-constant -cl-fast-relaxed-math" %cfg_path --cl-device=%cl_device 2>&1
