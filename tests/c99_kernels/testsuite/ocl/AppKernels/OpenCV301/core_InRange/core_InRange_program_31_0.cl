#ifdef DOUBLE_SUPPORT
#ifdef cl_amd_fp64
#pragma OPENCL EXTENSION cl_amd_fp64:enable
#elif defined (cl_khr_fp64)
#pragma OPENCL EXTENSION cl_khr_fp64:enable
#endif
#endif
__kernel void inrange(__global const uchar * src1ptr, int src1_step, int src1_offset,
__global uchar * dstptr, int dst_step, int dst_offset, int dst_rows, int dst_cols,
#ifdef HAVE_SCALAR
__global const srcT1 * src2, __global const srcT1 * src3,
#else
__global const uchar * src2ptr, int src2_step, int src2_offset,
__global const uchar * src3ptr, int src3_step, int src3_offset,
#endif
int rowsPerWI)
{
int x = get_global_id(0);
int y0 = get_global_id(1) * rowsPerWI;
if (x < dst_cols)
{
int src1_index = mad24(y0, src1_step, mad24(x, (int)sizeof(srcT1) * kercn, src1_offset));
int dst_index = mad24(y0, dst_step, mad24(x, colsPerWI, dst_offset));
#ifndef HAVE_SCALAR
int src2_index = mad24(y0, src2_step, mad24(x, (int)sizeof(srcT1) * kercn, src2_offset));
int src3_index = mad24(y0, src3_step, mad24(x, (int)sizeof(srcT1) * kercn, src3_offset));
#endif
for (int y = y0, y1 = min(dst_rows, y0 + rowsPerWI); y < y1; ++y, src1_index += src1_step, dst_index += dst_step)
{
#if kercn >= cn && kercn == 4 && depth <= 4 && !defined HAVE_SCALAR
srcT src1 = *(__global const srcT *)(src1ptr + src1_index);
srcT src2 = *(__global const srcT *)(src2ptr + src2_index);
srcT src3 = *(__global const srcT *)(src3ptr + src3_index);
__global dstT * dst = (__global dstT *)(dstptr + dst_index);
#if cn == 1
dst[0] = src2 > src1 || src3 < src1 ? (dstT)(0) : (dstT)(255);
#elif cn == 2
dst[0] = (dstT)(src2.xy > src1.xy || src3.xy < src1.xy ||
src2.zw > src1.zw || src3.zw < src1.zw ? (dstT)(0) : (dstT)(255);
#elif cn == 4
dst[0] = (dstT)(src2.x > src1.x || src3.x < src1.x ||
src2.y > src1.y || src3.y < src1.y ||
src2.z > src1.z || src3.z < src1.z ||
src2.w > src1.w || src3.w < src1.w ? 0 : 255);
#endif
#else
__global const srcT1 * src1 = (__global const srcT1 *)(src1ptr + src1_index);
__global uchar * dst = dstptr + dst_index;
#ifndef HAVE_SCALAR
__global const srcT1 * src2 = (__global const srcT1 *)(src2ptr + src2_index);
__global const srcT1 * src3 = (__global const srcT1 *)(src3ptr + src3_index);
#endif
#pragma unroll
for (int px = 0; px < colsPerWI; ++px, src1 += cn
#ifndef HAVE_SCALAR
, src2 += cn, src3 += cn
#endif
)
{
dst[px] = 255;
for (int c = 0; c < cn; ++c)
if (src2[c] > src1[c] || src3[c] < src1[c])
{
dst[px] = 0;
break;
}
}
#endif
#ifndef HAVE_SCALAR
src2_index += src2_step;
src3_index += src3_step;
#endif
}
}
}


// buildOptions=-D HAVE_SCALAR -D cn=3 -D srcT=char3 -D srcT1=char -D dstT=uchar -D kercn=3 -D depth=1 -D colsPerWI=1 -D INTEL_DEVICE
// RUN: %occ-cli %s --cl-options="-I%cwd -I%S -D HAVE_SCALAR -D cn=3 -D srcT=char3 -D srcT1=char -D dstT=uchar -D kercn=3 -D depth=1 -D colsPerWI=1 -D INTEL_DEVICE" %cfg_path --cl-device=%cl_device 2>&1
