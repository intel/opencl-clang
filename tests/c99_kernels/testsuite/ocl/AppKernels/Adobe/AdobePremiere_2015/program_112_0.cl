
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
GF_DEVICE_FUNCTION float2 AddFloat2s( float2 inValue0, float2 inValue1) { float2 result = { inValue0.x + inValue1.x, inValue0.y + inValue1.y }; return result; } GF_DEVICE_FUNCTION float2 SubtractFloat2s( float2 inValue0, float2 inValue1) { float2 result = { inValue0.x - inValue1.x, inValue0.y - inValue1.y, }; return result; } GF_DEVICE_FUNCTION float2 MultiplyFloat2( float2 inValue, float inScalar) { float2 result = { inValue.x * inScalar, inValue.y * inScalar, }; return result; }GF_DEVICE_FUNCTION float2 DivideFloat2( float2 inValue, float inScalar) { float2 result = { inValue.x / inScalar, inValue.y / inScalar }; return result; }GF_DEVICE_FUNCTION float4 AddFloat4s( float4 inValue0, float4 inValue1) { float4 result = { inValue0.x + inValue1.x, inValue0.y + inValue1.y, inValue0.z + inValue1.z, inValue0.w + inValue1.w }; return result; } GF_DEVICE_FUNCTION float4 SubtractFloat4s( float4 inValue0, float4 inValue1) { float4 result = { inValue0.x - inValue1.x, inValue0.y - inValue1.y, inValue0.z - inValue1.z, inValue0.w - inValue1.w }; return result; } GF_DEVICE_FUNCTION float4 MultiplyFloat4( float4 inValue, float inScalar) { float4 result = { inValue.x * inScalar, inValue.y * inScalar, inValue.z * inScalar, inValue.w * inScalar }; return result; }GF_DEVICE_FUNCTION float4 DivideFloat4( float4 inValue, float inScalar) { float4 result = { inValue.x / inScalar, inValue.y / inScalar, inValue.z / inScalar, inValue.w / inScalar }; return result; }GF_DEVICE_FUNCTION int __max_i( int a, int b) { return (a > b) ? a : b; } GF_DEVICE_FUNCTION int __min_i( int a, int b) { return (a < b) ? a : b; } GF_DEVICE_FUNCTION float __max_f( float a, float b) { return (a > b) ? a : b; } GF_DEVICE_FUNCTION float __min_f( float a, float b) { return (a < b) ? a : b; }GF_KERNEL _d_image_rgb2gray_kernel_div255( GF_PTR(float) d_imgout, int mem_w_out, GF_PTR(float4) d_imgin, int mem_w_in, int width, int height, float red_weight, float green_weight, float blue_weight) { int id_x = KernelX(); int id_y = KernelY(); if (id_x < width && id_y < height) { float4 pix = d_imgin[id_y*mem_w_in + id_x]; d_imgout[id_y*mem_w_out + id_x] = (pix.x*red_weight + pix.y*green_weight + pix.z*blue_weight) / 255.f; } } GF_DEVICE_FUNCTION float4 __d_bilinear_interp_pixel_float4( GF_PTR(float4) d_img, int mem_w_in, int width, int height, float x, float y) { float4 res = make_float4(0,0,0,0); int xx,yy; xx=x; yy=y; float dx,dy; dx=__max_i(__min_i(x-xx,1),0); dy=__max_i(__min_i(y-yy,1),0);
#pragma unroll
for(int m=0;m<=1;m++) { for(int n=0;n<=1;n++) { int uu=__max_i(0,__min_i(width-1,xx+m)); int vv=__max_i(0,__min_i(height-1,yy+n)); float s=fabs(1-m-dx)*fabs(1-n-dy); res = AddFloat4s(res, MultiplyFloat4(d_img[vv*mem_w_in+uu], s)); } } return res; } GF_DEVICE_FUNCTION float2 __d_bilinear_interp_pixel_float2( GF_PTR(float2) d_img, int mem_w_in, int width, int height, float x, float y) { float2 res = make_float2(0,0); int xx,yy; xx=x; yy=y; float dx,dy; dx=__max_i(__min_i(x-xx,1),0); dy=__max_i(__min_i(y-yy,1),0);
#pragma unroll
for(int m=0;m<=1;m++) { for(int n=0;n<=1;n++) { int uu=__max_i(0,__min_i(width-1,xx+m)); int vv=__max_i(0,__min_i(height-1,yy+n)); float s=fabs(1-m-dx)*fabs(1-n-dy); res = AddFloat2s(res, MultiplyFloat2(d_img[vv*mem_w_in+uu], s)); } } return res; } GF_KERNEL _d_bilinear_resize_kernel_float4( GF_PTR(float4) d_imgout, int mem_w_out, int width, int height, GF_PTR(float4) d_imgin, int mem_w_in, int width_in, int height_in, float scale_x, float scale_y) { int id_x = KernelX(); int id_y = KernelY(); if (id_x < width && id_y < height) { float div_scale_x=1.f/scale_x; float div_scale_y=1.f/scale_y; float fx=(float)(id_x+1)*div_scale_x-1; float fy=(float)(id_y+1)*div_scale_y-1; d_imgout[id_y*mem_w_out + id_x] = __d_bilinear_interp_pixel_float4(d_imgin,mem_w_in,width_in,height_in,fx,fy); } } GF_DEVICE_FUNCTION float2 __d_nn_interp_pixel_pitched_float2( GF_PTR(float2) d_img, int mem_w, int width, int height, float x, float y) { int xx,yy; xx=x; yy=y; return d_img[yy*mem_w+xx]; } GF_KERNEL _d_resize_flow_nn_kernel_f2p_f2p( GF_PTR(float2) flow_out, int out_mem_w, int width, int height, GF_PTR(float2) flow_small, int in_mem_w, int width_small, int height_small, float x_up_scale, float y_up_scale, float val_up_scale) { int id_x = KernelX(); int id_y = KernelY(); if (id_x < width && id_y < height) { float div_scale_x=1.f/x_up_scale; float div_scale_y=1.f/y_up_scale; float fx=(float)(id_x+1)*div_scale_x-1; float fy=(float)(id_y+1)*div_scale_y-1; flow_out[id_y*out_mem_w + id_x] = MultiplyFloat2(__d_nn_interp_pixel_pitched_float2(flow_small,in_mem_w,width_small,height_small,fx,fy), val_up_scale); } } GF_KERNEL _d_resize_flow_kernel_f2p_f1p( GF_PTR(float) u_out, GF_PTR(float) v_out, int uv_mem_w, int width, int height, GF_PTR(float2) uv_in, int uv_in_mem_w, int width_in, int height_in, float width_up_scale, float height_up_scale, float val_up_scale_x, float val_up_scale_y) { int id_x = KernelX(); int id_y = KernelY(); if (id_x < width && id_y < height) { float div_scale_x=1.f/width_up_scale; float div_scale_y=1.f/height_up_scale; float fx=(float)(id_x+1)*div_scale_x-1; float fy=(float)(id_y+1)*div_scale_y-1; float2 uv_pix = __d_bilinear_interp_pixel_float2(uv_in,uv_in_mem_w,width_in,height_in,fx,fy); u_out[id_y*uv_mem_w + id_x] = uv_pix.x * val_up_scale_x; v_out[id_y*uv_mem_w + id_x] = uv_pix.y * val_up_scale_y; } } GF_KERNEL _d_resize_flow_kernel_f2p_f2p( GF_PTR(float2) uv_out, int uv_mem_w, int width, int height, GF_PTR(float2) uv_in, int uv_in_mem_w, int width_in, int height_in, float width_up_scale, float height_up_scale, float val_up_scale_x, float val_up_scale_y) { int id_x = KernelX(); int id_y = KernelY(); if (id_x < width && id_y < height) { float div_scale_x=1.f/width_up_scale; float div_scale_y=1.f/height_up_scale; float fx=(float)(id_x+1)*div_scale_x-1; float fy=(float)(id_y+1)*div_scale_y-1; float2 uv_pix = __d_bilinear_interp_pixel_float2(uv_in,uv_in_mem_w,width_in,height_in,fx,fy); float2 uv_pix_out; uv_pix_out.x = uv_pix.x * val_up_scale_x; uv_pix_out.y = uv_pix.y * val_up_scale_y; uv_out[id_y*uv_mem_w + id_x] = uv_pix_out; } } GF_KERNEL _d_image_init_kernel_float( GF_PTR(float) d_imgout, int mem_w_out, float val, int width, int height) { int id_x = KernelX(); int id_y = KernelY(); if (id_x < width && id_y < height) { int id_out = id_y*mem_w_out + id_x; d_imgout[id_out] = val; } } GF_KERNEL _d_image_init_kernel_float2( GF_PTR(float2) d_imgout, int mem_w_out, float2 val, int width, int height) { int id_x = KernelX(); int id_y = KernelY(); if (id_x < width && id_y < height) { int id_out = id_y*mem_w_out + id_x; d_imgout[id_out] = val; } } GF_KERNEL _d_image_cvt_vec2_to_sg2_kernel_float_float2( GF_PTR(float) d_im1, GF_PTR(float) d_im2, int out_mem_w, GF_PTR(float2) d_img, int in_mem_w, int width, int height) { int id_x = KernelX(); int id_y = KernelY(); if (id_x < width && id_y < height) { float2 pixval = d_img[id_y*in_mem_w + id_x]; d_im1[id_y*out_mem_w + id_x] = pixval.x; d_im2[id_y*out_mem_w + id_x] = pixval.y; } } GF_KERNEL _d_image_cvt_sg2_to_vec2_kernel_float2_float( GF_PTR(float2) d_img, int out_mem_w, GF_PTR(float) d_im1, GF_PTR(float) d_im2, int in_mem_w, int width, int height) { int id_x = KernelX(); int id_y = KernelY(); if (id_x < width && id_y < height) { float pix1 = d_im1[id_y*in_mem_w + id_x]; float pix2 = d_im2[id_y*in_mem_w + id_x]; float2 val; val.x = pix1; val.y = pix2; d_img[id_y*out_mem_w + id_x] = val; } } GF_KERNEL _d_image_mutiply_scalar_kernel_float2( GF_PTR(float2) d_imgout, int mem_w_out, GF_PTR(float2) d_in, int mem_w_in, float scalar, int width, int height) { int id_x = KernelX(); int id_y = KernelY(); if (id_x < width && id_y < height) { int id_out = id_y*mem_w_out + id_x; int id_in = id_y*mem_w_in + id_x; d_imgout[id_out] = MultiplyFloat2(d_in[id_in], scalar); } } GF_KERNEL scale_source_kernel( GF_PTR(float4) dest_dev_ptr, GF_PTR(float4) src_dev_ptr, int width, int height, DevicePixelFormat src_device_format) { int id_x = KernelX(); int id_y = KernelY(); if (id_x < width && id_y < height) { int id = id_y * width + id_x; float4 pix_rgb = ReadPixel(src_dev_ptr, width, src_device_format, id_x, id_y); float4 pix; pix.x = pix_rgb.x * 255.f; pix.y = pix_rgb.y * 255.f; pix.z = pix_rgb.z * 255.f; pix.w = 255.0; dest_dev_ptr[id] = pix; } } GF_KERNEL unscale_dest_kernel( GF_PTR(float4) dest_dev_ptr, GF_PTR(float4) src_dev_ptr, int width, int height, DevicePixelFormat dest_device_format) { int id_x = KernelX(); int id_y = KernelY(); if (id_x < width && id_y < height) { int id = id_y * width + id_x; float4 pix_rgb = src_dev_ptr[id]; float4 pix; pix.x = pix_rgb.x / 255.f; pix.y = pix_rgb.y / 255.f; pix.z = pix_rgb.z / 255.f; pix.w = 1.0; WritePixel(pix, dest_dev_ptr, width, dest_device_format, id_x, id_y); } }


// buildOptions=-cl-single-precision-constant -cl-fast-relaxed-math -cl-denorms-are-zero -cl-mad-enable -D GF_OPENCL_SUPPORTS_16F
// RUN: %occ-cli %s --cl-options="-I%cwd -I%S -cl-single-precision-constant -cl-fast-relaxed-math -cl-denorms-are-zero -cl-mad-enable -D GF_OPENCL_SUPPORTS_16F" %cfg_path --cl-device=%cl_device 2>&1
