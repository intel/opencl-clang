#ifdef DOUBLE_SUPPORT
#ifdef cl_amd_fp64
#pragma OPENCL EXTENSION cl_amd_fp64:enable
#elif defined (cl_khr_fp64)
#pragma OPENCL EXTENSION cl_khr_fp64:enable
#endif
#endif
#if defined (FUNC_ADD)
#define EXPRESSION dst[dst_index] = convertToT(convertToWT(src1[src1_index]) + scalar);
#endif
#if defined (FUNC_SUB)
#define EXPRESSION dst[dst_index] = convertToT(convertToWT(src1[src1_index]) - scalar);
#endif
#if defined (FUNC_MUL)
#define EXPRESSION dst[dst_index] = convertToT(convertToWT(src1[src1_index]) * scalar);
#endif
#if defined (FUNC_DIV)
#define EXPRESSION T zero = (T)(0); \
dst[dst_index] = src1[src1_index] == zero ? zero : convertToT(scalar / convertToWT(src1[src1_index]));
#endif
#if defined (FUNC_ABS)
#define EXPRESSION \
T value = src1[src1_index] > (T)(0) ? src1[src1_index] : -src1[src1_index]; \
dst[dst_index] = value;
#endif
#if defined (FUNC_ABS_DIFF)
#define EXPRESSION WT value = convertToWT(src1[src1_index]) - scalar; \
value = value > (WT)(0) ? value : -value; \
dst[dst_index] = convertToT(value);
#endif
__kernel void arithm_binary_op_scalar (__global T *src1, int src1_step, int src1_offset,
WT scalar,
__global T *dst,  int dst_step,  int dst_offset,
int cols, int rows)
{
int x = get_global_id(0);
int y = get_global_id(1);
if (x < cols && y < rows)
{
int src1_index = mad24(y, src1_step, x + src1_offset);
int dst_index = mad24(y, dst_step, x + dst_offset);
EXPRESSION
}
}


// buildOptions= -D INTEL_DEVICE -D T=uchar -D WT=float -D convertToT=convert_uchar_sat_rte -D FUNC_ABS -D convertToWT=convert_float
// RUN: %occ-cli %s --cl-options="-I%cwd -I%S  -D INTEL_DEVICE -D T=uchar -D WT=float -D convertToT=convert_uchar_sat_rte -D FUNC_ABS -D convertToWT=convert_float" %cfg_path --cl-device=%cl_device 2>&1
