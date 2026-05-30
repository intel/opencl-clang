#ifdef DOUBLE_SUPPORT
#ifdef cl_amd_fp64
#pragma OPENCL EXTENSION cl_amd_fp64:enable
#elif defined (cl_khr_fp64)
#pragma OPENCL EXTENSION cl_khr_fp64:enable
#endif
#endif
#ifdef DEPTH_5
#define MIN_VAL (-FLT_MAX)
#define MAX_VAL FLT_MAX
#elif defined DEPTH_6
#define MIN_VAL (-DBL_MAX)
#define MAX_VAL DBL_MAX
#endif
__kernel void arithm_op_minMax(__global const T * src, __global T * dst,
int cols, int invalid_cols, int offset, int elemnum, int groupnum)
{
int lid = get_local_id(0);
int gid = get_group_id(0);
int id = get_global_id(0);
int idx = offset + id + (id / cols) * invalid_cols;
__local T localmem_max[128], localmem_min[128];
T minval = (T)(MAX_VAL), maxval = (T)(MIN_VAL), temp;
for (int grainSize = groupnum << 8; id < elemnum; id += grainSize)
{
idx = offset + id + (id / cols) * invalid_cols;
temp = src[idx];
minval = min(minval, temp);
maxval = max(maxval, temp);
}
if (lid > 127)
{
localmem_min[lid - 128] = minval;
localmem_max[lid - 128] = maxval;
}
barrier(CLK_LOCAL_MEM_FENCE);
if (lid < 128)
{
localmem_min[lid] = min(minval, localmem_min[lid]);
localmem_max[lid] = max(maxval, localmem_max[lid]);
}
barrier(CLK_LOCAL_MEM_FENCE);
for (int lsize = 64; lsize > 0; lsize >>= 1)
{
if (lid < lsize)
{
int lid2 = lsize + lid;
localmem_min[lid] = min(localmem_min[lid], localmem_min[lid2]);
localmem_max[lid] = max(localmem_max[lid], localmem_max[lid2]);
}
barrier(CLK_LOCAL_MEM_FENCE);
}
if (lid == 0)
{
dst[gid] = localmem_min[0];
dst[gid + groupnum] = localmem_max[0];
}
}
__kernel void arithm_op_minMax_mask(__global const T * src, __global T * dst,
int cols, int invalid_cols, int offset,
int elemnum, int groupnum,
const __global uchar * mask, int minvalid_cols, int moffset)
{
int lid = get_local_id(0);
int gid = get_group_id(0);
int id = get_global_id(0);
int idx = offset + id + (id / cols) * invalid_cols;
int midx = moffset + id + (id / cols) * minvalid_cols;
__local T localmem_max[128], localmem_min[128];
T minval = (T)(MAX_VAL), maxval = (T)(MIN_VAL), temp;
for (int grainSize = groupnum << 8; id < elemnum; id += grainSize)
{
idx = offset + id + (id / cols) * invalid_cols;
midx = moffset + id + (id / cols) * minvalid_cols;
if (mask[midx])
{
temp = src[idx];
minval = min(minval, temp);
maxval = max(maxval, temp);
}
}
if (lid > 127)
{
localmem_min[lid - 128] = minval;
localmem_max[lid - 128] = maxval;
}
barrier(CLK_LOCAL_MEM_FENCE);
if (lid < 128)
{
localmem_min[lid] = min(minval, localmem_min[lid]);
localmem_max[lid] = max(maxval, localmem_max[lid]);
}
barrier(CLK_LOCAL_MEM_FENCE);
for (int lsize = 64; lsize > 0; lsize >>= 1)
{
if (lid < lsize)
{
int lid2 = lsize + lid;
localmem_min[lid] = min(localmem_min[lid], localmem_min[lid2]);
localmem_max[lid] = max(localmem_max[lid], localmem_max[lid2]);
}
barrier(CLK_LOCAL_MEM_FENCE);
}
if (lid == 0)
{
dst[gid] = localmem_min[0];
dst[gid + groupnum] = localmem_max[0];
}
}


// buildOptions= -D INTEL_DEVICE -D T=int -D MAX_VAL=2147483647 -D MIN_VAL=-2147483648
// RUN: %occ-cli %s --cl-options="-I%cwd -I%S  -D INTEL_DEVICE -D T=int -D MAX_VAL=2147483647 -D MIN_VAL=-2147483648" %cfg_path --cl-device=%cl_device 2>&1
