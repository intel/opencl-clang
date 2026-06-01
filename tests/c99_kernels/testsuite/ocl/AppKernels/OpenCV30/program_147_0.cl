#ifdef DOUBLE_SUPPORT
#ifdef cl_amd_fp64
#pragma OPENCL EXTENSION cl_amd_fp64:enable
#elif defined (cl_khr_fp64)
#pragma OPENCL EXTENSION cl_khr_fp64:enable
#endif
#endif
#ifdef BINARY
__kernel void arithm_absdiff_nonsaturate_binary(__global srcT *src1, int src1_step, int src1_offset,
__global srcT *src2, int src2_step, int src2_offset,
__global dstT *dst, int dst_step, int dst_offset,
int cols, int rows)
{
int x = get_global_id(0);
int y = get_global_id(1);
if (x < cols && y < rows)
{
int src1_index = mad24(y, src1_step, x + src1_offset);
int src2_index = mad24(y, src2_step, x + src2_offset);
int dst_index  = mad24(y, dst_step, x + dst_offset);
#ifdef INTEL_DEVICE
if(src1_index >= 0 && src2_index >= 0)
#endif
{
dstT t0 = convertToDstT(src1[src1_index]);
dstT t1 = convertToDstT(src2[src2_index]);
dstT t2 = t0 - t1;
dst[dst_index] = t2 >= (dstT)(0) ? t2 : -t2;
}
}
}
#else
__kernel void arithm_absdiff_nonsaturate(__global srcT *src1, int src1_step, int src1_offset,
__global dstT *dst, int dst_step, int dst_offset,
int cols, int rows)
{
int x = get_global_id(0);
int y = get_global_id(1);
if (x < cols && y < rows)
{
int src1_index = mad24(y, src1_step, x + src1_offset);
int dst_index  = mad24(y, dst_step, x + dst_offset);
#ifdef INTEL_DEVICE
if(src1_index >= 0)
#endif
{
dstT t0 = convertToDstT(src1[src1_index]);
dst[dst_index] = t0 >= (dstT)(0) ? t0 : -t0;
}
}
}
#endif


// buildOptions= -D INTEL_DEVICE -D srcT=uchar -D dstT=int -D convertToDstT=convert_int -D BINARY
// RUN: %occ-cli %s --cl-options="-I%cwd -I%S  -D INTEL_DEVICE -D srcT=uchar -D dstT=int -D convertToDstT=convert_int -D BINARY" %cfg_path --cl-device=%cl_device 2>&1
