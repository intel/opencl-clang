
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
GF_KERNEL debug_copy_normalized_packed_float_array_to_float4_image_kernel( GF_PTR(float4) d_img_out, int img_out_pitch, GF_PTR(float) d_normalized_packed_float_array_in, int array_in_pitch, int inSrcWidth, int inSrcHeight, int inDestWidth, int inDestHeight, int inDestXOffset, int inDestYOffset) { int id_x = KernelX(); int id_y = KernelY(); int dest_x = id_x + inDestXOffset; int dest_y = id_y + inDestYOffset; if (id_x < inSrcWidth && id_y < inSrcHeight && dest_x >= 0 && dest_x < inDestWidth && dest_y >= 0 && dest_y < inDestHeight) { float normalized_value = d_normalized_packed_float_array_in[id_y * array_in_pitch + id_x]; if (normalized_value > 1.f) { normalized_value = 1.f; } else if (normalized_value < 0.f) { normalized_value = 0.f; } float value = normalized_value * 255.f; float4 pix = { value, value, value, 255.f }; d_img_out[dest_y * img_out_pitch + dest_x] = pix; } } GF_KERNEL debug_copy_normalized_packed_float2_uvarray_to_float4_image_kernel( GF_PTR(float4) d_img_out, int img_out_pitch, GF_PTR(float2) d_normalized_packed_float2_uvarray_in, int uvarray_in_pitch, int inSrcWidth, int inSrcHeight, int inDestWidth, int inDestHeight, int inDestXOffset, int inDestYOffset, int u_not_v) { int id_x = KernelX(); int id_y = KernelY(); int dest_x = id_x + inDestXOffset; int dest_y = id_y + inDestYOffset; if (id_x < inSrcWidth && id_y < inSrcHeight && dest_x >= 0 && dest_x < inDestWidth && dest_y >= 0 && dest_y < inDestHeight) { float2 uvvalue = d_normalized_packed_float2_uvarray_in[id_y * uvarray_in_pitch + id_x]; float normalized_value; if (u_not_v) { normalized_value = uvvalue.x; } else { normalized_value = uvvalue.y; } if (normalized_value > 1.f) { normalized_value = 1.f; } else if (normalized_value < 0.f) { normalized_value = 0.f; } float value = normalized_value * 255.f; float4 pix = { value, value, value, 255.f }; d_img_out[dest_y * img_out_pitch + dest_x] = pix; } } GF_KERNEL debug_copy_normalized_float4_image_to_float4_image_kernel( GF_PTR(float4) d_img_out, int img_out_pitch, GF_PTR(float4) d_normalized_img_in, int img_in_pitch, int inSrcWidth, int inSrcHeight, int inDestWidth, int inDestHeight, int inDestXOffset, int inDestYOffset) { int id_x = KernelX(); int id_y = KernelY(); int dest_x = id_x + inDestXOffset; int dest_y = id_y + inDestYOffset; if (id_x < inSrcWidth && id_y < inSrcHeight && dest_x >= 0 && dest_x < inDestWidth && dest_y >= 0 && dest_y < inDestHeight) { float4 normalized_value = d_normalized_img_in[id_y * img_in_pitch + id_x]; if (normalized_value.x > 1.f) { normalized_value.x = 1.f; } else if (normalized_value.x < 0.f) { normalized_value.x = 0.f; } if (normalized_value.y > 1.f) { normalized_value.y = 1.f; } else if (normalized_value.y < 0.f) { normalized_value.y = 0.f; } if (normalized_value.z > 1.f) { normalized_value.z = 1.f; } else if (normalized_value.z < 0.f) { normalized_value.z = 0.f; } float4 value; value.x = normalized_value.x * 255.f; value.y = normalized_value.y * 255.f; value.z = normalized_value.z * 255.f; value.w = 255.f; d_img_out[dest_y * img_out_pitch + dest_x] = value; } }


// buildOptions=-cl-single-precision-constant -cl-fast-relaxed-math -cl-denorms-are-zero -cl-mad-enable -D GF_OPENCL_SUPPORTS_16F
// RUN: %occ-cli %s --cl-options="-I%cwd -I%S -cl-single-precision-constant -cl-fast-relaxed-math -cl-denorms-are-zero -cl-mad-enable -D GF_OPENCL_SUPPORTS_16F" %cfg_path --cl-device=%cl_device 2>&1
