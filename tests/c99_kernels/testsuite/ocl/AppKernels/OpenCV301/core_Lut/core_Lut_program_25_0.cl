#if lcn == 1
#if dcn == 4
#define LUT_OP  \
int idx = *(__global const int *)(srcptr + src_index); \
dst = (__global dstT *)(dstptr + dst_index); \
dst[0] = lut_l[idx & 0xff]; \
dst[1] = lut_l[(idx >> 8) & 0xff]; \
dst[2] = lut_l[(idx >> 16) & 0xff]; \
dst[3] = lut_l[(idx >> 24) & 0xff];
#elif dcn == 3
#define LUT_OP  \
uchar3 idx = vload3(0, srcptr + src_index); \
dst = (__global dstT *)(dstptr + dst_index); \
dst[0] = lut_l[idx.x]; \
dst[1] = lut_l[idx.y]; \
dst[2] = lut_l[idx.z];
#elif dcn == 2
#define LUT_OP \
short idx = *(__global const short *)(srcptr + src_index); \
dst = (__global dstT *)(dstptr + dst_index); \
dst[0] = lut_l[idx & 0xff]; \
dst[1] = lut_l[(idx >> 8) & 0xff];
#elif dcn == 1
#define LUT_OP \
uchar idx = (srcptr + src_index)[0]; \
dst = (__global dstT *)(dstptr + dst_index); \
dst[0] = lut_l[idx];
#else
#define LUT_OP \
__global const srcT * src = (__global const srcT *)(srcptr + src_index); \
dst = (__global dstT *)(dstptr + dst_index); \
for (int cn = 0; cn < dcn; ++cn) \
dst[cn] = lut_l[src[cn]];
#endif
#else
#if dcn == 4
#define LUT_OP \
__global const uchar4 * src_pixel = (__global const uchar4 *)(srcptr + src_index); \
int4 idx = mad24(convert_int4(src_pixel[0]), (int4)(lcn), (int4)(0, 1, 2, 3)); \
dst = (__global dstT *)(dstptr + dst_index); \
dst[0] = lut_l[idx.x]; \
dst[1] = lut_l[idx.y]; \
dst[2] = lut_l[idx.z]; \
dst[3] = lut_l[idx.w];
#elif dcn == 3
#define LUT_OP \
uchar3 src_pixel = vload3(0, srcptr + src_index); \
int3 idx = mad24(convert_int3(src_pixel), (int3)(lcn), (int3)(0, 1, 2)); \
dst = (__global dstT *)(dstptr + dst_index); \
dst[0] = lut_l[idx.x]; \
dst[1] = lut_l[idx.y]; \
dst[2] = lut_l[idx.z];
#elif dcn == 2
#define LUT_OP \
__global const uchar2 * src_pixel = (__global const uchar2 *)(srcptr + src_index); \
int2 idx = mad24(convert_int2(src_pixel[0]), lcn, (int2)(0, 1)); \
dst = (__global dstT *)(dstptr + dst_index); \
dst[0] = lut_l[idx.x]; \
dst[1] = lut_l[idx.y];
#elif dcn == 1
#define LUT_OP \
uchar idx = (srcptr + src_index)[0]; \
dst = (__global dstT *)(dstptr + dst_index); \
dst[0] = lut_l[idx];
#else
#define LUT_OP \
__global const srcT * src = (__global const srcT *)(srcptr + src_index); \
dst = (__global dstT *)(dstptr + dst_index); \
for (int cn = 0; cn < dcn; ++cn) \
dst[cn] = lut_l[mad24(src[cn], lcn, cn)];
#endif
#endif
__kernel void LUT(__global const uchar * srcptr, int src_step, int src_offset,
__global const uchar * lutptr, int lut_step, int lut_offset,
__global uchar * dstptr, int dst_step, int dst_offset, int rows, int cols)
{
int x = get_global_id(0);
int y = get_global_id(1) << 2;
__local dstT lut_l[256 * lcn];
__global const dstT * lut = (__global const dstT *)(lutptr + lut_offset);
for (int i = mad24((int)get_local_id(1), (int)get_local_size(0), (int)get_local_id(0)),
step = get_local_size(0) * get_local_size(1); i < 256 * lcn; i += step)
lut_l[i] = lut[i];
barrier(CLK_LOCAL_MEM_FENCE);
if (x < cols && y < rows)
{
int src_index = mad24(y, src_step, mad24(x, (int)sizeof(srcT) * dcn, src_offset));
int dst_index = mad24(y, dst_step, mad24(x, (int)sizeof(dstT) * dcn, dst_offset));
__global dstT * dst;
LUT_OP;
if (y < rows - 1)
{
src_index += src_step;
dst_index += dst_step;
LUT_OP;
if (y < rows - 2)
{
src_index += src_step;
dst_index += dst_step;
LUT_OP;
if (y < rows - 3)
{
src_index += src_step;
dst_index += dst_step;
LUT_OP;
}
}
}
}
}


// buildOptions=-D dcn=3 -D lcn=3 -D srcT=uchar -D dstT=ulong -D INTEL_DEVICE
// RUN: %occ-cli %s --cl-options="-I%cwd -I%S -D dcn=3 -D lcn=3 -D srcT=uchar -D dstT=ulong -D INTEL_DEVICE" %cfg_path --cl-device=%cl_device 2>&1
