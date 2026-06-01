#ifdef OP_MAX_EIGEN_VAL
__kernel void maxEigenVal(__global const uchar * srcptr, int src_step, int src_offset, int cols,
int total, __global uchar * dstptr
#ifdef HAVE_MASK
, __global const uchar * maskptr, int mask_step, int mask_offset
#endif
)
{
int lid = get_local_id(0);
int gid = get_group_id(0);
int  id = get_global_id(0);
__local float localmem_max[WGS2_ALIGNED];
float maxval = -FLT_MAX;
for (int grain = groupnum * WGS; id < total; id += grain)
{
int src_index = mad24(id / cols, src_step, mad24((id % cols), (int)sizeof(float), src_offset));
#ifdef HAVE_MASK
int mask_index = mad24(id / cols, mask_step, id % cols + mask_offset);
if (maskptr[mask_index])
#endif
maxval = max(maxval, *(__global const float *)(srcptr + src_index));
}
if (lid < WGS2_ALIGNED)
localmem_max[lid] = maxval;
barrier(CLK_LOCAL_MEM_FENCE);
if (lid >= WGS2_ALIGNED && total >= WGS2_ALIGNED)
localmem_max[lid - WGS2_ALIGNED] = max(maxval, localmem_max[lid - WGS2_ALIGNED]);
barrier(CLK_LOCAL_MEM_FENCE);
for (int lsize = WGS2_ALIGNED >> 1; lsize > 0; lsize >>= 1)
{
if (lid < lsize)
{
int lid2 = lsize + lid;
localmem_max[lid] = max(localmem_max[lid], localmem_max[lid2]);
}
barrier(CLK_LOCAL_MEM_FENCE);
}
if (lid == 0)
*(__global float *)(dstptr + (int)sizeof(float) * gid) = localmem_max[0];
}
__kernel void maxEigenValTask(__global float * dst, float qualityLevel,
__global int * cornersptr)
{
float maxval = -FLT_MAX;
#pragma unroll
for (int x = 0; x < groupnum; ++x)
maxval = max(maxval, dst[x]);
dst[0] = maxval * qualityLevel;
cornersptr[0] = 0;
}
#elif OP_FIND_CORNERS
#define GET_SRC_32F(_y, _x) *(__global const float *)(eigptr + (_y) * eig_step + (_x) * (int)sizeof(float) )
__kernel void findCorners(__global const uchar * eigptr, int eig_step, int eig_offset,
#ifdef HAVE_MASK
__global const uchar * mask, int mask_step, int mask_offset,
#endif
__global uchar * cornersptr, int rows, int cols,
__constant float * threshold, int max_corners)
{
int x = get_global_id(0);
int y = get_global_id(1);
__global int* counter = (__global int*) cornersptr;
__global float2 * corners = (__global float2 *)(cornersptr + (int)sizeof(float2));
if (y < rows && x < cols
#ifdef HAVE_MASK
&& mask[mad24(y, mask_step, x + mask_offset)]
#endif
)
{
++x, ++y;
float val = GET_SRC_32F(y, x);
if (val > threshold[0])
{
float maxVal = val;
maxVal = max(GET_SRC_32F(y - 1, x - 1), maxVal);
maxVal = max(GET_SRC_32F(y - 1, x    ), maxVal);
maxVal = max(GET_SRC_32F(y - 1, x + 1), maxVal);
maxVal = max(GET_SRC_32F(y    , x - 1), maxVal);
maxVal = max(GET_SRC_32F(y    , x + 1), maxVal);
maxVal = max(GET_SRC_32F(y + 1, x - 1), maxVal);
maxVal = max(GET_SRC_32F(y + 1, x    ), maxVal);
maxVal = max(GET_SRC_32F(y + 1, x + 1), maxVal);
if (val == maxVal)
{
int ind = atomic_inc(counter);
if (ind < max_corners)
{
corners[ind].x = val;
corners[ind].y = as_float(y | (x << 16));
}
}
}
}
}
#endif


// buildOptions=-D OP_FIND_CORNERS -D INTEL_DEVICE
// RUN: %occ-cli %s --cl-options="-I%cwd -I%S -D OP_FIND_CORNERS -D INTEL_DEVICE" %cfg_path --cl-device=%cl_device 2>&1
