#ifdef DOUBLE_SUPPORT
#ifdef cl_amd_fp64
#pragma OPENCL EXTENSION cl_amd_fp64:enable
#elif defined (cl_khr_fp64)
#pragma OPENCL EXTENSION cl_khr_fp64:enable
#endif
#endif
#define noconvert
__kernel void blendLinear(__global const uchar * src1ptr, int src1_step, int src1_offset,
__global const uchar * src2ptr, int src2_step, int src2_offset,
__global const uchar * weight1, int weight1_step, int weight1_offset,
__global const uchar * weight2, int weight2_step, int weight2_offset,
__global uchar * dstptr, int dst_step, int dst_offset, int dst_rows, int dst_cols)
{
int x = get_global_id(0);
int y = get_global_id(1);
if (x < dst_cols && y < dst_rows)
{
int src1_index = mad24(y, src1_step, src1_offset + x * cn * (int)sizeof(T));
int src2_index = mad24(y, src2_step, src2_offset + x * cn * (int)sizeof(T));
int weight1_index = mad24(y, weight1_step, weight1_offset + x * (int)sizeof(float));
int weight2_index = mad24(y, weight2_step, weight2_offset + x * (int)sizeof(float));
int dst_index = mad24(y, dst_step, dst_offset + x * cn * (int)sizeof(T));
float w1 = *(__global const float *)(weight1 + weight1_index),
w2 = *(__global const float *)(weight2 + weight2_index);
float den = w1 + w2 + 1e-5f;
__global const T * src1 = (__global const T *)(src1ptr + src1_index);
__global const T * src2 = (__global const T *)(src2ptr + src2_index);
__global T * dst = (__global T *)(dstptr + dst_index);
#pragma unroll
for (int i = 0; i < cn; ++i)
{
float num = w1 * convert_float(src1[i]) + w2 * convert_float(src2[i]);
dst[i] = convertToT(num / den);
}
}
}


// buildOptions=-D T=float -D cn=3 -D convertToT=noconvert -D INTEL_DEVICE
// RUN: %occ-cli %s --cl-options="-I%cwd -I%S -D T=float -D cn=3 -D convertToT=noconvert -D INTEL_DEVICE" %cfg_path --cl-device=%cl_device 2>&1
