#ifdef DOUBLE_SUPPORT
#ifdef cl_amd_fp64
#pragma OPENCL EXTENSION cl_amd_fp64:enable
#elif defined (cl_khr_fp64)
#pragma OPENCL EXTENSION cl_khr_fp64:enable
#endif
#endif
__kernel void arithm_log_C1(__global srcT *src, __global srcT *dst,
int cols1, int rows,
int srcOffset1, int dstOffset1,
int srcStep1, int dstStep1)
{
int x = get_global_id(0);
int y = get_global_id(1);
if(x < cols1 && y < rows)
{
int srcIdx = mad24(y, srcStep1, x + srcOffset1);
int dstIdx = mad24(y, dstStep1, x + dstOffset1);
dst[dstIdx] = log(src[srcIdx]);
}
}
__kernel void arithm_log_C2(__global srcT *src, __global srcT *dst,
int cols1, int rows,
int srcOffset1, int dstOffset1,
int srcStep1, int dstStep1)
{
int x1 = get_global_id(0) << 1;
int y = get_global_id(1);
if(x1 < cols1 && y < rows)
{
int srcIdx = mad24(y, srcStep1, x1 + srcOffset1);
int dstIdx = mad24(y, dstStep1, x1 + dstOffset1);
dst[dstIdx] =                      log(src[srcIdx]);
dst[dstIdx + 1] = x1 + 1 < cols1 ? log(src[srcIdx + 1]) : dst[dstIdx + 1];
}
}
__kernel void arithm_log_C4(__global srcT *src, __global srcT *dst,
int cols1, int rows,
int srcOffset1, int dstOffset1,
int srcStep1, int dstStep1)
{
int x1 = get_global_id(0) << 2;
int y = get_global_id(1);
if(x1 < cols1 && y < rows)
{
int srcIdx = mad24(y, srcStep1, x1 + srcOffset1);
int dstIdx = mad24(y, dstStep1, x1 + dstOffset1);
dst[dstIdx] =                      log(src[srcIdx]);
dst[dstIdx + 1] = x1 + 1 < cols1 ? log(src[srcIdx + 1]) : dst[dstIdx + 1];
dst[dstIdx + 2] = x1 + 2 < cols1 ? log(src[srcIdx + 2]) : dst[dstIdx + 2];
dst[dstIdx + 3] = x1 + 3 < cols1 ? log(src[srcIdx + 3]) : dst[dstIdx + 3];
}
}


// buildOptions= -D INTEL_DEVICE -D srcT=float
// RUN: %occ-cli %s --cl-options="-I%cwd -I%S  -D INTEL_DEVICE -D srcT=float" %cfg_path --cl-device=%cl_device 2>&1
