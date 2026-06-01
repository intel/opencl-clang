#ifdef COPY_TO_MASK
#define DEFINE_DATA \
int src_index = mad24(y, src_step, mad24(x, (int)sizeof(T1) * scn, src_offset)); \
int dst_index = mad24(y, dst_step, mad24(x, (int)sizeof(T1) * scn, dst_offset)); \
\
__global const T1 * src = (__global const T1 *)(srcptr + src_index); \
__global T1 * dst = (__global T1 *)(dstptr + dst_index)
__kernel void copyToMask(__global const uchar * srcptr, int src_step, int src_offset,
__global const uchar * mask, int mask_step, int mask_offset,
__global uchar * dstptr, int dst_step, int dst_offset,
int dst_rows, int dst_cols)
{
int x = get_global_id(0);
int y = get_global_id(1);
if (x < dst_cols && y < dst_rows)
{
mask += mad24(y, mask_step, mad24(x, mcn, mask_offset));
#if mcn == 1
if (mask[0])
{
DEFINE_DATA;
#pragma unroll
for (int c = 0; c < scn; ++c)
dst[c] = src[c];
}
#ifdef HAVE_DST_UNINIT
else
{
DEFINE_DATA;
#pragma unroll
for (int c = 0; c < scn; ++c)
dst[c] = (T1)(0);
}
#endif
#elif scn == mcn
DEFINE_DATA;
#pragma unroll
for (int c = 0; c < scn; ++c)
if (mask[c])
dst[c] = src[c];
#ifdef HAVE_DST_UNINIT
else
dst[c] = (T1)(0);
#endif
#else
#error "(mcn == 1 || mcn == scn) should be true"
#endif
}
}
#else
#ifndef dstST
#define dstST dstT
#endif
#if cn != 3
#define value value_
#define storedst(val) *(__global dstT *)(dstptr + dst_index) = val
#else
#define value (dstT)(value_.x, value_.y, value_.z)
#define storedst(val) vstore3(val, 0, (__global dstT1 *)(dstptr + dst_index))
#endif
__kernel void setMask(__global const uchar* mask, int maskstep, int maskoffset,
__global uchar* dstptr, int dststep, int dstoffset,
int rows, int cols, dstST value_)
{
int x = get_global_id(0);
int y0 = get_global_id(1) * rowsPerWI;
if (x < cols)
{
int mask_index = mad24(y0, maskstep, x + maskoffset);
int dst_index  = mad24(y0, dststep, mad24(x, (int)sizeof(dstT1) * cn, dstoffset));
for (int y = y0, y1 = min(rows, y0 + rowsPerWI); y < y1; ++y)
{
if( mask[mask_index] )
storedst(value);
mask_index += maskstep;
dst_index += dststep;
}
}
}
__kernel void set(__global uchar* dstptr, int dststep, int dstoffset,
int rows, int cols, dstST value_)
{
int x = get_global_id(0);
int y0 = get_global_id(1) * rowsPerWI;
if (x < cols)
{
int dst_index  = mad24(y0, dststep, mad24(x, (int)sizeof(dstT1) * cn, dstoffset));
for (int y = y0, y1 = min(rows, y0 + rowsPerWI); y < y1; ++y, dst_index += dststep)
storedst(value);
}
}
#endif


// buildOptions=-D dstT=uchar -D rowsPerWI=4 -D dstST=uchar -D dstT1=uchar -D cn=1 -D INTEL_DEVICE
// RUN: %occ-cli %s --cl-options="-I%cwd -I%S -D dstT=uchar -D rowsPerWI=4 -D dstST=uchar -D dstT1=uchar -D cn=1 -D INTEL_DEVICE" %cfg_path --cl-device=%cl_device 2>&1
