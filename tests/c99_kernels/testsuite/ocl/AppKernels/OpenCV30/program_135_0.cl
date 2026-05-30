#ifdef DOUBLE_SUPPORT
#ifdef cl_amd_fp64
#pragma OPENCL EXTENSION cl_amd_fp64:enable
#elif defined (cl_khr_fp64)
#pragma OPENCL EXTENSION cl_khr_fp64:enable
#endif
#endif
#if FUNC_SUM
#define FUNC(a, b) b += a;
#elif FUNC_ABS_SUM
#define FUNC(a, b) b += a >= (dstT)(0) ? a : -a;
#elif FUNC_SQR_SUM
#define FUNC(a, b) b += a * a;
#else
#error No sum function
#endif
__kernel void arithm_op_sum(int cols,int invalid_cols,int offset,int elemnum,int groupnum,
__global srcT *src, __global dstT *dst)
{
int lid = get_local_id(0);
int gid = get_group_id(0);
int id = get_global_id(0);
int idx = offset + id + (id / cols) * invalid_cols;
__local dstT localmem_sum[128];
dstT sum = (dstT)(0), temp;
for (int grainSize = groupnum << 8; id < elemnum; id += grainSize)
{
idx = offset + id + (id / cols) * invalid_cols;
temp = convertToDstT(src[idx]);
FUNC(temp, sum);
}
if (lid > 127)
localmem_sum[lid - 128] = sum;
barrier(CLK_LOCAL_MEM_FENCE);
if (lid < 128)
localmem_sum[lid] = sum + localmem_sum[lid];
barrier(CLK_LOCAL_MEM_FENCE);
for (int lsize = 64; lsize > 0; lsize >>= 1)
{
if (lid < lsize)
{
int lid2 = lsize + lid;
localmem_sum[lid] = localmem_sum[lid] + localmem_sum[lid2];
}
barrier(CLK_LOCAL_MEM_FENCE);
}
if (lid == 0)
dst[gid] = localmem_sum[0];
}


// buildOptions= -D INTEL_DEVICE -D srcT=uchar -D dstT=int -D convertToDstT=convert_int -D FUNC_SQR_SUM
// RUN: %occ-cli %s --cl-options="-I%cwd -I%S  -D INTEL_DEVICE -D srcT=uchar -D dstT=int -D convertToDstT=convert_int -D FUNC_SQR_SUM" %cfg_path --cl-device=%cl_device 2>&1
