
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

#ifndef KEYER_KERNELS_H
#define KEYER_KERNELS_H

#define kBoxBlur_ColPerBlock 128

#define kBoxBlur_BlockWidth (kBoxBlur_ColPerBlock + 32)

#define kBoxBlur_RowsPerThread 100
typedef struct { float colorRange; float spill; float tolerance; float desaturate; float transparency; float shadow; float highlight; float luma; float noiseFilter0; float noiseFilter1; float rgb2xyz0x; float rgb2xyz0y; float rgb2xyz0z; float rgb2xyz1x; float rgb2xyz1y; float rgb2xyz1z; float rgb2xyz2x; float rgb2xyz2y; float rgb2xyz2z; float xyz2rgb0x; float xyz2rgb0y; float xyz2rgb0z; float xyz2rgb1x; float xyz2rgb1y; float xyz2rgb1z; float xyz2rgb2x; float xyz2rgb2y; float xyz2rgb2z; float xyz2rgb3x; float xyz2rgb3y; float xyz2rgb3z; float blurFrac; float chokeFrac; int blurR; int chokeR; float remapA; float remapB; float refx; float refy; float refz; float s; } KeyerParams;
#endif
GF_DEVICE_FUNCTION float ReadAlpha( const GF_PTR(float4) inImage, int inIndex, DevicePixelFormat inDeviceFormat) {
#if GF_OPENCL_SUPPORTS_16F
 if (inDeviceFormat == kDevicePixelFormat_BGRA_4444_16f) { return vload_half(inIndex * 4 + 3, (const GF_PTR(half))inImage); } else
#endif
 { return inImage[inIndex].w; } } GF_DEVICE_FUNCTION void WriteAlpha( GF_PTR(float4) inImage, int inIndex, float inValue, DevicePixelFormat inDeviceFormat) {
#if GF_OPENCL_SUPPORTS_16F
 if (inDeviceFormat == kDevicePixelFormat_BGRA_4444_16f) { vstore_half(inValue, inIndex * 4 + 3, (GF_PTR(half))inImage); } else
#endif
 { inImage[inIndex].w = inValue; } }GF_DEVICE_FUNCTION int Roll(int inA, int inB) { return inA < inB ? inA : inA - inB; } GF_DEVICE_FUNCTION float fromsRGB(float v) { v = saturate(v); if(v > 0.04045f) { v = Power(((v + 0.055f)/1.055f), 2.4f); } else { v /= 12.92f; } return v; } GF_DEVICE_FUNCTION float tosRGB(float v) { v = saturate(v); if(v < 0.0031308f) { v = v * 12.92f; } else { v = 1.055f * Power(v, 0.41666f) - 0.055f; } return v; } GF_DEVICE_FUNCTION float4 cuda_kernel_keyer( GF_CONSTANT_PTR(KeyerParams) inParams, float4 pixel) { float3 src; float3 ref; float3 dif; float s, m, t; float2 d; float a; ref.x = inParams->refx; ref.y = inParams->refy; ref.z = inParams->refz; s = inParams->s; pixel.x = fromsRGB(pixel.x); pixel.y = fromsRGB(pixel.y); pixel.z = fromsRGB(pixel.z); src.x = pixel.z * inParams->rgb2xyz0x + pixel.y * inParams->rgb2xyz0y + pixel.x * inParams->rgb2xyz0z; src.y = pixel.z * inParams->rgb2xyz1x + pixel.y * inParams->rgb2xyz1y + pixel.x * inParams->rgb2xyz1z; src.z = pixel.z * inParams->rgb2xyz2x + pixel.y * inParams->rgb2xyz2y + pixel.x * inParams->rgb2xyz2z; src.z = max(src.z, 1e-37f); src.x = fdividef(src.x, src.z); src.y = fdividef(src.y, src.z); dif.x = src.x - ref.x; dif.y = src.y - ref.y; dif.z = src.z - ref.z; m = rsqrtf(max(dif.x*dif.x + dif.y*dif.y, 1e-37f)); t = (dif.x*ref.x + dif.y*ref.y) * (s*m); if(t > 0.0f) { d.x = t*inParams->tolerance; d.y = inParams->tolerance; } else { d.x = 0.0f; d.y = ((1.0f+t)*inParams->tolerance); } d.x = 1.0f - d.x; d.y = 1.0f - d.y; m = fdividef(1.0f, m) * s; d.x = d.x * m; d.y = d.y * m; t = saturate(d.y * inParams->colorRange); t = fdividef(1.0f, max(t, 1e-37f)) - 1.0f; t += inParams->spill*t; src.x += dif.x*t; src.y += dif.y*t; t = saturate(d.y * inParams->desaturate); src.x *= t; src.y *= t; a = saturate(d.x * inParams->transparency); t = fdividef(dif.z , ref.z); if(t < 0.0f) t *= inParams->shadow; else t *= inParams->highlight; t = saturate(t); a = a+t - a*t; t = fdividef(1.0f, max(a, 1e-37f)) - 1.0f; t *= inParams->luma; src.z += dif.z*t; a *= inParams->noiseFilter0; a -= inParams->noiseFilter1; a = saturate(a); src.x *= src.z; src.y *= src.z; pixel.x = tosRGB(src.x * inParams->xyz2rgb2x + src.y * inParams->xyz2rgb2y + src.z * inParams->xyz2rgb2z + inParams->xyz2rgb3x); pixel.y = tosRGB(src.x * inParams->xyz2rgb1x + src.y * inParams->xyz2rgb1y + src.z * inParams->xyz2rgb1z + inParams->xyz2rgb3y); pixel.z = tosRGB(src.x * inParams->xyz2rgb0x + src.y * inParams->xyz2rgb0y + src.z * inParams->xyz2rgb0z + inParams->xyz2rgb3z); pixel.w *= a; return pixel; } GF_DEVICE_FUNCTION void MinRow(int inCount, GF_PTR(float2) d, GF_SHARED_PTR(float) line) { int r1 = inCount+1; float t0 = line[0-r1]; float t1 = line[1-r1]; for(int i=0; i < inCount*2; i+=2) { t1 = min(t1, line[i+2-r1]); t1 = min(t1, line[i+3-r1]); } t0 = min(t0, line[r1+r1-r1]); d[0].y = t1; d[0].x = min(t0, t1); } GF_KERNEL cuda_kernel_chokefilter_x(const GF_PTR(float4) id, GF_PTR(float2) od, int idPitch, int odPitch, int w, int h, int r, DevicePixelFormat inDeviceFormat) { GF_SHARED(float) data[16+256+16]; int x = KernelX(); int r1 = r+1; int index = GF_FASTMULTIPLY(BlockID().y, idPitch) + x; GF_PTR(float2) d = &od[BlockID().y*odPitch + x]; GF_SHARED_PTR(float) line = &data[16+ThreadID().x]; if (x < w) { line[0] = ReadAlpha(id, index, inDeviceFormat); if(ThreadID().x < r1) { if(x < r1) line[-r1] = line[0]; else line[-r1] = ReadAlpha(id, index - r1, inDeviceFormat); } else if(ThreadID().x >= (BlockSize().x - r1)) { if(x >= (w-r1)) line[r1] = line[0]; else line[r1] = ReadAlpha(id, index + r1, inDeviceFormat); } } SyncThreads(); if (x >= w) return; if(r <= 3 && r >= 0) { MinRow(r, d, line); } else { float t0 = line[0-r1]; float t1 = line[1-r1]; for(int i=0; i < r*2; i+=2) { t1 = min(t1, line[i+2-r1]); t1 = min(t1, line[i+3-r1]); } t0 = min(t0, line[r1+r1-r1]); d[0].y = t1; d[0].x = min(t0, t1); } } GF_DEVICE_FUNCTION float2 MinColumn(int inCount, GF_SHARED_PTR(float2) line) { int r1 = inCount+1; float2 t; t.x = min(line[0-r1].x, line[1-r1].x); t.y = line[1-r1].y; for(int i=0; i < inCount*2; i+=2) { t.x = min(t.x, line[i+2-r1].x); t.y = min(t.y, line[i+2-r1].y); t.x = min(t.x, line[i+3-r1].x); t.y = min(t.y, line[i+3-r1].y); } t.x = min(t.x, line[r1+r1-r1].x); return t; } GF_KERNEL cuda_kernel_chokefilter_y(GF_PTR(float2) id, GF_PTR(float4) od, int idPitch, int odPitch, int w, int h, int r, float f, int remap, DevicePixelFormat inDeviceFormat, GF_OPENCL_CONSTANT(KeyerParams, inParams)) { GF_SHARED(float2) data[25*16]; int x = KernelX(); int y = KernelY(); int r1 = r+1; const GF_PTR(float2) s = &id[y*idPitch + x]; GF_SHARED_PTR(float2) line = &data[8+ThreadID().x*25 + ThreadID().y]; if (x < w && y < h) { line[0] = s[0]; if(ThreadID().y < r1) { if(y<r1) line[-r1] = line[0]; else line[-r1] = s[-r1*idPitch]; } if(ThreadID().y >= (BlockSize().y-r1)) { if(y>=h-r1) line[r1] = line[0]; else line[r1] = s[r1*idPitch]; } } SyncThreads(); if (x >= w || y >= h) return; float2 t; if(r <= 3 && r >= 0) { t = MinColumn(r, line); } else { t.x = min(line[0-r1].x, line[1-r1].x); t.y = line[1-r1].y; for(int i=0; i < r*2; i+=2) { t.x = min(t.x, line[i+2-r1].x); t.y = min(t.y, line[i+2-r1].y); t.x = min(t.x, line[i+3-r1].x); t.y = min(t.y, line[i+3-r1].y); } t.x = min(t.x, line[r1+r1-r1].x); } t.x = t.y*(1-f) + t.x * f; if(remap) { t.x = saturate(t.x*GF_GET_CONSTANT(inParams)->remapA + GF_GET_CONSTANT(inParams)->remapB); } WriteAlpha(od, GF_FASTMULTIPLY(y, odPitch) + x, t.x, inDeviceFormat); } GF_KERNEL BoxFilterKernel( GF_PTR(float4) ioImage, int inPitch, DevicePixelFormat inDeviceFormat, int inWidth, int inHeight, float inRadius, int inRemap, GF_OPENCL_SHARED_DYNAMIC(float, smem), GF_OPENCL_CONSTANT(KeyerParams, inParams)) { GF_CUDA_SHARED_DYNAMIC(float, smem); int X = GF_FASTMULTIPLY(BlockID().x, kBoxBlur_ColPerBlock) + ThreadID().x; int Y = GF_FASTMULTIPLY(BlockID().y, kBoxBlur_RowsPerThread); int floor_radius = (int)inRadius; int num_rows = (floor_radius << 1) + 3; float floor_sz = (float)(floor_radius << 1) + 1.0f; float ciel_sz = floor_sz + 2.0f; floor_sz *= floor_sz; ciel_sz *= ciel_sz; GF_SHARED_PTR(float) col_sum_floor = smem + GF_FASTMULTIPLY(kBoxBlur_BlockWidth,num_rows); GF_SHARED_PTR(float) col_sum_ciel = col_sum_floor + kBoxBlur_BlockWidth; int gmem_row = Y - floor_radius - 1; int gmem_col = clamp(X-16,0,inWidth-1); int smem_idx = ThreadID().x; for(int i=0;i<num_rows; i++) { smem[smem_idx] = ReadPixel(ioImage, inPitch, inDeviceFormat, gmem_col, clamp(gmem_row,0,inHeight-1)).w; smem_idx += kBoxBlur_BlockWidth; gmem_row++; } float sum = 0; smem_idx = kBoxBlur_BlockWidth + ThreadID().x; for(int i=1;i<num_rows-1;i++) { sum += smem[smem_idx]; smem_idx += kBoxBlur_BlockWidth; } col_sum_floor[ThreadID().x] = sum; col_sum_ciel[ThreadID().x] = sum + smem[smem_idx] + smem[ThreadID().x]; SyncThreads(); int first_smem_row = 0; for(int i=0;i<kBoxBlur_RowsPerThread;i++) { if(Y >= inHeight) break; if(ThreadID().x < kBoxBlur_ColPerBlock && X < inWidth) { float sum_floor = 0; float sum_ciel = 0; int startcol = ThreadID().x + 16 - floor_radius; for(smem_idx = startcol;smem_idx <= startcol + (floor_radius<<1); smem_idx++) { sum_floor += col_sum_floor[smem_idx]; sum_ciel += col_sum_ciel[smem_idx]; } sum_ciel += col_sum_ciel[startcol - 1] + col_sum_ciel[startcol + (floor_radius<<1) + 1]; float alpha = inRadius - (float)floor_radius; float da = alpha * (sum_ciel/ciel_sz) + (1.0f-alpha) * (sum_floor/floor_sz); if(inRemap) { da = saturate(da*GF_GET_CONSTANT(inParams)->remapA + GF_GET_CONSTANT(inParams)->remapB); } WriteAlpha(ioImage, GF_FASTMULTIPLY(Y, inPitch) + X, da, inDeviceFormat); } SyncThreads(); smem_idx = GF_FASTMULTIPLY(Roll(first_smem_row+1,num_rows),kBoxBlur_BlockWidth) + ThreadID().x; col_sum_floor[ThreadID().x] -= smem[smem_idx]; smem_idx = GF_FASTMULTIPLY(first_smem_row,kBoxBlur_BlockWidth) + ThreadID().x; col_sum_ciel[ThreadID().x] -= smem[smem_idx]; smem[smem_idx] = ReadPixel(ioImage, inPitch, inDeviceFormat, gmem_col, clamp(gmem_row,0,inHeight-1)).w; gmem_row++; col_sum_ciel[ThreadID().x] += smem[smem_idx]; smem_idx = GF_FASTMULTIPLY(Roll(first_smem_row+num_rows-1,num_rows),kBoxBlur_BlockWidth) + ThreadID().x; col_sum_floor[ThreadID().x] += smem[smem_idx]; first_smem_row++; first_smem_row = Roll(first_smem_row,num_rows); Y++; SyncThreads(); } } GF_KERNEL cuda_kernel_composite(const GF_PTR(float4) srcFrame, GF_PTR(float4) dstFrame, int width, int height, int srcPitch, int dstPitch, int remap, DevicePixelFormat inDeviceFormat, GF_OPENCL_CONSTANT(KeyerParams, inParams)) { int x = KernelX(); int y = KernelY(); if (x >= width || y >= height) return; float4 pixel = cuda_kernel_keyer(GF_GET_CONSTANT(inParams), ReadPixel(srcFrame, srcPitch, inDeviceFormat, x, y)); if(remap) { pixel.w = saturate(pixel.w*GF_GET_CONSTANT(inParams)->remapA + GF_GET_CONSTANT(inParams)->remapB); } WritePixel(pixel, dstFrame, dstPitch, inDeviceFormat, x, y); } GF_KERNEL cuda_kernel_showAlpha(const GF_PTR(float4) srcFrame, GF_PTR(float4) dstFrame, int width, int height, int srcPitch, int dstPitch, DevicePixelFormat inDeviceFormat) { int x = KernelX(); int y = KernelY(); if (x >= width || y >= height) return; PixelRGB pixel = ReadRGBPixel(srcFrame, srcPitch, inDeviceFormat, x, y); float alpha = saturate(pixel.a); pixel.b = alpha; pixel.g = alpha; pixel.r = alpha; pixel.a = 1.0f; WriteRGBPixel(pixel, dstFrame, dstPitch, inDeviceFormat, x, y); } GF_KERNEL cuda_kernel_showColor(const GF_PTR(float4) srcFrame, GF_PTR(float4) dstFrame, int width, int height, int srcPitch, int dstPitch, DevicePixelFormat inDeviceFormat) { int x = KernelX(); int y = KernelY(); if (x >= width || y >= height) return; PixelRGB pixel = ReadRGBPixel(srcFrame, srcPitch, inDeviceFormat, x, y); float alpha = saturate(pixel.a); pixel.b *= alpha; pixel.g *= alpha; pixel.r *= alpha; pixel.a = 1.0f; WriteRGBPixel(pixel, dstFrame, dstPitch, inDeviceFormat, x, y); }


// buildOptions=-cl-single-precision-constant -cl-fast-relaxed-math -cl-denorms-are-zero -cl-mad-enable -D GF_OPENCL_SUPPORTS_16F
// RUN: %occ-cli %s --cl-options="-I%cwd -I%S -cl-single-precision-constant -cl-fast-relaxed-math -cl-denorms-are-zero -cl-mad-enable -D GF_OPENCL_SUPPORTS_16F" %cfg_path --cl-device=%cl_device 2>&1
