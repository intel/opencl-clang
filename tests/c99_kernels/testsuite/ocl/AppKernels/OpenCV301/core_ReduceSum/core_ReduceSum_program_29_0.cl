#ifdef DOUBLE_SUPPORT
#ifdef cl_amd_fp64
#pragma OPENCL EXTENSION cl_amd_fp64:enable
#elif defined (cl_khr_fp64)
#pragma OPENCL EXTENSION cl_khr_fp64:enable
#endif
#endif
#if ddepth == 0
#define MIN_VAL 0
#define MAX_VAL 255
#elif ddepth == 1
#define MIN_VAL -128
#define MAX_VAL 127
#elif ddepth == 2
#define MIN_VAL 0
#define MAX_VAL 65535
#elif ddepth == 3
#define MIN_VAL -32768
#define MAX_VAL 32767
#elif ddepth == 4
#define MIN_VAL INT_MIN
#define MAX_VAL INT_MAX
#elif ddepth == 5
#define MIN_VAL (-FLT_MAX)
#define MAX_VAL FLT_MAX
#elif ddepth == 6
#define MIN_VAL (-DBL_MAX)
#define MAX_VAL DBL_MAX
#else
#error "Unsupported depth"
#endif
#define noconvert
#if defined OCL_CV_REDUCE_SUM || defined OCL_CV_REDUCE_AVG
#define INIT_VALUE 0
#define PROCESS_ELEM(acc, value) acc += value
#elif defined OCL_CV_REDUCE_MAX
#define INIT_VALUE MIN_VAL
#define PROCESS_ELEM(acc, value) acc = max(value, acc)
#elif defined OCL_CV_REDUCE_MIN
#define INIT_VALUE MAX_VAL
#define PROCESS_ELEM(acc, value) acc = min(value, acc)
#else
#error "No operation is specified"
#endif
#ifdef OP_REDUCE_PRE
__kernel void reduce_horz_opt(__global const uchar * srcptr, int src_step, int src_offset, int rows, int cols,
__global uchar * dstptr, int dst_step, int dst_offset
#ifdef OCL_CV_REDUCE_AVG
, float fscale
#endif
)
{
__local bufT lsmem[TILE_HEIGHT][BUF_COLS][cn];
int x = get_global_id(0);
int y = get_global_id(1);
int liy = get_local_id(1);
if ((x < BUF_COLS) && (y < rows))
{
int src_index = mad24(y, src_step, mad24(x, (int)sizeof(srcT) * cn, src_offset));
__global const srcT * src = (__global const srcT *)(srcptr + src_index);
bufT tmp[cn];
#pragma unroll
for (int c = 0; c < cn; ++c)
tmp[c] = INIT_VALUE;
int src_step_mul = BUF_COLS * cn;
for (int idx = x; idx < cols; idx += BUF_COLS, src += src_step_mul)
{
#pragma unroll
for (int c = 0; c < cn; ++c)
{
bufT value = convertToBufT(src[c]);
PROCESS_ELEM(tmp[c], value);
}
}
#pragma unroll
for (int c = 0; c < cn; ++c)
lsmem[liy][x][c] = tmp[c];
}
barrier(CLK_LOCAL_MEM_FENCE);
if ((x < BUF_COLS / 2) && (y < rows))
{
#pragma unroll
for (int c = 0; c < cn; ++c)
{
PROCESS_ELEM(lsmem[liy][x][c], lsmem[liy][x +  BUF_COLS / 2][c]);
}
}
barrier(CLK_LOCAL_MEM_FENCE);
if ((x == 0) && (y < rows))
{
int dst_index = mad24(y, dst_step, dst_offset);
__global dstT * dst = (__global dstT *)(dstptr + dst_index);
bufT tmp[cn];
#pragma unroll
for (int c = 0; c < cn; ++c)
tmp[c] = INIT_VALUE;
#pragma unroll
for (int xin = 0; xin < BUF_COLS / 2; xin ++)
{
#pragma unroll
for (int c = 0; c < cn; ++c)
{
PROCESS_ELEM(tmp[c], lsmem[liy][xin][c]);
}
}
#pragma unroll
for (int c = 0; c < cn; ++c)
#ifdef OCL_CV_REDUCE_AVG
dst[c] = convertToDT(convertToWT(tmp[c]) * fscale);
#else
dst[c] = convertToDT(tmp[c]);
#endif
}
}
#else
__kernel void reduce(__global const uchar * srcptr, int src_step, int src_offset, int rows, int cols,
__global uchar * dstptr, int dst_step, int dst_offset
#ifdef OCL_CV_REDUCE_AVG
, float fscale
#endif
)
{
#if dim == 0
int x = get_global_id(0);
if (x < cols)
{
int src_index = mad24(x, (int)sizeof(srcT) * cn, src_offset);
int dst_index = mad24(x, (int)sizeof(dstT0) * cn, dst_offset);
__global dstT0 * dst = (__global dstT0 *)(dstptr + dst_index);
dstT tmp[cn];
#pragma unroll
for (int c = 0; c < cn; ++c)
tmp[c] = INIT_VALUE;
for (int y = 0; y < rows; ++y, src_index += src_step)
{
__global const srcT * src = (__global const srcT *)(srcptr + src_index);
#pragma unroll
for (int c = 0; c < cn; ++c)
{
dstT value = convertToDT(src[c]);
PROCESS_ELEM(tmp[c], value);
}
}
#pragma unroll
for (int c = 0; c < cn; ++c)
#ifdef OCL_CV_REDUCE_AVG
dst[c] = convertToDT0(convertToWT(tmp[c]) * fscale);
#else
dst[c] = convertToDT0(tmp[c]);
#endif
}
#elif dim == 1
int y = get_global_id(0);
if (y < rows)
{
int src_index = mad24(y, src_step, src_offset);
int dst_index = mad24(y, dst_step, dst_offset);
__global const srcT * src = (__global const srcT *)(srcptr + src_index);
__global dstT * dst = (__global dstT *)(dstptr + dst_index);
dstT tmp[cn];
#pragma unroll
for (int c = 0; c < cn; ++c)
tmp[c] = INIT_VALUE;
for (int x = 0; x < cols; ++x, src += cn)
{
#pragma unroll
for (int c = 0; c < cn; ++c)
{
dstT value = convertToDT(src[c]);
PROCESS_ELEM(tmp[c], value);
}
}
#pragma unroll
for (int c = 0; c < cn; ++c)
#ifdef OCL_CV_REDUCE_AVG
dst[c] = convertToDT0(convertToWT(tmp[c]) * fscale);
#else
dst[c] = convertToDT0(tmp[c]);
#endif
}
#else
#error "Dims must be either 0 or 1"
#endif
}
#endif


// buildOptions=-D OCL_CV_REDUCE_SUM -D dim=0 -D cn=3 -D ddepth=5 -D srcT=short -D dstT=float -D dstT0=float -D convertToWT=noconvert -D convertToDT=convert_float -D convertToDT0=noconvert -D INTEL_DEVICE
// RUN: %occ-cli %s --cl-options="-I%cwd -I%S -D OCL_CV_REDUCE_SUM -D dim=0 -D cn=3 -D ddepth=5 -D srcT=short -D dstT=float -D dstT0=float -D convertToWT=noconvert -D convertToDT=convert_float -D convertToDT0=noconvert -D INTEL_DEVICE" %cfg_path --cl-device=%cl_device 2>&1
