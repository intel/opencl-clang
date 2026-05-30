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
#ifdef BORDER_ISOLATED
#define ISOLATED_MIN(VAL) (VAL)
#else
#define ISOLATED_MIN(VAL) 0
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
x = minX - (x - minX) - 1 + delta; \
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
y = minY - (y - minY) - 1 + delta; \
else \
y = maxY - 1 - (y - maxY) - delta; \
} \
while (y >= maxY || y < minY); \
}
#ifdef BORDER_REFLECT
#define EXTRAPOLATE(x, y, minX, minY, maxX, maxY) EXTRAPOLATE_(x, y, minX, minY, maxX, maxY, 0)
#elif defined(BORDER_REFLECT_101) || defined(BORDER_REFLECT101)
#define EXTRAPOLATE(x, y, minX, minY, maxX, maxY) EXTRAPOLATE_(x, y, minX, minY, maxX, maxY, 1)
#endif
#else
#error No extrapolation method
#endif
#else
#define EXTRAPOLATE(x, y, minX, minY, maxX, maxY) \
{ \
int _row = y - ISOLATED_MIN(minY), _col = x - ISOLATED_MIN(minX); \
_row = ADDR_H(_row, 0, maxY - ISOLATED_MIN(minY)); \
_row = ADDR_B(_row, maxY - ISOLATED_MIN(minY), _row); \
y = _row + ISOLATED_MIN(minY); \
\
_col = ADDR_L(_col, 0, maxX - ISOLATED_MIN(minX)); \
_col = ADDR_R(_col, maxX - ISOLATED_MIN(minX), _col); \
x = _col + ISOLATED_MIN(minX); \
}
#endif
#ifdef DOUBLE_SUPPORT
#ifdef cl_amd_fp64
#pragma OPENCL EXTENSION cl_amd_fp64:enable
#elif defined (cl_khr_fp64)
#pragma OPENCL EXTENSION cl_khr_fp64:enable
#endif
#endif
#if cn != 3
#define loadpix(addr) *(__global const srcT *)(addr)
#define storepix(val, addr)  *(__global dstT *)(addr) = val
#define SRCSIZE (int)sizeof(srcT)
#define DSTSIZE (int)sizeof(dstT)
#else
#define loadpix(addr) vload3(0, (__global const srcT1 *)(addr))
#define storepix(val, addr) vstore3(val, 0, (__global dstT1 *)(addr))
#define SRCSIZE (int)sizeof(srcT1) * cn
#define DSTSIZE (int)sizeof(dstT1) * cn
#endif
#define noconvert
struct RectCoords
{
int x1, y1, x2, y2;
};
#ifdef BORDER_ISOLATED
inline bool isBorder(const struct RectCoords bounds, int2 coord, int numPixels)
{
return (coord.x < bounds.x1 || coord.y < bounds.y1 || coord.x + numPixels > bounds.x2 || coord.y >= bounds.y2);
}
#else
inline bool isBorder(const struct RectCoords bounds, int2 coord, int numPixels)
{
return (coord.x < 0 || coord.y < 0 || coord.x + numPixels > bounds.x2 || coord.y >= bounds.y2);
}
#endif
inline WT getBorderPixel(const struct RectCoords bounds, int2 coord,
__global const uchar* srcptr, int srcstep)
{
#ifdef BORDER_CONSTANT
return (WT)(0);
#else
int selected_col = coord.x;
int selected_row = coord.y;
EXTRAPOLATE(selected_col, selected_row,
bounds.x1, bounds.y1,
bounds.x2, bounds.y2
);
coord = (int2)(selected_col, selected_row);
__global const uchar* ptr = srcptr + mul24(coord.y, srcstep) +
coord.x * SRCSIZE;
return convertToWT(loadpix(ptr));
#endif
}
inline WT readSrcPixelSingle(int2 pos, __global const uchar* srcptr,
int srcstep, const struct RectCoords srcCoords)
{
if (!isBorder(srcCoords, pos, 1))
{
__global const uchar* ptr = srcptr + mul24(pos.y, srcstep) +
pos.x * SRCSIZE;
return convertToWT(loadpix(ptr));
}
else
{
return getBorderPixel(srcCoords, pos, srcptr, srcstep);
}
}
#define __CAT(x, y) x##y
#define CAT(x, y) __CAT(x, y)
#define vload1(OFFSET, PTR) (*(PTR + OFFSET))
#define PX_LOAD_VEC_TYPE CAT(srcT1, PX_LOAD_VEC_SIZE)
#define PX_LOAD_FLOAT_VEC_TYPE CAT(WT1, PX_LOAD_VEC_SIZE)
#if PX_LOAD_VEC_SIZE == 1
#define PX_LOAD_FLOAT_VEC_CONV (float)
#elif PX_LOAD_VEC_SIZE == 2
#define PX_LOAD_FLOAT_VEC_CONV convert_float2
#elif PX_LOAD_VEC_SIZE == 3
#define PX_LOAD_FLOAT_VEC_CONV convert_float3
#elif PX_LOAD_VEC_SIZE == 4
#define PX_LOAD_FLOAT_VEC_CONV convert_float4
#endif
#define PX_LOAD CAT(vload, PX_LOAD_VEC_SIZE)
#define float1 float
inline PX_LOAD_FLOAT_VEC_TYPE readSrcPixelGroup(int2 pos, __global const uchar* srcptr,
int srcstep, const struct RectCoords srcCoords)
{
__global const srcT1* ptr = (__global const srcT1*)
(srcptr + mul24(pos.y, srcstep) +
pos.x * SRCSIZE);
return PX_LOAD_FLOAT_VEC_CONV(PX_LOAD(0, ptr));
}
#define LOOP1(VAR, STMT) (STMT); (VAR)++;
#define LOOP2(VAR, STMT) LOOP1(VAR, STMT); (STMT); (VAR)++;
#define LOOP3(VAR, STMT) LOOP2(VAR, STMT); (STMT); (VAR)++;
#define LOOP4(VAR, STMT) LOOP3(VAR, STMT); (STMT); (VAR)++;
#define LOOP5(VAR, STMT) LOOP4(VAR, STMT); (STMT); (VAR)++;
#define LOOP6(VAR, STMT) LOOP5(VAR, STMT); (STMT); (VAR)++;
#define LOOP7(VAR, STMT) LOOP6(VAR, STMT); (STMT); (VAR)++;
#define LOOP8(VAR, STMT) LOOP7(VAR, STMT); (STMT); (VAR)++;
#define LOOP9(VAR, STMT) LOOP8(VAR, STMT); (STMT); (VAR)++;
#define LOOP10(VAR, STMT) LOOP9(VAR, STMT); (STMT); (VAR)++;
#define LOOP11(VAR, STMT) LOOP10(VAR, STMT); (STMT); (VAR)++;
#define LOOP12(VAR, STMT) LOOP11(VAR, STMT); (STMT); (VAR)++;
#define LOOP13(VAR, STMT) LOOP12(VAR, STMT); (STMT); (VAR)++;
#define LOOP(N, VAR, STMT) CAT(LOOP, N)((VAR), (STMT))
#define DIG(a) a,
__constant WT1 kernelData[] = { COEFF };
__kernel void filter2DSmall(__global const uchar * srcptr, int src_step, int srcOffsetX, int srcOffsetY, int srcEndX, int srcEndY,
__global uchar * dstptr, int dst_step, int dst_offset, int rows, int cols, float delta)
{
const struct RectCoords srcCoords = { srcOffsetX, srcOffsetY, srcEndX, srcEndY };
const int startX = get_global_id(0) * PX_PER_WI_X;
const int startY = get_global_id(1) * PX_PER_WI_Y;
if ((startX >= cols) || (startY >= rows))
{
return;
}
WT privateData[PX_PER_WI_Y + KERNEL_SIZE_Y - 1][PRIV_DATA_WIDTH];
int py = 0;
LOOP(PX_LOAD_Y_ITERATIONS, py,
{
int y = startY + py;
int px = 0;
LOOP(PX_LOAD_X_ITERATIONS, px,
{
int x = startX + (px * PX_LOAD_NUM_PX);
int2 srcPos = (int2)(srcCoords.x1 + x - ANCHOR_X, srcCoords.y1 + y - ANCHOR_Y);
if (!isBorder(srcCoords, srcPos, PX_LOAD_NUM_PX))
{
PX_LOAD_FLOAT_VEC_TYPE p = readSrcPixelGroup(srcPos, srcptr, src_step, srcCoords);
*((PX_LOAD_FLOAT_VEC_TYPE*)&privateData[py][px * PX_LOAD_NUM_PX]) = p;
}
else
{
int lx = 0;
LOOP(PX_LOAD_NUM_PX, lx,
{
WT p = readSrcPixelSingle(srcPos, srcptr, src_step, srcCoords);
*((WT*)&privateData[py][px * PX_LOAD_NUM_PX + lx]) = p;
srcPos.x++;
});
}
});
});
py = 0;
LOOP(PX_PER_WI_Y, py,
{
int y = startY + py;
int px = 0;
LOOP(PX_PER_WI_X, px,
{
int x = startX + px;
WT total_sum = 0;
int sy = 0;
int kernelIndex = 0;
LOOP(KERNEL_SIZE_Y, sy,
{
int sx = 0;
LOOP(KERNEL_SIZE_X, sx,
{
total_sum = mad(kernelData[kernelIndex++], privateData[py + sy][px + sx], total_sum);
});
});
__global dstT* dstPtr = (__global dstT*)(dstptr + y * dst_step + dst_offset + x * DSTSIZE);
storepix(convertToDstT(total_sum + (WT)(delta)), dstPtr);
});
});
}


// buildOptions=-D cn=3 -D ANCHOR_X=1 -D ANCHOR_Y=1 -D KERNEL_SIZE_X=3 -D KERNEL_SIZE_Y=3 -D PX_LOAD_VEC_SIZE=3 -D PX_LOAD_NUM_PX=1 -D PX_PER_WI_X=1 -D PX_PER_WI_Y=1 -D PRIV_DATA_WIDTH=3 -D BORDER_REFLECT -D NO_BORDER_ISOLATED -D PX_LOAD_X_ITERATIONS=3 -D PX_LOAD_Y_ITERATIONS=3 -D srcT=uchar3 -D srcT1=uchar -D dstT=uchar3 -D dstT1=uchar -D WT=float3 -D WT1=float -D convertToWT=convert_float3 -D convertToDstT=convert_uchar3_sat_rte  -D COEFF=DIG(2.000000000f)DIG(0.0000000000f)DIG(2.000000000f)DIG(0.0000000000f)DIG(-8.000000000f)DIG(0.0000000000f)DIG(2.000000000f)DIG(0.0000000000f)DIG(2.000000000f) -D INTEL_DEVICE
// RUN: %occ-cli %s --cl-options="-I%cwd -I%S -D cn=3 -D ANCHOR_X=1 -D ANCHOR_Y=1 -D KERNEL_SIZE_X=3 -D KERNEL_SIZE_Y=3 -D PX_LOAD_VEC_SIZE=3 -D PX_LOAD_NUM_PX=1 -D PX_PER_WI_X=1 -D PX_PER_WI_Y=1 -D PRIV_DATA_WIDTH=3 -D BORDER_REFLECT -D NO_BORDER_ISOLATED -D PX_LOAD_X_ITERATIONS=3 -D PX_LOAD_Y_ITERATIONS=3 -D srcT=uchar3 -D srcT1=uchar -D dstT=uchar3 -D dstT1=uchar -D WT=float3 -D WT1=float -D convertToWT=convert_float3 -D convertToDstT=convert_uchar3_sat_rte  -D COEFF=DIG(2.000000000f)DIG(0.0000000000f)DIG(2.000000000f)DIG(0.0000000000f)DIG(-8.000000000f)DIG(0.0000000000f)DIG(2.000000000f)DIG(0.0000000000f)DIG(2.000000000f) -D INTEL_DEVICE" %cfg_path --cl-device=%cl_device 2>&1
