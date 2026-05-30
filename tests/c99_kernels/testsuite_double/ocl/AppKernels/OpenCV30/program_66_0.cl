#ifdef BORDER_REPLICATE
#define ADDR_L(i, l_edge, r_edge)  ((i) <  (l_edge) ? (l_edge)   : (i))
#define ADDR_R(i, r_edge, addr)    ((i) >= (r_edge) ? (r_edge)-1 : (addr))
#define ADDR_H(i, t_edge, b_edge)  ((i) <  (t_edge) ? (t_edge)   :(i))
#define ADDR_B(i, b_edge, addr)    ((i) >= (b_edge) ? (b_edge)-1 :(addr))
#endif
#ifdef BORDER_REFLECT
#define ADDR_L(i, l_edge, r_edge)  ((i) <  (l_edge) ? -(i)-1               : (i))
#define ADDR_R(i, r_edge, addr)    ((i) >= (r_edge) ? -(i)-1+((r_edge)<<1) : (addr))
#define ADDR_H(i, t_edge, b_edge)  ((i) <  (t_edge) ? -(i)-1 : (i))
#define ADDR_B(i, b_edge, addr)    ((i) >= (b_edge) ? -(i)-1+((b_edge)<<1) : (addr))
#endif
#ifdef BORDER_REFLECT_101
#define ADDR_L(i, l_edge, r_edge)  ((i) <  (l_edge) ? -(i)                 : (i))
#define ADDR_R(i, r_edge, addr)    ((i) >= (r_edge) ? -(i)-2+((r_edge)<<1) : (addr))
#define ADDR_H(i, t_edge, b_edge)  ((i) <  (t_edge) ? -(i)                 : (i))
#define ADDR_B(i, b_edge, addr)    ((i) >= (b_edge) ? -(i)-2+((b_edge)<<1) : (addr))
#endif
#ifdef BORDER_WRAP
#define ADDR_L(i, l_edge, r_edge)  ((i) <  (l_edge) ? (i)+(r_edge) : (i))
#define ADDR_R(i, r_edge, addr)    ((i) >= (r_edge) ? (i)-(r_edge) : (addr))
#define ADDR_H(i, t_edge, b_edge)  ((i) <  (t_edge) ? (i)+(b_edge) : (i))
#define ADDR_B(i, b_edge, addr)    ((i) >= (b_edge) ? (i)-(b_edge) : (addr))
#endif
#ifdef EXTRA_EXTRAPOLATION
#ifdef BORDER_CONSTANT
#elif defined BORDER_REPLICATE
#define EXTRAPOLATE(x, y, minX, minY, maxX, maxY) \
{ \
x = max(min(x, maxX - 1), minX); \
y = max(min(y, maxY - 1), minY); \
}
#elif defined BORDER_WRAP
#define EXTRAPOLATE(x, y, minX, minY, maxX, maxY) \
{ \
if (x < minX) \
x -= ((x - maxX + 1) / maxX) * maxX; \
if (x >= maxX) \
x %= maxX; \
if (y < minY) \
y -= ((y - maxY + 1) / maxY) * maxY; \
if (y >= maxY) \
y %= maxY; \
}
#elif defined(BORDER_REFLECT) || defined(BORDER_REFLECT_101)
#define EXTRAPOLATE_(x, y, minX, minY, maxX, maxY, delta) \
{ \
if (maxX - minX == 1) \
x = minX; \
else \
do \
{ \
if (x < minX) \
x = -(x - minX) - 1 + delta; \
else \
x = maxX - 1 - (x - maxX) - delta; \
} \
while (x >= maxX || x < minX); \
\
if (maxY - minY == 1) \
y = minY; \
else \
do \
{ \
if (y < minY) \
y = -(y - minY) - 1 + delta; \
else \
y = maxY - 1 - (y - maxY) - delta; \
} \
while (y >= maxY || y < minY); \
}
#ifdef BORDER_REFLECT
#define EXTRAPOLATE(x, y, minX, minY, maxX, maxY) EXTRAPOLATE_(x, y, minX, minY, maxX, maxY, 0)
#elif defined(BORDER_REFLECT_101)
#define EXTRAPOLATE(x, y, minX, minY, maxX, maxY) EXTRAPOLATE_(x, y, minX, minY, maxX, maxY, 1)
#endif
#else
#error No extrapolation method
#endif
#else
#define EXTRAPOLATE(x, y, minX, minY, maxX, maxY) \
{ \
int _row = y - minY, _col = x - minX; \
_row = ADDR_H(_row, 0, maxY - minY); \
_row = ADDR_B(_row, maxY - minY, _row); \
y = _row + minY; \
\
_col = ADDR_L(_col, 0, maxX - minX); \
_col = ADDR_R(_col, maxX - minX, _col); \
x = _col + minX; \
}
#endif
#if USE_DOUBLE
#ifdef cl_amd_fp64
#pragma OPENCL EXTENSION cl_amd_fp64:enable
#elif defined (cl_khr_fp64)
#pragma OPENCL EXTENSION cl_khr_fp64:enable
#endif
#define FPTYPE double
#define CONVERT_TO_FPTYPE CAT(convert_double, VEC_SIZE)
#else
#define FPTYPE float
#define CONVERT_TO_FPTYPE CAT(convert_float, VEC_SIZE)
#endif
#if DATA_DEPTH == 0
#define BASE_TYPE uchar
#elif DATA_DEPTH == 1
#define BASE_TYPE char
#elif DATA_DEPTH == 2
#define BASE_TYPE ushort
#elif DATA_DEPTH == 3
#define BASE_TYPE short
#elif DATA_DEPTH == 4
#define BASE_TYPE int
#elif DATA_DEPTH == 5
#define BASE_TYPE float
#elif DATA_DEPTH == 6
#define BASE_TYPE double
#else
#error data_depth
#endif
#define __CAT(x, y) x##y
#define CAT(x, y) __CAT(x, y)
#define uchar1 uchar
#define char1 char
#define ushort1 ushort
#define short1 short
#define int1 int
#define float1 float
#define double1 double
#define convert_uchar1_sat_rte convert_uchar_sat_rte
#define convert_char1_sat_rte convert_char_sat_rte
#define convert_ushort1_sat_rte convert_ushort_sat_rte
#define convert_short1_sat_rte convert_short_sat_rte
#define convert_int1_sat_rte convert_int_sat_rte
#define convert_float1
#define convert_double1
#if DATA_DEPTH == 5 || DATA_DEPTH == 6
#define CONVERT_TO_TYPE CAT(CAT(convert_, BASE_TYPE), VEC_SIZE)
#else
#define CONVERT_TO_TYPE CAT(CAT(CAT(convert_, BASE_TYPE), VEC_SIZE), _sat_rte)
#endif
#define VEC_SIZE DATA_CHAN
#define VEC_TYPE CAT(BASE_TYPE, VEC_SIZE)
#define TYPE VEC_TYPE
#define SCALAR_TYPE CAT(FPTYPE, VEC_SIZE)
#define INTERMEDIATE_TYPE CAT(FPTYPE, VEC_SIZE)
struct RectCoords
{
int x1, y1, x2, y2;
};
#ifdef DEBUG
#define DEBUG_ONLY(x) x
#define ASSERT(condition) do { if (!(condition)) { printf("BUG in boxFilter kernel (global=%d,%d): " #condition "\n", get_global_id(0), get_global_id(1)); } } while (0)
#else
#define DEBUG_ONLY(x) (void)0
#define ASSERT(condition) (void)0
#endif
inline INTERMEDIATE_TYPE readSrcPixel(int2 pos, __global TYPE *src, const unsigned int srcStepBytes, const struct RectCoords srcCoords
#ifdef BORDER_CONSTANT
, SCALAR_TYPE borderValue
#endif
)
{
#ifdef BORDER_ISOLATED
if(pos.x >= srcCoords.x1 && pos.y >= srcCoords.y1 && pos.x < srcCoords.x2 && pos.y < srcCoords.y2)
#else
if(pos.x >= 0 && pos.y >= 0 && pos.x < srcCoords.x2 && pos.y < srcCoords.y2)
#endif
{
__global TYPE* ptr = (__global TYPE*)((__global char*)src + pos.x * sizeof(TYPE) + pos.y * srcStepBytes);
return CONVERT_TO_FPTYPE(*ptr);
}
else
{
#ifdef BORDER_CONSTANT
return borderValue;
#else
int selected_col = pos.x;
int selected_row = pos.y;
EXTRAPOLATE(selected_col, selected_row,
#ifdef BORDER_ISOLATED
srcCoords.x1, srcCoords.y1,
#else
0, 0,
#endif
srcCoords.x2, srcCoords.y2
);
pos = (int2)(selected_col, selected_row);
if(pos.x >= 0 && pos.y >= 0 && pos.x < srcCoords.x2 && pos.y < srcCoords.y2)
{
__global TYPE* ptr = (__global TYPE*)((__global char*)src + pos.x * sizeof(TYPE) + pos.y * srcStepBytes);
return CONVERT_TO_FPTYPE(*ptr);
}
else
{
DEBUG_ONLY(printf("BUG in boxFilter kernel\n"));
return (FPTYPE)(0.0f);
}
#endif
}
}
__kernel
__attribute__((reqd_work_group_size(LOCAL_SIZE, 1, 1)))
void filter2D(__global TYPE *src, const unsigned int srcStepBytes, const int4 srcRC,
__global TYPE *dst, const unsigned int dstStepBytes, const int4 dstRC,
#ifdef BORDER_CONSTANT
SCALAR_TYPE borderValue,
#endif
__constant FPTYPE* kernelData
)
{
const struct RectCoords srcCoords = {srcRC.s0, srcRC.s1, srcRC.s2, srcRC.s3};
struct RectCoords dstCoords = {dstRC.s0, dstRC.s1, dstRC.s2, dstRC.s3};
const int local_id = get_local_id(0);
const int x = local_id + (LOCAL_SIZE - (KERNEL_SIZE_X - 1)) * get_group_id(0) - ANCHOR_X;
const int y = get_global_id(1) * BLOCK_SIZE_Y;
INTERMEDIATE_TYPE data[KERNEL_SIZE_Y];
__local INTERMEDIATE_TYPE sumOfCols[LOCAL_SIZE];
int2 srcPos = (int2)(srcCoords.x1 + x, srcCoords.y1 + y - ANCHOR_Y);
int2 pos = (int2)(dstCoords.x1 + x, dstCoords.y1 + y);
__global TYPE* dstPtr = (__global TYPE*)((__global char*)dst + pos.x * sizeof(TYPE) + pos.y * dstStepBytes);
bool writeResult = (local_id >= ANCHOR_X && local_id < LOCAL_SIZE - (KERNEL_SIZE_X - 1 - ANCHOR_X) &&
pos.x >= dstCoords.x1 && pos.x < dstCoords.x2);
#if BLOCK_SIZE_Y > 1
bool readAllpixels = true;
int sy_index = 0;
dstCoords.y2 = min(dstCoords.y2, pos.y + BLOCK_SIZE_Y);
for (;
pos.y < dstCoords.y2;
pos.y++,
dstPtr = (__global TYPE*)((__global char*)dstPtr + dstStepBytes))
#endif
{
ASSERT(pos.y < dstCoords.y2);
for (
#if BLOCK_SIZE_Y > 1
int sy = readAllpixels ? 0 : -1; sy < (readAllpixels ? KERNEL_SIZE_Y : 0);
#else
int sy = 0, sy_index = 0; sy < KERNEL_SIZE_Y;
#endif
sy++, srcPos.y++)
{
data[sy + sy_index] = readSrcPixel(srcPos, src, srcStepBytes, srcCoords
#ifdef BORDER_CONSTANT
, borderValue
#endif
);
}
INTERMEDIATE_TYPE total_sum = 0;
for (int sx = 0; sx < KERNEL_SIZE_X; sx++)
{
{
__constant FPTYPE* k = &kernelData[KERNEL_SIZE_Y2_ALIGNED * sx
#if BLOCK_SIZE_Y > 1
+ KERNEL_SIZE_Y - sy_index
#endif
];
INTERMEDIATE_TYPE tmp_sum = 0;
for (int sy = 0; sy < KERNEL_SIZE_Y; sy++)
{
tmp_sum += data[sy] * k[sy];
}
sumOfCols[local_id] = tmp_sum;
barrier(CLK_LOCAL_MEM_FENCE);
}
int id = local_id + sx - ANCHOR_X;
if (id >= 0 && id < LOCAL_SIZE)
total_sum += sumOfCols[id];
barrier(CLK_LOCAL_MEM_FENCE);
}
if (writeResult)
{
ASSERT(pos.y >= dstCoords.y1 && pos.y < dstCoords.y2);
*dstPtr = CONVERT_TO_TYPE(total_sum);
}
#if BLOCK_SIZE_Y > 1
readAllpixels = false;
#if BLOCK_SIZE_Y > KERNEL_SIZE_Y
sy_index = (sy_index + 1 <= KERNEL_SIZE_Y) ? sy_index + 1 : 1;
#else
sy_index++;
#endif
#endif
}
}


// buildOptions= -D INTEL_DEVICE -D LOCAL_SIZE=256 -D BLOCK_SIZE_Y=1 -D DATA_DEPTH=0 -D DATA_CHAN=1 -D USE_DOUBLE=0 -D ANCHOR_X=1 -D ANCHOR_Y=1 -D KERNEL_SIZE_X=3 -D KERNEL_SIZE_Y=3 -D KERNEL_SIZE_Y2_ALIGNED=8 -D BORDER_REFLECT_101 -D NO_EXTRA_EXTRAPOLATION -D NO_BORDER_ISOLATED
// RUN: %occ-cli %s --cl-options="-I%cwd -I%S  -D INTEL_DEVICE -D LOCAL_SIZE=256 -D BLOCK_SIZE_Y=1 -D DATA_DEPTH=0 -D DATA_CHAN=1 -D USE_DOUBLE=0 -D ANCHOR_X=1 -D ANCHOR_Y=1 -D KERNEL_SIZE_X=3 -D KERNEL_SIZE_Y=3 -D KERNEL_SIZE_Y2_ALIGNED=8 -D BORDER_REFLECT_101 -D NO_EXTRA_EXTRAPOLATION -D NO_BORDER_ISOLATED" %cfg_path --cl-device=%cl_device 2>&1
