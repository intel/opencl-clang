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
__kernel void arithm_polarToCart_mag_D5 (__global float *src1, int src1_step, int src1_offset,
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
#ifdef DEGREE
float ascale = CV_PI/180.0f;
float alpha = y * ascale;
#else
float alpha = y;
#endif
float a = cos(alpha) * x;
float b = sin(alpha) * x;
dst1[dst1_index] = a;
dst2[dst2_index] = b;
}
}
#if defined (DOUBLE_SUPPORT)
__kernel void arithm_polarToCart_mag_D6 (__global double *src1, int src1_step, int src1_offset,
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
#ifdef DEGREE
float ascale = CV_PI/180.0;
float alpha = y * ascale;
#else
float alpha = y;
#endif
double a = cos(alpha) * x;
double b = sin(alpha) * x;
dst1[dst1_index] = a;
dst2[dst2_index] = b;
}
}
#endif
__kernel void arithm_polarToCart_D5 (__global float *src,  int src_step,  int src_offset,
__global float *dst1, int dst1_step, int dst1_offset,
__global float *dst2, int dst2_step, int dst2_offset,
int rows, int cols)
{
int x = get_global_id(0);
int y = get_global_id(1);
if (x < cols && y < rows)
{
int src_index  = mad24(y, src_step,  x + src_offset);
int dst1_index = mad24(y, dst1_step, x + dst1_offset);
int dst2_index = mad24(y, dst2_step, x + dst2_offset);
float y = src[src_index];
#ifdef DEGREE
float ascale = CV_PI/180.0f;
float alpha = y * ascale;
#else
float alpha = y;
#endif
float a = cos(alpha);
float b = sin(alpha);
dst1[dst1_index] = a;
dst2[dst2_index] = b;
}
}
#if defined (DOUBLE_SUPPORT)
__kernel void arithm_polarToCart_D6 (__global float *src,  int src_step,  int src_offset,
__global float *dst1, int dst1_step, int dst1_offset,
__global float *dst2, int dst2_step, int dst2_offset,
int rows, int cols)
{
int x = get_global_id(0);
int y = get_global_id(1);
if (x < cols && y < rows)
{
int src_index  = mad24(y, src_step,  x + src_offset);
int dst1_index = mad24(y, dst1_step, x + dst1_offset);
int dst2_index = mad24(y, dst2_step, x + dst2_offset);
double y = src[src_index];
#ifdef DEGREE
float ascale = CV_PI/180.0f;
float alpha = y * ascale;
#else
float alpha = y;
#endif
double a = cos(alpha);
double b = sin(alpha);
dst1[dst1_index] = a;
dst2[dst2_index] = b;
}
}
#endif


// buildOptions= -D INTEL_DEVICE -D RADIAN
// RUN: %occ-cli %s --cl-options="-I%cwd -I%S  -D INTEL_DEVICE -D RADIAN" %cfg_path --cl-device=%cl_device 2>&1
