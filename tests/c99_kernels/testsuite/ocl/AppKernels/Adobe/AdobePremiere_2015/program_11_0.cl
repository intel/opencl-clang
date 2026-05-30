
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

#ifndef GFKERNELSUPPORT_PIXELUTILS_H
#define GFKERNELSUPPORT_PIXELUTILS_H
GF_DEVICE_FUNCTION PixelRGB AddPixels( PixelRGB inPixel0, PixelRGB inPixel1) { PixelRGB result = { inPixel0.b + inPixel1.b, inPixel0.g + inPixel1.g, inPixel0.r + inPixel1.r, inPixel0.a + inPixel1.a, }; return result; } GF_DEVICE_FUNCTION PixelRGB MultiplyPixels( PixelRGB inPixel0, PixelRGB inPixel1) { PixelRGB result = { inPixel0.b * inPixel1.b, inPixel0.g * inPixel1.g, inPixel0.r * inPixel1.r, inPixel0.a * inPixel1.a, }; return result; } GF_DEVICE_FUNCTION PixelRGB SubtractPixels( PixelRGB inPixel0, PixelRGB inPixel1) { PixelRGB result = { inPixel0.b - inPixel1.b, inPixel0.g - inPixel1.g, inPixel0.r - inPixel1.r, inPixel0.a - inPixel1.a, }; return result; } GF_DEVICE_FUNCTION PixelRGB MultiplyPixel( PixelRGB inPixel, float inS) { return MultiplyPixels(inPixel, BGRA(inS, inS, inS, inS)); } GF_DEVICE_FUNCTION PixelRGB DividePixels( PixelRGB inPixel0, PixelRGB inPixel1) { PixelRGB result = { fdividef(inPixel0.b, inPixel1.b), fdividef(inPixel0.g, inPixel1.g), fdividef(inPixel0.r, inPixel1.r), fdividef(inPixel0.a, inPixel1.a), }; return result; } GF_DEVICE_FUNCTION PixelRGB DividePixel( PixelRGB inPixel, float inS) { return DividePixels(inPixel, BGRA(inS, inS, inS, inS)); } GF_DEVICE_FUNCTION PixelRGB PowerPixels( PixelRGB inPixel, float inS) { PixelRGB result = { Power(inPixel.b, inS), Power(inPixel.g, inS), Power(inPixel.r, inS), Power(inPixel.a, inS), }; return result; } GF_DEVICE_FUNCTION PixelRGB AbsPixels( PixelRGB inPixel) { PixelRGB result = { fabsf(inPixel.b), fabsf(inPixel.g), fabsf(inPixel.r), fabsf(inPixel.a), }; return result; } GF_DEVICE_FUNCTION float MaxPixel( PixelRGB inPixel) { return max(max(max(inPixel.b, inPixel.g), inPixel.r), inPixel.a); } GF_DEVICE_FUNCTION PixelRGB ClampPixel( PixelRGB inPixel, float inMin, float inMax) { PixelRGB result = { clamp(inPixel.b, inMin, inMax), clamp(inPixel.g, inMin, inMax), clamp(inPixel.r, inMin, inMax), clamp(inPixel.a, inMin, inMax), }; return result; } GF_DEVICE_FUNCTION PixelRGB OpaquePixel( PixelRGB inPixel) { PixelRGB result = inPixel; result.a = 1.0f; return result; } GF_DEVICE_FUNCTION PixelRGB PremultiplyPixel( PixelRGB inPixel) { PixelRGB result = inPixel; result.r *= inPixel.a; result.g *= inPixel.a; result.b *= inPixel.a; return result; } GF_DEVICE_FUNCTION PixelRGB UnpremultiplyPixel( PixelRGB inPixel) { PixelRGB result = inPixel; result.a = saturate(result.a); if (!fIsLessThanOrEqual(result.a, 0.0f)) { float ra = fdividef(1.0f, result.a); result.r *= ra; result.g *= ra; result.b *= ra; } else { result.r = result.g = result.b = result.a = 0.f; } return result; } GF_DEVICE_FUNCTION float ToLinearColor(float inValue) { return Power(inValue, 2.2f); } GF_DEVICE_FUNCTION float FromLinearColor(float inValue) { return Power(inValue, 1.0f/2.2f); } GF_DEVICE_FUNCTION PixelRGB PremultiplyLinearizePixel(PixelRGB inPixel) { PixelRGB result = inPixel; result.a = saturate(result.a); result.b = ToLinearColor(result.b); result.g = ToLinearColor(result.g); result.r = ToLinearColor(result.r); return PremultiplyPixel(result); } GF_DEVICE_FUNCTION PixelRGB UnpremultiplyUnlinearizePixel(PixelRGB inPixel) { PixelRGB result = UnpremultiplyPixel(inPixel); result.b = FromLinearColor(result.b); result.g = FromLinearColor(result.g); result.r = FromLinearColor(result.r); return result; }
#endif
GF_TEXTURE(float4, inputTex, CLK_NORMALIZED_COORDS_FALSE | CLK_ADDRESS_CLAMP_TO_EDGE | CLK_FILTER_LINEAR) GF_DEVICE_FUNCTION void CreateQuadFromGrid(int xi, int yi, GF_PTR(float) inVarVector, int inGridWidth, float2 outCorners[]) { int index = 0; index = 2*((yi+0)*inGridWidth+xi+0); outCorners[0].x = inVarVector[index]; outCorners[0].y = inVarVector[index+1]; index = 2*((yi+0)*inGridWidth+xi+1); outCorners[1].x = inVarVector[index]; outCorners[1].y = inVarVector[index+1]; index = 2*((yi+1)*inGridWidth+xi+0); outCorners[2].x = inVarVector[index]; outCorners[2].y = inVarVector[index+1]; index = 2*((yi+1)*inGridWidth+xi+1); outCorners[3].x = inVarVector[index]; outCorners[3].y = inVarVector[index+1]; } GF_DEVICE_FUNCTION void QuadBoundingBox(const float2 inCorners[], float* lowx, float* upx, float* lowy, float* upy) { *lowx = *upx = inCorners[0].x; *lowy = *upy = inCorners[0].y; for (int i=1; i<4; ++i) { *lowx = min(*lowx,inCorners[i].x); *upx = max(*upx,inCorners[i].x); *lowy = min(*lowy,inCorners[i].y); *upy = max(*upy,inCorners[i].y); } } GF_DEVICE_FUNCTION int QuadContainsPoint(const float2 inCorners[], const float2* pt) { float pToV0x = inCorners[0].x - (*pt).x; float pToV0y = inCorners[0].y - (*pt).y; float pToV1x = inCorners[1].x - (*pt).x; float pToV1y = inCorners[1].y - (*pt).y; if (pToV0x * pToV1y >= pToV1x * pToV0y) { float pToV3x = inCorners[3].x - (*pt).x; float pToV3y = inCorners[3].y - (*pt).y; if (pToV1x * pToV3y >= pToV3x * pToV1y) { float pToV2x = inCorners[2].x - (*pt).x; float pToV2y = inCorners[2].y - (*pt).y; if (pToV3x * pToV2y >= pToV2x * pToV3y && pToV2x * pToV0y >= pToV0x * pToV2y) { return true; } } } return false; } GF_DEVICE_FUNCTION void PreMultiplyHomography(const float inHomographyV[], float2* ioV) { float w_out = inHomographyV[2]*(*ioV).x + inHomographyV[5]*(*ioV).y + inHomographyV[8]; float x_out = fdividef((inHomographyV[0]*(*ioV).x + inHomographyV[3]*(*ioV).y + inHomographyV[6]), w_out); (*ioV).y = fdividef((inHomographyV[1]*(*ioV).x + inHomographyV[4]*(*ioV).y + inHomographyV[7]) , w_out); (*ioV).x = x_out; } GF_DEVICE_FUNCTION void computeInverseTransform(const float2 quad[], float result[]) { float px,py; float a,b,c,d,e,f,g,h,i; const float2 * V = quad; px = V[0].x - V[1].x + V[3].x - V[2].x; py = V[0].y - V[1].y + V[3].y - V[2].y; if (fabsf(px) < 1.e-5f || fabsf(py) < 1.e-5f) { a = V[1].x - V[0].x; b = V[3].x - V[1].x; c = V[0].x; d = V[1].y - V[0].y; e = V[3].y - V[1].y; f = V[0].y; g = h = 0.0f; } else { float dx1,dx2,dy1,dy2,del; dx1 = V[1].x - V[3].x; dx2 = V[2].x - V[3].x; dy1 = V[1].y - V[3].y; dy2 = V[2].y - V[3].y; del = dx1*dy2 - dx2*dy1; g = fdividef(px*dy2 - dx2*py, del); h = fdividef(dx1*py - px*dy1, del); a = V[1].x - V[0].x + g*V[1].x; b = V[2].x - V[0].x + h*V[2].x; c = V[0].x; d = V[1].y - V[0].y + g*V[1].y; e = V[2].y - V[0].y + h*V[2].y; f = V[0].y; } i = 1.0f; result[0] = e*i - f*h; result[1] = f*g - d*i; result[2] = d*h - e*g; result[3] = c*h - b*i; result[4] = a*i - c*g; result[5] = b*g - a*h; result[6] = b*f - c*e; result[7] = c*d - a*f; result[8] = a*e - b*d; } GF_DEVICE_FUNCTION float ComputeGridStep( int dimension, int grid_dimension) { return fdividef(dimension-1, grid_dimension-1); } GF_KERNEL StabilizerWarpKernel( GF_OPENCL_TEXTURE(inputTex), DevicePixelFormat inDeviceFormat, GF_PTR(float4) inOutput, int inOutputWidth, int inOutputHeight, int inOutputPitch, int inInputWidth, int inInputHeight, GF_PTR(float) inVarVector, int inGridWidth, int inGridHeight, float4 inBoundingBox, float4 inCropWindow, int doCrop, int inOutputLeft, int inOutputTop, int inOutputRight, int inOutputBottom, float inZoomFactor) { int quad_yi = BlockID().y; int quad_xi = BlockID().x; if (quad_xi < inGridWidth - 1 && quad_yi < inGridHeight - 1) { float zm_crop_left = inCropWindow.x + inBoundingBox.x; float zm_crop_top = inCropWindow.y + inBoundingBox.y; float zm_crop_right = inCropWindow.z + inBoundingBox.x; float zm_crop_bottom = inCropWindow.w + inBoundingBox.y; float zm_crop_center_x = (zm_crop_left + zm_crop_right) * inZoomFactor / 2; float zm_crop_center_y = (zm_crop_top + zm_crop_bottom) * inZoomFactor / 2; int zm_crop_center_x_int = (int) zm_crop_center_x; int zm_crop_center_y_int = (int) zm_crop_center_y; int bbW = (int) ceil(inBoundingBox.z - inBoundingBox.x); int bbH = (int) ceil(inBoundingBox.w - inBoundingBox.y); int zm_wLimit = (int)(bbW * inZoomFactor); int zm_hLimit = (int)(bbH * inZoomFactor); float f_out_center_x = (float)((doCrop ? inOutputWidth : bbW) -1)/ 2.0; float f_out_center_y = (float)((doCrop ? inOutputHeight : bbH) -1)/ 2.0; int out_center_x = (int)(f_out_center_x); int out_center_y = (int)(f_out_center_y); float center_u = (zm_crop_center_x - zm_crop_center_x_int) - (f_out_center_x - out_center_x); float center_v = (zm_crop_center_y - zm_crop_center_y_int) - (f_out_center_y - out_center_y); float2 quad[4]; CreateQuadFromGrid(quad_xi, quad_yi, inVarVector, inGridWidth, quad); float lowx, upx, lowy, upy; QuadBoundingBox(quad, &lowx, &upx, &lowy, &upy); lowx *= inZoomFactor; upx *= inZoomFactor; lowy *= inZoomFactor; upy *= inZoomFactor; int ilowx = (int) floor(lowx - 1); int ilowy = (int) floor(lowy - 1); int iupx = min((int)(ceil(upx+1)), zm_wLimit); int iupy = min((int)(ceil(upy+1)), zm_hLimit); int left, right, top, bottom; if (doCrop) { left = inOutputLeft; right = inOutputRight; top = inOutputTop; bottom = inOutputBottom; } else { left = top = 0; right = inOutputWidth; bottom = inOutputHeight; } float horizGridStep = ComputeGridStep(inInputWidth, inGridWidth); float vertGridStep = ComputeGridStep(inInputHeight, inGridHeight); float inverseTransform[9]; computeInverseTransform(quad,inverseTransform); for (int zy = ilowy + ThreadID().y; zy <= iupy; zy += BlockSize().y) { int des_y = out_center_y + zy - zm_crop_center_y_int; if(des_y < top || des_y >= bottom) continue; float fy = fdividef(zy + center_v, inZoomFactor); for (int zx = ilowx + ThreadID().x; zx <= iupx; zx += BlockSize().x) { int des_x = out_center_x + zx - zm_crop_center_x_int; if(des_x < left || des_x >= right) continue; float fx = fdividef(zx + center_u, inZoomFactor); float2 vert; vert.x = fx; vert.y = fy; if (QuadContainsPoint(quad, &vert) && fx < (float)bbW && fy < (float)bbH) { float2 uv = vert; PreMultiplyHomography(inverseTransform, &uv); uv.x = ((float)(quad_xi) + uv.x)*horizGridStep - 0.5f; uv.y = ((float)(quad_yi) + uv.y)*vertGridStep - 0.5f; uv.x = max(.0001f, uv.x); uv.x = min((float)inInputWidth - 1.0001f, uv.x); uv.y = max(.0001f, uv.y); uv.y = min((float)inInputHeight - 1.0001f, uv.y); PixelRGB pixel = GF_READTEXTUREPIXEL(inputTex, uv.x + 0.5f, uv.y + 0.5f); WriteRGBPixel( pixel, inOutput, inOutputPitch, inDeviceFormat, des_x, des_y); } } } } }


// buildOptions=-cl-single-precision-constant -cl-fast-relaxed-math -cl-denorms-are-zero -cl-mad-enable -D GF_OPENCL_SUPPORTS_16F
// RUN: %occ-cli %s --cl-options="-I%cwd -I%S -cl-single-precision-constant -cl-fast-relaxed-math -cl-denorms-are-zero -cl-mad-enable -D GF_OPENCL_SUPPORTS_16F" %cfg_path --cl-device=%cl_device 2>&1
