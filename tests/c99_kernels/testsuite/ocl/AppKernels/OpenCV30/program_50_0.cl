#ifdef DOUBLE_SUPPORT
#ifdef cl_amd_fp64
#pragma OPENCL EXTENSION cl_amd_fp64:enable
#elif defined (cl_khr_fp64)
#pragma OPENCL EXTENSION cl_khr_fp64:enable
#endif
#endif
__kernel void blendLinear(__global const T * src1, int src1_offset, int src1_step,
__global const T * src2, int src2_offset, int src2_step,
__global const float * weight1, int weight1_offset, int weight1_step,
__global const float * weight2, int weight2_offset, int weight2_step,
__global T * dst, int dst_offset, int dst_step,
int rows, int cols)
{
int x = get_global_id(0);
int y = get_global_id(1);
if (x < cols && y < rows)
{
int src1_index = mad24(y, src1_step, src1_offset + x);
int src2_index = mad24(y, src2_step, src2_offset + x);
int weight1_index = mad24(y, weight1_step, weight1_offset + x);
int weight2_index = mad24(y, weight2_step, weight2_offset + x);
int dst_index = mad24(y, dst_step, dst_offset + x);
FT w1 = (FT)(weight1[weight1_index]), w2 = (FT)(weight2[weight2_index]);
FT den = w1 + w2 + (FT)(1e-5f);
FT num = w1 * convertToFT(src1[src1_index]) + w2 * convertToFT(src2[src2_index]);
dst[dst_index] = convertToT(num / den);
}
}


// buildOptions= -D INTEL_DEVICE -D T=uchar -D convertToT=convert_uchar_sat_rte -D FT=float -D convertToFT=convert_float
// RUN: %occ-cli %s --cl-options="-I%cwd -I%S  -D INTEL_DEVICE -D T=uchar -D convertToT=convert_uchar_sat_rte -D FT=float -D convertToFT=convert_float" %cfg_path --cl-device=%cl_device 2>&1
