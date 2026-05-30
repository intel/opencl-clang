#ifdef DOUBLE_SUPPORT
#ifdef cl_amd_fp64
#pragma OPENCL EXTENSION cl_amd_fp64:enable
#elif defined (cl_khr_fp64)
#pragma OPENCL EXTENSION cl_khr_fp64:enable
#endif
#endif
__kernel void arithm_pow(__global VT * src, int src_step, int src_offset,
__global VT * dst, int dst_step, int dst_offset,
int rows, int cols, T p)
{
int x = get_global_id(0);
int y = get_global_id(1);
if (x < cols && y < rows)
{
int src_index = mad24(y, src_step, x + src_offset);
int dst_index = mad24(y, dst_step, x + dst_offset);
VT src_data = src[src_index];
VT tmp = src_data > 0 ? exp(p * log(src_data)) : (src_data == 0 ? 0 : exp(p * log(fabs(src_data))));
dst[dst_index] = tmp;
}
}


// buildOptions= -D INTEL_DEVICE -D VT=float -D T=float
// RUN: %occ-cli %s --cl-options="-I%cwd -I%S  -D INTEL_DEVICE -D VT=float -D T=float" %cfg_path --cl-device=%cl_device 2>&1
