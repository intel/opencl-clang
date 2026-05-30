#ifdef DOUBLE_SUPPORT
#ifdef cl_amd_fp64
#pragma OPENCL EXTENSION cl_amd_fp64:enable
#elif defined (cl_khr_fp64)
#pragma OPENCL EXTENSION cl_khr_fp64:enable
#endif
#endif
__kernel void arithm_flip_rows(__global T * src, int src_step, int src_offset,
__global T * dst, int dst_step, int dst_offset,
int rows, int cols, int thread_rows, int thread_cols)
{
int x = get_global_id(0);
int y = get_global_id(1);
if (x < cols && y < thread_rows)
{
int src_index_0 = mad24(y,            src_step, x + src_offset);
int src_index_1 = mad24(rows - y - 1, src_step, x + src_offset);
int dst_index_0 = mad24(y,            dst_step, x + dst_offset);
int dst_index_1 = mad24(rows - y - 1, dst_step, x + dst_offset);
T data0 = src[src_index_0], data1 = src[src_index_1];
dst[dst_index_0] = data1;
dst[dst_index_1] = data0;
}
}
__kernel void arithm_flip_rows_cols(__global T * src, int src_step, int src_offset,
__global T * dst, int dst_step, int dst_offset,
int rows, int cols, int thread_rows, int thread_cols)
{
int x = get_global_id(0);
int y = get_global_id(1);
if (x < cols && y < thread_rows)
{
int src_index_0 = mad24(y,            src_step, x            + src_offset);
int dst_index_0 = mad24(rows - y - 1, dst_step, cols - x - 1 + dst_offset);
int src_index_1 = mad24(rows - y - 1, src_step, cols - x - 1 + src_offset);
int dst_index_1 = mad24(y,            dst_step, x            + dst_offset);
T data0 = src[src_index_0], data1 = src[src_index_1];
dst[dst_index_0] = data0;
dst[dst_index_1] = data1;
}
}
__kernel void arithm_flip_cols(__global T * src, int src_step, int src_offset,
__global T * dst, int dst_step, int dst_offset,
int rows, int cols, int thread_rows, int thread_cols)
{
int x = get_global_id(0);
int y = get_global_id(1);
if (x < thread_cols && y < rows)
{
int src_index_0 = mad24(y, src_step, x            + src_offset);
int dst_index_0 = mad24(y, dst_step, cols - x - 1 + dst_offset);
int src_index_1 = mad24(y, src_step, cols - x - 1 + src_offset);
int dst_index_1 = mad24(y, dst_step, x            + dst_offset);
T data0 = src[src_index_0], data1 = src[src_index_1];
dst[dst_index_1] = data1;
dst[dst_index_0] = data0;
}
}


// buildOptions= -D INTEL_DEVICE -D T=uchar4
// RUN: %occ-cli %s --cl-options="-I%cwd -I%S  -D INTEL_DEVICE -D T=uchar4" %cfg_path --cl-device=%cl_device 2>&1
