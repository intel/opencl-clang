#ifdef DOUBLE_SUPPORT
#ifdef cl_amd_fp64
#pragma OPENCL EXTENSION cl_amd_fp64:enable
#elif defined (cl_khr_fp64)
#pragma OPENCL EXTENSION cl_khr_fp64:enable
#endif
#endif
__kernel void arithm_bitwise_not_D0 (__global uchar *src1, int src1_step, int src1_offset,
__global uchar *dst,  int dst_step,  int dst_offset,
int rows, int cols, int dst_step1)
{
int x = get_global_id(0);
int y = get_global_id(1);
if (x < cols && y < rows)
{
x = x << 2;
int src1_index = mad24(y, src1_step, x + src1_offset);
int dst_end    = mad24(y, dst_step, dst_offset + dst_step1);
int dst_index  = mad24(y, dst_step, dst_offset + x);
uchar4 src1_data = vload4(0, src1 + src1_index);
uchar4 dst_data = vload4(0, dst + dst_index);
uchar4 tmp_data = ~src1_data;
dst_data.x = dst_index + 0 < dst_end ? tmp_data.x : dst_data.x;
dst_data.y = dst_index + 1 < dst_end ? tmp_data.y : dst_data.y;
dst_data.z = dst_index + 2 < dst_end ? tmp_data.z : dst_data.z;
dst_data.w = dst_index + 3 < dst_end ? tmp_data.w : dst_data.w;
vstore4(dst_data, 0, dst + dst_index);
}
}
__kernel void arithm_bitwise_not_D1 (__global char *src1, int src1_step, int src1_offset,
__global char *dst,  int dst_step,  int dst_offset,
int rows, int cols, int dst_step1)
{
int x = get_global_id(0);
int y = get_global_id(1);
if (x < cols && y < rows)
{
x = x << 2;
int src1_index = mad24(y, src1_step, x + src1_offset);
int dst_end    = mad24(y, dst_step, dst_offset + dst_step1);
int dst_index  = mad24(y, dst_step, dst_offset + x);
char4 src1_data = vload4(0, src1 + src1_index);
char4 dst_data = vload4(0, dst + dst_index);
char4 tmp_data = ~src1_data;
dst_data.x = dst_index + 0 < dst_end ? tmp_data.x : dst_data.x;
dst_data.y = dst_index + 1 < dst_end ? tmp_data.y : dst_data.y;
dst_data.z = dst_index + 2 < dst_end ? tmp_data.z : dst_data.z;
dst_data.w = dst_index + 3 < dst_end ? tmp_data.w : dst_data.w;
vstore4(dst_data, 0, dst + dst_index);
}
}
__kernel void arithm_bitwise_not_D2 (__global ushort *src1, int src1_step, int src1_offset,
__global ushort *dst,  int dst_step,  int dst_offset,
int rows, int cols, int dst_step1)
{
int x = get_global_id(0);
int y = get_global_id(1);
if (x < cols && y < rows)
{
x = x << 2;
#ifdef dst_align
#undef dst_align
#endif
#define dst_align ((dst_offset >> 1) & 3)
int src1_index = mad24(y, src1_step, (x << 1) + src1_offset - (dst_align << 1));
int dst_start  = mad24(y, dst_step, dst_offset);
int dst_end    = mad24(y, dst_step, dst_offset + dst_step1);
int dst_index  = mad24(y, dst_step, dst_offset + (x << 1) & (int)0xfffffff8);
ushort4 src1_data = vload4(0, (__global ushort *)((__global char *)src1 + src1_index));
ushort4 dst_data = *((__global ushort4 *)((__global char *)dst + dst_index));
ushort4 tmp_data = ~ src1_data;
dst_data.x = ((dst_index + 0 >= dst_start) && (dst_index + 0 < dst_end)) ? tmp_data.x : dst_data.x;
dst_data.y = ((dst_index + 2 >= dst_start) && (dst_index + 2 < dst_end)) ? tmp_data.y : dst_data.y;
dst_data.z = ((dst_index + 4 >= dst_start) && (dst_index + 4 < dst_end)) ? tmp_data.z : dst_data.z;
dst_data.w = ((dst_index + 6 >= dst_start) && (dst_index + 6 < dst_end)) ? tmp_data.w : dst_data.w;
*((__global ushort4 *)((__global char *)dst + dst_index)) = dst_data;
}
}
__kernel void arithm_bitwise_not_D3 (__global short *src1, int src1_step, int src1_offset,
__global short *dst,  int dst_step,  int dst_offset,
int rows, int cols, int dst_step1)
{
int x = get_global_id(0);
int y = get_global_id(1);
if (x < cols && y < rows)
{
x = x << 2;
#ifdef dst_align
#undef dst_align
#endif
#define dst_align ((dst_offset >> 1) & 3)
int src1_index = mad24(y, src1_step, (x << 1) + src1_offset - (dst_align << 1));
int dst_start  = mad24(y, dst_step, dst_offset);
int dst_end    = mad24(y, dst_step, dst_offset + dst_step1);
int dst_index  = mad24(y, dst_step, dst_offset + (x << 1) & (int)0xfffffff8);
short4 src1_data = vload4(0, (__global short *)((__global char *)src1 + src1_index));
short4 dst_data = *((__global short4 *)((__global char *)dst + dst_index));
short4 tmp_data = ~ src1_data;
dst_data.x = ((dst_index + 0 >= dst_start) && (dst_index + 0 < dst_end)) ? tmp_data.x : dst_data.x;
dst_data.y = ((dst_index + 2 >= dst_start) && (dst_index + 2 < dst_end)) ? tmp_data.y : dst_data.y;
dst_data.z = ((dst_index + 4 >= dst_start) && (dst_index + 4 < dst_end)) ? tmp_data.z : dst_data.z;
dst_data.w = ((dst_index + 6 >= dst_start) && (dst_index + 6 < dst_end)) ? tmp_data.w : dst_data.w;
*((__global short4 *)((__global char *)dst + dst_index)) = dst_data;
}
}
__kernel void arithm_bitwise_not_D4 (__global int *src1, int src1_step, int src1_offset,
__global int *dst,  int dst_step,  int dst_offset,
int rows, int cols, int dst_step1)
{
int x = get_global_id(0);
int y = get_global_id(1);
if (x < cols && y < rows)
{
int src1_index = mad24(y, src1_step, (x << 2) + src1_offset);
int dst_index  = mad24(y, dst_step,  (x << 2) + dst_offset);
int data1 = *((__global int *)((__global char *)src1 + src1_index));
int tmp  = ~ data1;
*((__global int *)((__global char *)dst + dst_index)) = tmp;
}
}
__kernel void arithm_bitwise_not_D5 (__global char *src, int src_step, int src_offset,
__global char *dst, int dst_step, int dst_offset,
int rows, int cols, int dst_step1)
{
int x = get_global_id(0);
int y = get_global_id(1);
if (x < cols && y < rows)
{
int src_index = mad24(y, src_step, (x << 2) + src_offset);
int dst_index = mad24(y, dst_step, (x << 2) + dst_offset);
char4 data;
data = *((__global char4 *)((__global char *)src + src_index));
data = ~ data;
*((__global char4 *)((__global char *)dst + dst_index)) = data;
}
}
#if defined (DOUBLE_SUPPORT)
__kernel void arithm_bitwise_not_D6 (__global char *src, int src_step, int src_offset,
__global char *dst, int dst_step, int dst_offset,
int rows, int cols, int dst_step1)
{
int x = get_global_id(0);
int y = get_global_id(1);
if (x < cols && y < rows)
{
int src_index = mad24(y, src_step, (x << 3) + src_offset);
int dst_index = mad24(y, dst_step,  (x << 3) + dst_offset);
char8 data;
data = *((__global char8 *)((__global char *)src + src_index));
data = ~ data;
*((__global char8 *)((__global char *)dst + dst_index)) = data;
}
}
#endif


// buildOptions= -D INTEL_DEVICE
// RUN: %occ-cli %s --cl-options="-I%cwd -I%S  -D INTEL_DEVICE" %cfg_path --cl-device=%cl_device 2>&1
