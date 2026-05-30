inline float2 cmulf(float2 a, float2 b)
{
return (float2)(mad(a.x, b.x, - a.y * b.y), mad(a.x, b.y, a.y * b.x));
}
inline float2 conjf(float2 a)
{
return (float2)(a.x, - a.y);
}
__kernel void mulAndScaleSpectrums(__global const uchar * src1ptr, int src1_step, int src1_offset,
__global const uchar * src2ptr, int src2_step, int src2_offset,
__global uchar * dstptr, int dst_step, int dst_offset,
int dst_rows, int dst_cols, int rowsPerWI)
{
int x = get_global_id(0);
int y0 = get_global_id(1) * rowsPerWI;
if (x < dst_cols)
{
int src1_index = mad24(y0, src1_step, mad24(x, (int)sizeof(float2), src1_offset));
int src2_index = mad24(y0, src2_step, mad24(x, (int)sizeof(float2), src2_offset));
int dst_index = mad24(y0, dst_step, mad24(x, (int)sizeof(float2), dst_offset));
for (int y = y0, y1 = min(dst_rows, y0 + rowsPerWI); y < y1; ++y,
src1_index += src1_step, src2_index += src2_step, dst_index += dst_step)
{
float2 src0 = *(__global const float2 *)(src1ptr + src1_index);
float2 src1 = *(__global const float2 *)(src2ptr + src2_index);
__global float2 * dst = (__global float2 *)(dstptr + dst_index);
#ifdef CONJ
float2 v = cmulf(src0, conjf(src1));
#else
float2 v = cmulf(src0, src1);
#endif
dst[0] = v;
}
}
}


// buildOptions= -D INTEL_DEVICE
// RUN: %occ-cli %s --cl-options="-I%cwd -I%S  -D INTEL_DEVICE" %cfg_path --cl-device=%cl_device 2>&1
