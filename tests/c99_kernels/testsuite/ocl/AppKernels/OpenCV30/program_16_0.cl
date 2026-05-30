#ifdef DOUBLE_SUPPORT
#ifdef cl_amd_fp64
#pragma OPENCL EXTENSION cl_amd_fp64:enable
#elif defined (cl_khr_fp64)
#pragma OPENCL EXTENSION cl_khr_fp64:enable
#endif
#endif
__kernel void arithm_magnitude(__global T *src1, int src1_step, int src1_offset,
__global T *src2, int src2_step, int src2_offset,
__global T *dst,  int dst_step,  int dst_offset,
int rows, int cols)
{
int x = get_global_id(0);
int y = get_global_id(1);
if (x < cols && y < rows)
{
int src1_index = mad24(y, src1_step, x + src1_offset);
int src2_index = mad24(y, src2_step, x + src2_offset);
int dst_index  = mad24(y, dst_step,  x + dst_offset);
T data1 = src1[src1_index];
T data2 = src2[src2_index];
T tmp = hypot(data1, data2);
dst[dst_index] = tmp;
}
}


// buildOptions= -D INTEL_DEVICE -D T=float
// RUN: %occ-cli %s --cl-options="-I%cwd -I%S  -D INTEL_DEVICE -D T=float" %cfg_path --cl-device=%cl_device 2>&1
