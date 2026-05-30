#ifdef DOUBLE_SUPPORT
#ifdef cl_amd_fp64
#pragma OPENCL EXTENSION cl_amd_fp64:enable
#elif defined (cl_khr_fp64)
#pragma OPENCL EXTENSION cl_khr_fp64:enable
#endif
#define RES_TYPE double4
#define CONVERT_RES_TYPE convert_double4
#else
#define RES_TYPE float4
#define CONVERT_RES_TYPE convert_float4
#endif
#if defined (DEPTH_0)
#define VEC_TYPE uchar4
#define VEC_TYPE_LOC int4
#define CONVERT_TYPE convert_uchar4
#define CONDITION_FUNC(a,b,c) (convert_int4(a) ? b : c)
#define MIN_VAL 0
#define MAX_VAL 255
#endif
#if defined (DEPTH_1)
#define VEC_TYPE char4
#define VEC_TYPE_LOC int4
#define CONVERT_TYPE convert_char4
#define CONDITION_FUNC(a,b,c) (convert_int4(a) ? b : c)
#define MIN_VAL -128
#define MAX_VAL 127
#endif
#if defined (DEPTH_2)
#define VEC_TYPE ushort4
#define VEC_TYPE_LOC int4
#define CONVERT_TYPE convert_ushort4
#define CONDITION_FUNC(a,b,c) (convert_int4(a) ? b : c)
#define MIN_VAL 0
#define MAX_VAL 65535
#endif
#if defined (DEPTH_3)
#define VEC_TYPE short4
#define VEC_TYPE_LOC int4
#define CONVERT_TYPE convert_short4
#define CONDITION_FUNC(a,b,c) (convert_int4(a) ? b : c)
#define MIN_VAL -32768
#define MAX_VAL 32767
#endif
#if defined (DEPTH_4)
#define VEC_TYPE int4
#define VEC_TYPE_LOC int4
#define CONVERT_TYPE convert_int4
#define CONDITION_FUNC(a,b,c) ((a) ? b : c)
#define MIN_VAL INT_MIN
#define MAX_VAL INT_MAX
#endif
#if defined (DEPTH_5)
#define VEC_TYPE float4
#define VEC_TYPE_LOC float4
#define CONVERT_TYPE convert_float4
#define CONDITION_FUNC(a,b,c) ((a) ? b : c)
#define MIN_VAL (-FLT_MAX)
#define MAX_VAL FLT_MAX
#endif
#if defined (DEPTH_6)
#define VEC_TYPE double4
#define VEC_TYPE_LOC double4
#define CONVERT_TYPE convert_double4
#define CONDITION_FUNC(a,b,c) ((a) ? b : c)
#define MIN_VAL (-DBL_MAX)
#define MAX_VAL DBL_MAX
#endif
#if defined (REPEAT_S0)
#define repeat_s(a) a=a;
#endif
#if defined (REPEAT_S1)
#define repeat_s(a) a.s0 = a.s1;
#endif
#if defined (REPEAT_S2)
#define repeat_s(a) a.s0 = a.s2;a.s1 = a.s2;
#endif
#if defined (REPEAT_S3)
#define repeat_s(a) a.s0 = a.s3;a.s1 = a.s3;a.s2 = a.s3;
#endif
#if defined (REPEAT_E0)
#define repeat_e(a) a=a;
#endif
#if defined (REPEAT_E1)
#define repeat_e(a) a.s3 = a.s2;
#endif
#if defined (REPEAT_E2)
#define repeat_e(a) a.s3 = a.s1;a.s2 = a.s1;
#endif
#if defined (REPEAT_E3)
#define repeat_e(a) a.s3 = a.s0;a.s2 = a.s0;a.s1 = a.s0;
#endif
__kernel void arithm_op_minMaxLoc(int cols, int invalid_cols, int offset, int elemnum, int groupnum,
__global VEC_TYPE *src, __global RES_TYPE *dst)
{
int lid = get_local_id(0);
int gid = get_group_id(0);
int  id = get_global_id(0);
int idx = offset + id + (id / cols) * invalid_cols;
__local VEC_TYPE localmem_max[128], localmem_min[128];
VEC_TYPE minval, maxval, temp;
__local VEC_TYPE_LOC localmem_maxloc[128], localmem_minloc[128];
VEC_TYPE_LOC minloc, maxloc, temploc, negative = -1;
int idx_c;
if (id < elemnum)
{
temp = src[idx];
idx_c = idx << 2;
temploc = (VEC_TYPE_LOC)(idx_c, idx_c + 1, idx_c + 2, idx_c + 3);
if (id % cols == 0 )
{
repeat_s(temp);
repeat_s(temploc);
}
if (id % cols == cols - 1)
{
repeat_e(temp);
repeat_e(temploc);
}
minval = temp;
maxval = temp;
minloc = temploc;
maxloc = temploc;
}
else
{
minval = MAX_VAL;
maxval = MIN_VAL;
minloc = negative;
maxloc = negative;
}
int grainSize = (groupnum << 8);
for (id = id + grainSize; id < elemnum; id = id + grainSize)
{
idx = offset + id + (id / cols) * invalid_cols;
temp = src[idx];
idx_c = idx << 2;
temploc = (VEC_TYPE_LOC)(idx_c, idx_c+1, idx_c+2, idx_c+3);
if (id % cols == 0 )
{
repeat_s(temp);
repeat_s(temploc);
}
if (id % cols == cols - 1)
{
repeat_e(temp);
repeat_e(temploc);
}
minval = min(minval, temp);
maxval = max(maxval, temp);
minloc = CONDITION_FUNC(minval == temp, temploc, minloc);
maxloc = CONDITION_FUNC(maxval == temp, temploc, maxloc);
}
if (lid > 127)
{
localmem_min[lid - 128] = minval;
localmem_max[lid - 128] = maxval;
localmem_minloc[lid - 128] = minloc;
localmem_maxloc[lid - 128] = maxloc;
}
barrier(CLK_LOCAL_MEM_FENCE);
if (lid < 128)
{
localmem_min[lid] = min(minval,localmem_min[lid]);
localmem_max[lid] = max(maxval,localmem_max[lid]);
VEC_TYPE minVal = localmem_min[lid], maxVal = localmem_max[lid];
localmem_minloc[lid] = CONDITION_FUNC(minVal == minval, minloc, localmem_minloc[lid]);
localmem_maxloc[lid] = CONDITION_FUNC(maxVal == maxval, maxloc, localmem_maxloc[lid]);
}
barrier(CLK_LOCAL_MEM_FENCE);
for (int lsize = 64; lsize > 0; lsize >>= 1)
{
if (lid < lsize)
{
int lid2 = lsize + lid;
localmem_min[lid] = min(localmem_min[lid], localmem_min[lid2]);
localmem_max[lid] = max(localmem_max[lid], localmem_max[lid2]);
VEC_TYPE min1 = localmem_min[lid], min2 = localmem_min[lid2];
localmem_minloc[lid] = CONDITION_FUNC(min1 == min2, localmem_minloc[lid2], localmem_minloc[lid]);
VEC_TYPE max1 = localmem_max[lid], max2 = localmem_max[lid2];
localmem_maxloc[lid] = CONDITION_FUNC(max1 == max2, localmem_maxloc[lid2], localmem_maxloc[lid]);
}
barrier(CLK_LOCAL_MEM_FENCE);
}
if ( lid == 0)
{
dst[gid] = CONVERT_RES_TYPE(localmem_min[0]);
dst[gid + groupnum] = CONVERT_RES_TYPE(localmem_max[0]);
dst[gid + 2 * groupnum] = CONVERT_RES_TYPE(localmem_minloc[0]);
dst[gid + 3 * groupnum] = CONVERT_RES_TYPE(localmem_maxloc[0]);
}
}


// buildOptions= -D INTEL_DEVICE -D DEPTH_5 -D REPEAT_S0 -D REPEAT_E0
// RUN: %occ-cli %s --cl-options="-I%cwd -I%S  -D INTEL_DEVICE -D DEPTH_5 -D REPEAT_S0 -D REPEAT_E0" %cfg_path --cl-device=%cl_device 2>&1
