#ifdef DOUBLE_SUPPORT
#ifdef cl_amd_fp64
#pragma OPENCL EXTENSION cl_amd_fp64:enable
#elif defined (cl_khr_fp64)
#pragma OPENCL EXTENSION cl_khr_fp64:enable
#endif
#define CV_PI M_PI
#define CV_2PI (2 * CV_PI)
#else
#define CV_PI M_PI_F
#define CV_2PI (2 * CV_PI)
#endif
__kernel void arithm_phase_inradians_D5(__global float *src1, int src1_step1, int src1_offset1,
__global float *src2, int src2_step1, int src2_offset1,
__global float *dst,  int dst_step1,  int dst_offset1,
int cols, int rows)
{
int x = get_global_id(0);
int y = get_global_id(1);
if (x < cols && y < rows)
{
int src1_index = mad24(y, src1_step1, x + src1_offset1);
int src2_index = mad24(y, src2_step1, x + src2_offset1);
int dst_index  = mad24(y, dst_step1, x + dst_offset1);
float data1 = src1[src1_index];
float data2 = src2[src2_index];
float tmp = atan2(data2, data1);
if (tmp < 0)
tmp += CV_2PI;
dst[dst_index] = tmp;
}
}
#if defined (DOUBLE_SUPPORT)
__kernel void arithm_phase_inradians_D6(__global double *src1, int src1_step1, int src1_offset1,
__global double *src2, int src2_step1, int src2_offset1,
__global double *dst,  int dst_step1,  int dst_offset1,
int cols, int rows)
{
int x = get_global_id(0);
int y = get_global_id(1);
if (x < cols && y < rows)
{
int src1_index = mad24(y, src1_step1, x + src1_offset1);
int src2_index = mad24(y, src2_step1, x + src2_offset1);
int dst_index  = mad24(y, dst_step1, x + dst_offset1);
double data1 = src1[src1_index];
double data2 = src2[src2_index];
double tmp = atan2(data2, data1);
if (tmp < 0)
tmp += CV_2PI;
dst[dst_index] = tmp;
}
}
#endif
__kernel void arithm_phase_indegrees_D5(__global float *src1, int src1_step1, int src1_offset1,
__global float *src2, int src2_step1, int src2_offset1,
__global float *dst,  int dst_step1,  int dst_offset1,
int cols, int rows)
{
int x = get_global_id(0);
int y = get_global_id(1);
if (x < cols && y < rows)
{
int src1_index = mad24(y, src1_step1, x + src1_offset1);
int src2_index = mad24(y, src2_step1, x + src2_offset1);
int dst_index  = mad24(y, dst_step1, x + dst_offset1);
float data1 = src1[src1_index];
float data2 = src2[src2_index];
float tmp = atan2(data2, data1);
tmp = 180 * tmp / CV_PI;
if (tmp < 0)
tmp += 360;
dst[dst_index] = tmp;
}
}
#if defined (DOUBLE_SUPPORT)
__kernel void arithm_phase_indegrees_D6 (__global double *src1, int src1_step1, int src1_offset1,
__global double *src2, int src2_step1, int src2_offset1,
__global double *dst,  int dst_step1,  int dst_offset1,
int cols, int rows)
{
int x = get_global_id(0);
int y = get_global_id(1);
if (x < cols && y < rows)
{
int src1_index = mad24(y, src1_step1, x + src1_offset1);
int src2_index = mad24(y, src2_step1, x + src2_offset1);
int dst_index  = mad24(y, dst_step1, x + dst_offset1);
double data1 = src1[src1_index];
double data2 = src2[src2_index];
double tmp = atan2(data2, data1);
tmp = 180 * tmp / CV_PI;
if (tmp < 0)
tmp += 360;
dst[dst_index] = tmp;
}
}
#endif


// buildOptions= -D INTEL_DEVICE
// RUN: %occ-cli %s --cl-options="-I%cwd -I%S  -D INTEL_DEVICE" %cfg_path --cl-device=%cl_device 2>&1
