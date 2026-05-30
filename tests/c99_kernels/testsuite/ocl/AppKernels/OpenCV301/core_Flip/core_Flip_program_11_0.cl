#if kercn != 3
#define loadpix(addr) *(__global const T *)(addr)
#define storepix(val, addr)  *(__global T *)(addr) = val
#define TSIZE (int)sizeof(T)
#else
#define loadpix(addr) vload3(0, (__global const T1 *)(addr))
#define storepix(val, addr) vstore3(val, 0, (__global T1 *)(addr))
#define TSIZE ((int)sizeof(T1)*3)
#endif
__kernel void arithm_flip_rows(__global const uchar * srcptr, int src_step, int src_offset,
__global uchar * dstptr, int dst_step, int dst_offset,
int rows, int cols, int thread_rows, int thread_cols)
{
int x = get_global_id(0);
int y0 = get_global_id(1) * PIX_PER_WI_Y;
if (x < cols)
{
int src_index0 = mad24(y0, src_step, mad24(x, TSIZE, src_offset));
int src_index1 = mad24(rows - y0 - 1, src_step, mad24(x, TSIZE, src_offset));
int dst_index0 = mad24(y0, dst_step, mad24(x, TSIZE, dst_offset));
int dst_index1 = mad24(rows - y0 - 1, dst_step, mad24(x, TSIZE, dst_offset));
#pragma unroll
for (int y = y0, y1 = min(thread_rows, y0 + PIX_PER_WI_Y); y < y1; ++y)
{
T src0 = loadpix(srcptr + src_index0);
T src1 = loadpix(srcptr + src_index1);
storepix(src1, dstptr + dst_index0);
storepix(src0, dstptr + dst_index1);
src_index0 += src_step;
src_index1 -= src_step;
dst_index0 += dst_step;
dst_index1 -= dst_step;
}
}
}
__kernel void arithm_flip_rows_cols(__global const uchar * srcptr, int src_step, int src_offset,
__global uchar * dstptr, int dst_step, int dst_offset,
int rows, int cols, int thread_rows, int thread_cols)
{
int x = get_global_id(0);
int y0 = get_global_id(1)*PIX_PER_WI_Y;
if (x < cols)
{
int src_index0 = mad24(y0, src_step, mad24(x, TSIZE, src_offset));
int src_index1 = mad24(rows - y0 - 1, src_step, mad24(cols - x - 1, TSIZE, src_offset));
int dst_index0 = mad24(y0, dst_step, mad24(x, TSIZE, dst_offset));
int dst_index1 = mad24(rows - y0 - 1, dst_step, mad24(cols - x - 1, TSIZE, dst_offset));
#pragma unroll
for (int y = y0, y1 = min(thread_rows, y0 + PIX_PER_WI_Y); y < y1; ++y)
{
T src0 = loadpix(srcptr + src_index0);
T src1 = loadpix(srcptr + src_index1);
#if kercn == 2
#if cn == 1
src0 = src0.s10;
src1 = src1.s10;
#endif
#elif kercn == 4
#if cn == 1
src0 = src0.s3210;
src1 = src1.s3210;
#elif cn == 2
src0 = src0.s2301;
src1 = src1.s2301;
#endif
#endif
storepix(src1, dstptr + dst_index0);
storepix(src0, dstptr + dst_index1);
src_index0 += src_step;
src_index1 -= src_step;
dst_index0 += dst_step;
dst_index1 -= dst_step;
}
}
}
__kernel void arithm_flip_cols(__global const uchar * srcptr, int src_step, int src_offset,
__global uchar * dstptr, int dst_step, int dst_offset,
int rows, int cols, int thread_rows, int thread_cols)
{
int x = get_global_id(0);
int y0 = get_global_id(1)*PIX_PER_WI_Y;
if (x < thread_cols)
{
int src_index0 = mad24(y0, src_step, mad24(x, TSIZE, src_offset));
int src_index1 = mad24(y0, src_step, mad24(cols - x - 1, TSIZE, src_offset));
int dst_index0 = mad24(y0, dst_step, mad24(x, TSIZE, dst_offset));
int dst_index1 = mad24(y0, dst_step, mad24(cols - x - 1, TSIZE, dst_offset));
#pragma unroll
for (int y = y0, y1 = min(rows, y0 + PIX_PER_WI_Y); y < y1; ++y)
{
T src0 = loadpix(srcptr + src_index0);
T src1 = loadpix(srcptr + src_index1);
#if kercn == 2
#if cn == 1
src0 = src0.s10;
src1 = src1.s10;
#endif
#elif kercn == 4
#if cn == 1
src0 = src0.s3210;
src1 = src1.s3210;
#elif cn == 2
src0 = src0.s2301;
src1 = src1.s2301;
#endif
#endif
storepix(src1, dstptr + dst_index0);
storepix(src0, dstptr + dst_index1);
src_index0 += src_step;
src_index1 += src_step;
dst_index0 += dst_step;
dst_index1 += dst_step;
}
}
}


// buildOptions=-D T=ushort3 -D T1=ushort -D cn=3 -D PIX_PER_WI_Y=4 -D kercn=3 -D INTEL_DEVICE
// RUN: %occ-cli %s --cl-options="-I%cwd -I%S -D T=ushort3 -D T1=ushort -D cn=3 -D PIX_PER_WI_Y=4 -D kercn=3 -D INTEL_DEVICE" %cfg_path --cl-device=%cl_device 2>&1
