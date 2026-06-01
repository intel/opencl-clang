#ifdef DOUBLE_SUPPORT
#ifdef cl_amd_fp64
#pragma OPENCL EXTENSION cl_amd_fp64:enable
#elif defined (cl_khr_fp64)
#pragma OPENCL EXTENSION cl_khr_fp64:enable
#endif
#endif
#if defined (FUNC_ADD)
#define EXPRESSION dst[dst_index] = convertToT(convertToWT(src1[src1_index]) + convertToWT(src2[src2_index]));
#endif
#if defined (FUNC_SUB)
#define EXPRESSION dst[dst_index] = convertToT(convertToWT(src1[src1_index]) - convertToWT(src2[src2_index]));
#endif
#if defined (FUNC_MUL)
#if defined (HAVE_SCALAR)
#define EXPRESSION dst[dst_index] = convertToT(convertToWT(src1[src1_index]) * scalar * convertToWT(src2[src2_index]));
#else
#define EXPRESSION dst[dst_index] = convertToT(convertToWT(src1[src1_index]) * convertToWT(src2[src2_index]));
#endif
#endif
#if defined (FUNC_DIV)
#if defined (HAVE_SCALAR)
#define EXPRESSION T zero = (T)(0); \
dst[dst_index] = src2[src2_index] == zero ? zero : \
convertToT(convertToWT(src1[src1_index]) * scalar / convertToWT(src2[src2_index]));
#else
#define EXPRESSION T zero = (T)(0); \
dst[dst_index] = src2[src2_index] == zero ? zero : \
convertToT(convertToWT(src1[src1_index]) / convertToWT(src2[src2_index]));
#endif
#endif
#if defined (FUNC_ABS_DIFF)
#define EXPRESSION WT value = convertToWT(src1[src1_index]) - convertToWT(src2[src2_index]); \
value = value > (WT)(0) ? value : -value; \
dst[dst_index] = convertToT(value);
#endif
#if defined (FUNC_MIN)
#define EXPRESSION dst[dst_index] = min( src1[src1_index], src2[src2_index] );
#endif
#if defined (FUNC_MAX)
#define EXPRESSION dst[dst_index] = max( src1[src1_index], src2[src2_index] );
#endif
#ifndef HAVE_SCALAR
__kernel void arithm_binary_op_mat(__global T *src1, int src1_step, int src1_offset,
__global T *src2, int src2_step, int src2_offset,
__global T *dst, int dst_step, int dst_offset,
int cols, int rows)
{
int x = get_global_id(0);
int y = get_global_id(1);
if (x < cols && y < rows)
{
int src1_index = mad24(y, src1_step, x + src1_offset);
int src2_index = mad24(y, src2_step, x + src2_offset);
int dst_index  = mad24(y, dst_step, x + dst_offset);
EXPRESSION
}
}
#else
__kernel void arithm_binary_op_mat_scalar(__global T *src1, int src1_step, int src1_offset,
__global T *src2, int src2_step, int src2_offset,
WT scalar,
__global T *dst, int dst_step,  int dst_offset,
int cols, int rows)
{
int x = get_global_id(0);
int y = get_global_id(1);
if (x < cols && y < rows)
{
int src1_index = mad24(y, src1_step, x + src1_offset);
int src2_index = mad24(y, src2_step, x + src2_offset);
int dst_index = mad24(y, dst_step, x + dst_offset);
EXPRESSION
}
}
#endif


// buildOptions= -D INTEL_DEVICE -D T=uchar -D WT=short -D convertToT=convert_uchar_sat_rte -D FUNC_MIN -D convertToWT=convert_short
// RUN: %occ-cli %s --cl-options="-I%cwd -I%S  -D INTEL_DEVICE -D T=uchar -D WT=short -D convertToT=convert_uchar_sat_rte -D FUNC_MIN -D convertToWT=convert_short" %cfg_path --cl-device=%cl_device 2>&1
