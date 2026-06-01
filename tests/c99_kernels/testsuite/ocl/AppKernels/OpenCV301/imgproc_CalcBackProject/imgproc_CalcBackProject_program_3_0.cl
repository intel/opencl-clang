#define OUT_OF_RANGE -1
#define ROUNDING_EPS 0.000001f
#if histdims == 1
__kernel void calcLUT(__global const uchar * histptr, int hist_step, int hist_offset, int hist_bins,
__global int * lut, float scale, __constant float * ranges)
{
int x = get_global_id(0);
float value = convert_float(x);
if (value > ranges[1] || value < ranges[0])
lut[x] = OUT_OF_RANGE;
else
{
float lb = ranges[0], ub = ranges[1], gap = (ub - lb) / hist_bins;
value -= lb;
int bin = convert_int_sat_rtn(value / gap + ROUNDING_EPS);
if (bin >= hist_bins)
lut[x] = OUT_OF_RANGE;
else
{
int hist_index = mad24(hist_step, bin, hist_offset);
__global const float * hist = (__global const float *)(histptr + hist_index);
lut[x] = (int)convert_uchar_sat_rte(hist[0] * scale);
}
}
}
__kernel void LUT(__global const uchar * src, int src_step, int src_offset,
__constant int * lut,
__global uchar * dst, int dst_step, int dst_offset, int dst_rows, int dst_cols)
{
int x = get_global_id(0);
int y = get_global_id(1);
if (x < dst_cols && y < dst_rows)
{
int src_index = mad24(y, src_step, src_offset + x * scn);
int dst_index = mad24(y, dst_step, dst_offset + x);
int value = lut[src[src_index]];
dst[dst_index] = value == OUT_OF_RANGE ? 0 : convert_uchar(value);
}
}
#elif histdims == 2
__kernel void calcLUT(int hist_bins, __global int * lut, int lut_offset,
__constant float * ranges, int roffset)
{
int x = get_global_id(0);
float value = convert_float(x);
ranges += roffset;
lut += lut_offset;
if (value > ranges[1] || value < ranges[0])
lut[x] = OUT_OF_RANGE;
else
{
float lb = ranges[0], ub = ranges[1], gap = (ub - lb) / hist_bins;
value -= lb;
int bin = convert_int_sat_rtn(value / gap + ROUNDING_EPS);
lut[x] = bin >= hist_bins ? OUT_OF_RANGE : bin;
}
}
__kernel void LUT(__global const uchar * src1, int src1_step, int src1_offset,
__global const uchar * src2, int src2_step, int src2_offset,
__global const uchar * histptr, int hist_step, int hist_offset,
__constant int * lut, float scale,
__global uchar * dst, int dst_step, int dst_offset, int dst_rows, int dst_cols)
{
int x = get_global_id(0);
int y = get_global_id(1);
if (x < dst_cols && y < dst_rows)
{
int src1_index = mad24(y, src1_step, src1_offset + x * scn1);
int src2_index = mad24(y, src2_step, src2_offset + x * scn2);
int dst_index = mad24(y, dst_step, dst_offset + x);
int bin1 = lut[src1[src1_index]];
int bin2 = lut[src2[src2_index] + 256];
dst[dst_index] = bin1 == OUT_OF_RANGE || bin2 == OUT_OF_RANGE ? 0 :
convert_uchar_sat_rte(*(__global const float *)(histptr +
mad24(hist_step, bin1, hist_offset + bin2 * (int)sizeof(float))) * scale);
}
}
#else
#error "(nimages <= 2) should be true"
#endif


// buildOptions=-D histdims=1 -D scn=1 -D INTEL_DEVICE
// RUN: %occ-cli %s --cl-options="-I%cwd -I%S -D histdims=1 -D scn=1 -D INTEL_DEVICE" %cfg_path --cl-device=%cl_device 2>&1
