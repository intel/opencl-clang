
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

#define V_BLOCK_W 16

#define V_BLOCK_H 4

#define V_TILE_SZ (V_BLOCK_W * V_BLOCK_H)

#define H_BLOCK_W 16

#define H_BLOCK_H 4

#define H_READS (8 / H_BLOCK_H)

#define H_TILE_W (H_BLOCK_W+1)

#define H_TILE_H 8

#define H_TILE_SZ (H_TILE_H * H_TILE_W)
 GF_DEVICE_FUNCTION float4 ReadFloat4Pixel( const GF_PTR(float4) inImage, DevicePixelFormat inDeviceFormat, int inIndex) { return inImage[inIndex]; } GF_DEVICE_FUNCTION void WriteFloat4Pixel( float4 inPixel, DevicePixelFormat inDeviceFormat, GF_PTR(float4) inImage, int inIndex) { inImage[inIndex] = inPixel; }GF_DEVICE_FUNCTION float4 PremultiplyLinearize(float4 inPix) { return ConvertRGB_To_Components( PremultiplyLinearizePixel( ConvertComponents_To_RGB(inPix))); } GF_DEVICE_FUNCTION float4 UnpremultiplyUnlinearize(float4 inPix) { return ConvertRGB_To_Components( UnpremultiplyUnlinearizePixel( ConvertComponents_To_RGB(inPix))); } GF_DEVICE_FUNCTION void VerticalRecursiveGaussian( GF_SHARED_PTR(float) smem, const GF_PTR(float4) pIn, int src_pitch, int src_width, int src_height, GF_PTR(float4) pOut, int dest_pitch, int dest_width, int dest_height, DevicePixelFormat inDeviceFormat, int repeat_edge_pixels, float n_plus0, float n_plus1, float neg_d_plus1, float neg_d_plus2, float n_minus1, float n_minus2, float neg_d_minus1, float neg_d_minus2) { float4 temp; int destX = GF_FASTMULTIPLY(BlockSize().x, BlockID().x) + ThreadID().x; int destY = ThreadID().y; int blockY = 0; int srcX = destX - ((dest_width - src_width) >> 1); int srcY = destY - ((dest_height - src_height) >> 1); if( destX >= dest_width) return; int src_gmem_idx; int dest_gmem_idx; int smem_idx; float new_in; float prev_in = 0; float prev_in2 = 0; float prev_out = 0; float prev_out2 = 0; float result; src_gmem_idx = srcY * src_pitch + srcX; dest_gmem_idx = destY * dest_pitch + destX; while(blockY < dest_height) { smem_idx = GF_FASTMULTIPLY(ThreadID().y, V_BLOCK_W) + ThreadID().x; if(0 <= srcY && srcY < src_height && 0 <= srcX && srcX < src_width) temp = PremultiplyLinearize(ReadFloat4Pixel(pIn, inDeviceFormat, src_gmem_idx)); else temp = make_float4(0,0,0,0); smem[smem_idx] = temp.x; smem[smem_idx + V_TILE_SZ] = temp.y; smem[smem_idx + (2*V_TILE_SZ)] = temp.z; smem[smem_idx + (3*V_TILE_SZ)] = temp.w; SyncThreads(); smem_idx = GF_FASTMULTIPLY(ThreadID().y, V_TILE_SZ) + ThreadID().x; for(int i=0;i<V_BLOCK_H;i++) { new_in = smem[smem_idx]; if (blockY+i == 0 && repeat_edge_pixels) { prev_out = prev_out2 = new_in * 0.5f; } result = n_plus0*new_in + n_plus1*prev_in + neg_d_plus1*prev_out + neg_d_plus2*prev_out2; prev_in = new_in; prev_out2 = prev_out; prev_out = result; smem[smem_idx] = result; smem_idx += V_BLOCK_W ; } SyncThreads(); smem_idx = GF_FASTMULTIPLY(ThreadID().y, V_BLOCK_W) + ThreadID().x; if(destY < dest_height) { temp.x = smem[smem_idx]; temp.y = smem[smem_idx + V_TILE_SZ]; temp.z = smem[smem_idx + (2*V_TILE_SZ)]; temp.w = smem[smem_idx + (3*V_TILE_SZ)]; WriteFloat4Pixel(temp, inDeviceFormat, pOut, dest_gmem_idx); } SyncThreads(); blockY += V_BLOCK_H; srcY += V_BLOCK_H; destY += V_BLOCK_H; src_gmem_idx += (src_pitch << 2); dest_gmem_idx += (dest_pitch << 2); } prev_in = 0; prev_in2 = 0; prev_out = 0; prev_out2 = 0; while(blockY > 0) { blockY -= V_BLOCK_H; srcY -= V_BLOCK_H; destY -= V_BLOCK_H; src_gmem_idx -= (src_pitch << 2); dest_gmem_idx -= (dest_pitch << 2); smem_idx = GF_FASTMULTIPLY(ThreadID().y, V_BLOCK_W) + ThreadID().x; if(0 <= srcY && srcY < src_height && 0 <= srcX && srcX < src_width) temp = PremultiplyLinearize(ReadFloat4Pixel(pIn, inDeviceFormat, src_gmem_idx)); else temp = make_float4(0,0,0,0); smem[smem_idx] = temp.x; smem[smem_idx + V_TILE_SZ] = temp.y; smem[smem_idx + (2*V_TILE_SZ)] = temp.z; smem[smem_idx + (3*V_TILE_SZ)] = temp.w; SyncThreads(); smem_idx = GF_FASTMULTIPLY(ThreadID().y, V_TILE_SZ) + ((V_BLOCK_H-1)*V_BLOCK_W) + ThreadID().x; for(int i=(V_BLOCK_H-1);i>=0;i--) { new_in = smem[smem_idx]; if (blockY+i == dest_height-1 && repeat_edge_pixels) { prev_out = prev_out2 = new_in * 0.5f; } result = n_minus1*prev_in + n_minus2*prev_in2 + neg_d_minus1*prev_out + neg_d_minus2*prev_out2; prev_in2 = prev_in; prev_in = new_in; prev_out2 = prev_out; prev_out = result; smem[smem_idx] = result; smem_idx -= V_BLOCK_W; } SyncThreads(); src_gmem_idx = srcY * src_pitch + srcX; dest_gmem_idx = destY * dest_pitch + destX; smem_idx = GF_FASTMULTIPLY(ThreadID().y, V_BLOCK_W) + ThreadID().x; if(destY < dest_height) { temp = ReadFloat4Pixel(pOut, inDeviceFormat, dest_gmem_idx); temp.x += smem[smem_idx]; temp.y += smem[smem_idx + V_TILE_SZ]; temp.z += smem[smem_idx + (2*V_TILE_SZ)]; temp.w += smem[smem_idx + (3*V_TILE_SZ)]; WriteFloat4Pixel(UnpremultiplyUnlinearize(temp), inDeviceFormat, pOut, dest_gmem_idx); } SyncThreads(); } } GF_DEVICE_FUNCTION void HorizontalRecursiveGaussian( GF_SHARED_PTR(float) smem, const GF_PTR(float4) pIn, int src_pitch, int src_width, int src_height, GF_PTR(float4) pOut, int dest_pitch, int dest_width, int dest_height, DevicePixelFormat inDeviceFormat, int repeat_edge_pixels, float n_plus0, float n_plus1, float neg_d_plus1, float neg_d_plus2, float n_minus1, float n_minus2, float neg_d_minus1, float neg_d_minus2) { int blockX = 0; float4 temp; int src_gmem_idx; int dest_gmem_idx; int smem_idx; float new_in; float prev_in = 0; float prev_in2 = 0; float prev_out = 0; float prev_out2 = 0; float result; int destY = GF_FASTMULTIPLY(BlockID().y, H_TILE_H) + ThreadID().y; int srcY = destY - ((dest_height - src_height) >> 1); const int thread_num = ThreadID().y * H_BLOCK_W + ThreadID().x; int smem_row = (ThreadID().y<<4) + ThreadID().x; while(blockX < dest_width) { int destX = blockX + ThreadID().x; int srcX = destX - ((dest_width - src_width) >> 1); src_gmem_idx = srcY * src_pitch + srcX; dest_gmem_idx = destY * dest_pitch + destX; smem_idx = GF_FASTMULTIPLY(ThreadID().y, H_TILE_W) + ThreadID().x; for(int i=0;i<H_READS;i++) { if(srcY + (i*H_BLOCK_H) < src_height) { if(0 <= srcY && srcY < src_height && 0 <= srcX && srcX < src_width) temp = PremultiplyLinearize(ReadFloat4Pixel(pIn, inDeviceFormat, src_gmem_idx)); else temp = make_float4(0,0,0,0); smem[smem_idx] = temp.x; smem[smem_idx + H_TILE_SZ] = temp.y; smem[smem_idx + (2*H_TILE_SZ)] = temp.z; smem[smem_idx + (3*H_TILE_SZ)] = temp.w; } src_gmem_idx += H_BLOCK_H * src_pitch; dest_gmem_idx += H_BLOCK_H * dest_pitch; smem_idx += H_BLOCK_H * H_TILE_W; } SyncThreads(); if(thread_num < 32) { smem_idx = GF_FASTMULTIPLY(smem_row, H_TILE_W); for(int i=0;i<H_BLOCK_W;i++) { new_in = smem[smem_idx]; if (blockX+i == 0 && repeat_edge_pixels) { prev_out = prev_out2 = new_in * 0.5f; } result = n_plus0*new_in + n_plus1*prev_in + neg_d_plus1*prev_out + neg_d_plus2*prev_out2; prev_in = new_in; prev_out2 = prev_out; prev_out = result; smem[smem_idx] = result; smem_idx++; } } SyncThreads(); src_gmem_idx = srcY * src_pitch + srcX; dest_gmem_idx = destY * dest_pitch + destX; smem_idx = GF_FASTMULTIPLY(ThreadID().y, H_TILE_W) + ThreadID().x; for(int i=0;i<H_READS;i++) { if(srcY + (i*H_BLOCK_H) < src_height) { temp.x = smem[smem_idx]; temp.y = smem[smem_idx + H_TILE_SZ]; temp.z = smem[smem_idx + (2*H_TILE_SZ)]; temp.w = smem[smem_idx + (3*H_TILE_SZ)]; if(destX < dest_width) WriteFloat4Pixel(temp, inDeviceFormat, pOut, dest_gmem_idx); } src_gmem_idx += src_pitch * H_BLOCK_H; dest_gmem_idx += dest_pitch * H_BLOCK_H; smem_idx += H_BLOCK_H * H_TILE_W; } SyncThreads(); blockX += H_BLOCK_W; } prev_in = 0; prev_in2 = 0; prev_out = 0; prev_out2 = 0; while(blockX > 0) { blockX -= H_BLOCK_W; int destX = blockX + ThreadID().x; int srcX = destX - ((dest_width - src_width) >> 1); src_gmem_idx = srcY * src_pitch + srcX; dest_gmem_idx = destY * dest_pitch + destX; smem_idx = GF_FASTMULTIPLY(ThreadID().y, H_TILE_W) + ThreadID().x; for(int i=0;i<H_READS;i++) { if(srcY + (i*H_BLOCK_H) < src_height) { if(0 <= srcY && srcY < src_height && 0 <= srcX && srcX < src_width) temp = PremultiplyLinearize(ReadFloat4Pixel(pIn, inDeviceFormat, src_gmem_idx)); else temp = make_float4(0,0,0,0); smem[smem_idx] = temp.x; smem[smem_idx + H_TILE_SZ] = temp.y; smem[smem_idx + (2*H_TILE_SZ)] = temp.z; smem[smem_idx + (3*H_TILE_SZ)] = temp.w; } src_gmem_idx += src_pitch * H_BLOCK_H; dest_gmem_idx += dest_pitch * H_BLOCK_H; smem_idx += H_BLOCK_H * H_TILE_W; } SyncThreads(); if(thread_num < 32) { smem_idx = GF_FASTMULTIPLY(smem_row, H_TILE_W) + H_BLOCK_W - 1; for(int i=H_BLOCK_W-1;i>=0;i--) { new_in = smem[smem_idx]; if (blockX+i == dest_width-1 && repeat_edge_pixels) { prev_out = prev_out2 = new_in * 0.5f; } result = n_minus1*prev_in + n_minus2*prev_in2 + neg_d_minus1*prev_out + neg_d_minus2*prev_out2; prev_in2 = prev_in; prev_in = new_in; prev_out2 = prev_out; prev_out = result; smem[smem_idx] = result; smem_idx--; } } SyncThreads(); src_gmem_idx = srcY * src_pitch + srcX; dest_gmem_idx = destY * dest_pitch + destX; smem_idx = GF_FASTMULTIPLY(ThreadID().y, H_TILE_W) + ThreadID().x; for(int i=0;i<H_READS;i++) { if(destY + (i * H_BLOCK_H) < dest_height) { if(destX < dest_width) { temp = ReadFloat4Pixel(pOut, inDeviceFormat, dest_gmem_idx); temp.x += smem[smem_idx]; temp.y += smem[smem_idx + H_TILE_SZ]; temp.z += smem[smem_idx + (2*H_TILE_SZ)] ; temp.w += smem[smem_idx + (3*H_TILE_SZ)]; WriteFloat4Pixel(UnpremultiplyUnlinearize(temp), inDeviceFormat, pOut, dest_gmem_idx); } } src_gmem_idx += src_pitch * H_BLOCK_H; dest_gmem_idx += dest_pitch * H_BLOCK_H; smem_idx += H_BLOCK_H * H_TILE_W; } SyncThreads(); } } GF_KERNEL VerticalRecursiveGaussianRGBAF16_kernel( const GF_PTR(float4) pIn, int src_pitch, int src_width, int src_height, GF_PTR(float4) pOut, int dest_pitch, int dest_width, int dest_height, int repeat_edge_pixels, float n_plus0, float n_plus1, float neg_d_plus1, float neg_d_plus2, float n_minus1, float n_minus2, float neg_d_minus1, float neg_d_minus2) { GF_SHARED(float) smem[V_TILE_SZ * 4]; VerticalRecursiveGaussian( smem, pIn, src_pitch, src_width, src_height, pOut, dest_pitch, dest_width, dest_height, kDevicePixelFormat_BGRA_4444_16f, repeat_edge_pixels, n_plus0, n_plus1, neg_d_plus1, neg_d_plus2, n_minus1, n_minus2, neg_d_minus1, neg_d_minus2); } GF_KERNEL VerticalRecursiveGaussianRGBAF32_kernel( const GF_PTR(float4) pIn, int src_pitch, int src_width, int src_height, GF_PTR(float4) pOut, int dest_pitch, int dest_width, int dest_height, int repeat_edge_pixels, float n_plus0, float n_plus1, float neg_d_plus1, float neg_d_plus2, float n_minus1, float n_minus2, float neg_d_minus1, float neg_d_minus2) { GF_SHARED(float) smem[V_TILE_SZ * 4]; VerticalRecursiveGaussian( smem, pIn, src_pitch, src_width, src_height, pOut, dest_pitch, dest_width, dest_height, kDevicePixelFormat_BGRA_4444_32f, repeat_edge_pixels, n_plus0, n_plus1, neg_d_plus1, neg_d_plus2, n_minus1, n_minus2, neg_d_minus1, neg_d_minus2); } GF_KERNEL HorizontalRecursiveGaussianRGBAF16_kernel( const GF_PTR(float4) pIn, int src_pitch, int src_width, int src_height, GF_PTR(float4) pOut, int dest_pitch, int dest_width, int dest_height, int repeat_edge_pixels, float n_plus0, float n_plus1, float neg_d_plus1, float neg_d_plus2, float n_minus1, float n_minus2, float neg_d_minus1, float neg_d_minus2) { GF_SHARED(float) smem[H_TILE_SZ * 4]; HorizontalRecursiveGaussian( smem, pIn, src_pitch, src_width, src_height, pOut, dest_pitch, dest_width, dest_height, kDevicePixelFormat_BGRA_4444_16f, repeat_edge_pixels, n_plus0, n_plus1, neg_d_plus1, neg_d_plus2, n_minus1, n_minus2, neg_d_minus1, neg_d_minus2); } GF_KERNEL HorizontalRecursiveGaussianRGBAF32_kernel( const GF_PTR(float4) pIn, int src_pitch, int src_width, int src_height, GF_PTR(float4) pOut, int dest_pitch, int dest_width, int dest_height, int repeat_edge_pixels, float n_plus0, float n_plus1, float neg_d_plus1, float neg_d_plus2, float n_minus1, float n_minus2, float neg_d_minus1, float neg_d_minus2) { GF_SHARED(float) smem[H_TILE_SZ * 4]; HorizontalRecursiveGaussian( smem, pIn, src_pitch, src_width, src_height, pOut, dest_pitch, dest_width, dest_height, kDevicePixelFormat_BGRA_4444_32f, repeat_edge_pixels, n_plus0, n_plus1, neg_d_plus1, neg_d_plus2, n_minus1, n_minus2, neg_d_minus1, neg_d_minus2); }

// buildOptions= -cl-single-precision-constant -cl-fast-relaxed-math
// RUN: %occ-cli %s --cl-options="-I%cwd -I%S  -cl-single-precision-constant -cl-fast-relaxed-math" %cfg_path --cl-device=%cl_device 2>&1
