#ifdef DOUBLE_SUPPORT
#ifdef cl_amd_fp64
#pragma OPENCL EXTENSION cl_amd_fp64:enable
#elif defined (cl_khr_fp64)
#pragma OPENCL EXTENSION cl_khr_fp64:enable
#endif
#define CV_PI M_PI
#else
#define CV_PI M_PI_F
#endif
__kernel void arithm_cartToPolar_D5 (__global float *src1, int src1_step, int src1_offset,
__global float *src2, int src2_step, int src2_offset,
__global float *dst1, int dst1_step, int dst1_offset,
__global float *dst2, int dst2_step, int dst2_offset,
int rows, int cols)
{
int x = get_global_id(0);
int y = get_global_id(1);
if (x < cols && y < rows)
{
int src1_index = mad24(y, src1_step, x + src1_offset);
int src2_index = mad24(y, src2_step, x + src2_offset);
int dst1_index = mad24(y, dst1_step, x + dst1_offset);
int dst2_index = mad24(y, dst2_step, x + dst2_offset);
float x = src1[src1_index];
float y = src2[src2_index];
float x2 = x * x;
float y2 = y * y;
float magnitude = sqrt(x2 + y2);
float tmp = y >= 0 ? 0 : CV_PI*2;
tmp = x < 0 ? CV_PI : tmp;
float tmp1 = y >= 0 ? CV_PI*0.5f : CV_PI*1.5f;
float cartToPolar = y2 <= x2 ? x*y/(x2 + 0.28f*y2 + FLT_EPSILON) + tmp :
tmp1 - x*y/(y2 + 0.28f*x2 + FLT_EPSILON);
#ifdef DEGREE
cartToPolar *= (180/CV_PI);
#endif
dst1[dst1_index] = magnitude;
dst2[dst2_index] = cartToPolar;
}
}
#if defined (DOUBLE_SUPPORT)
__kernel void arithm_cartToPolar_D6 (__global double *src1, int src1_step, int src1_offset,
__global double *src2, int src2_step, int src2_offset,
__global double *dst1, int dst1_step, int dst1_offset,
__global double *dst2, int dst2_step, int dst2_offset,
int rows, int cols)
{
int x = get_global_id(0);
int y = get_global_id(1);
if (x < cols && y < rows)
{
int src1_index = mad24(y, src1_step, x + src1_offset);
int src2_index = mad24(y, src2_step, x + src2_offset);
int dst1_index = mad24(y, dst1_step, x + dst1_offset);
int dst2_index = mad24(y, dst2_step, x + dst2_offset);
double x = src1[src1_index];
double y = src2[src2_index];
double x2 = x * x;
double y2 = y * y;
double magnitude = sqrt(x2 + y2);
float tmp = y >= 0 ? 0 : CV_PI*2;
tmp = x < 0 ? CV_PI : tmp;
float tmp1 = y >= 0 ? CV_PI*0.5 : CV_PI*1.5;
double cartToPolar = y2 <= x2 ? x*y/(x2 + 0.28f*y2 + DBL_EPSILON)  + tmp :
tmp1 - x*y/(y2 + 0.28f*x2 + DBL_EPSILON);
#ifdef DEGREE
cartToPolar *= (180/CV_PI);
#endif
dst1[dst1_index] = magnitude;
dst2[dst2_index] = cartToPolar;
}
}
#endif


// buildOptions= -D INTEL_DEVICE -D RADIAN
// RUN: %occ-cli %s --cl-options="-I%cwd -I%S  -D INTEL_DEVICE -D RADIAN" %cfg_path --cl-device=%cl_device 2>&1
