#ifdef DOUBLE_SUPPORT
#ifdef cl_amd_fp64
#pragma OPENCL EXTENSION cl_amd_fp64:enable
#elif defined (cl_khr_fp64)
#pragma OPENCL EXTENSION cl_khr_fp64:enable
#endif
#endif
__kernel void arithm_compare(__global T * src1, int src1_step1, int src1_offset1,
__global T * src2, int src2_step1, int src2_offset1,
__global uchar * dst, int dst_step1, int dst_offset1,
int cols1, int rows)
{
int x = get_global_id(0);
int y = get_global_id(1);
if (x < cols1 && y < rows)
{
int src1_index = mad24(y, src1_step1, x + src1_offset1);
int src2_index = mad24(y, src2_step1, x + src2_offset1);
int dst_index = mad24(y, dst_step1, x + dst_offset1);
dst[dst_index] = convert_uchar(src1[src1_index] Operation src2[src2_index] ? 255 : 0);
}
}


// buildOptions= -D INTEL_DEVICE -D T=uchar -D Operation===
// RUN: %occ-cli %s --cl-options="-I%cwd -I%S  -D INTEL_DEVICE -D T=uchar -D Operation===" %cfg_path --cl-device=%cl_device 2>&1
