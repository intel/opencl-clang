#ifdef BORDER_CONSTANT
#define EXTRAPOLATE(x, maxV)
#elif defined BORDER_REPLICATE
#define EXTRAPOLATE(x, maxV) \
{ \
(x) = clamp((x), 0, (maxV)-1); \
}
#elif defined BORDER_WRAP
#define EXTRAPOLATE(x, maxV) \
{ \
(x) = ( (x) + (maxV) ) % (maxV); \
}
#elif defined BORDER_REFLECT
#define EXTRAPOLATE(x, maxV) \
{ \
(x) = min(((maxV)-1)*2-(x)+1, max((x),-(x)-1) ); \
}
#elif defined BORDER_REFLECT_101 || defined BORDER_REFLECT101
#define EXTRAPOLATE(x, maxV) \
{ \
(x) = min(((maxV)-1)*2-(x), max((x),-(x)) ); \
}
#else
#error No extrapolation method
#endif
#if CN != 3
#define loadpix(addr) *(__global const srcT *)(addr)
#define storepix(val, addr)  *(__global dstT *)(addr) = val
#define SRCSIZE (int)sizeof(srcT)
#define DSTSIZE (int)sizeof(dstT)
#else
#define loadpix(addr)  vload3(0, (__global const srcT1 *)(addr))
#define storepix(val, addr) vstore3(val, 0, (__global dstT1 *)(addr))
#define SRCSIZE (int)sizeof(srcT1)*3
#define DSTSIZE (int)sizeof(dstT1)*3
#endif
#define SRC(_x,_y) convertToWT(loadpix(Src + mad24(_y, src_step, SRCSIZE * _x)))
#ifdef BORDER_CONSTANT
#define ELEM(_x,_y,r_edge,t_edge,const_v) (_x)<0 | (_x) >= (r_edge) | (_y)<0 | (_y) >= (t_edge) ? (const_v) : SRC((_x),(_y))
#else
#define ELEM(_x,_y,r_edge,t_edge,const_v) SRC((_x),(_y))
#endif
#define noconvert
#define DIG(a) a,
__constant WT1 mat_kernelX[] = { KERNEL_MATRIX_X };
__constant WT1 mat_kernelY[] = { KERNEL_MATRIX_Y };
__kernel void sep_filter(__global uchar* Src, int src_step, int srcOffsetX, int srcOffsetY, int height, int width,
__global uchar* Dst, int dst_step, int dst_offset, int dst_rows, int dst_cols, float delta)
{
__local WT lsmem[BLK_Y + 2 * RADIUSY][BLK_X + 2 * RADIUSX];
__local WT lsmemDy[BLK_Y][BLK_X + 2 * RADIUSX];
int lix = get_local_id(0);
int liy = get_local_id(1);
int x = get_global_id(0);
int srcX = x + srcOffsetX - RADIUSX;
int clocY = liy;
do
{
int yb = clocY + srcOffsetY - RADIUSY;
EXTRAPOLATE(yb, (height));
int clocX = lix;
int cSrcX = srcX;
do
{
int xb = cSrcX;
EXTRAPOLATE(xb,(width));
lsmem[clocY][clocX] = ELEM(xb, yb, (width), (height), 0 );
clocX += BLK_X;
cSrcX += BLK_X;
}
while(clocX < BLK_X+(RADIUSX*2));
clocY += BLK_Y;
}
while (clocY < BLK_Y+(RADIUSY*2));
barrier(CLK_LOCAL_MEM_FENCE);
for (int y = 0; y < dst_rows; y+=BLK_Y)
{
int i, clocX = lix;
WT sum = (WT) 0;
do
{
sum = (WT) 0;
for (i=0; i<=2*RADIUSY; i++)
#if (defined(INTEGER_ARITHMETIC) && !INTEL_DEVICE)
sum = mad24(lsmem[liy + i][clocX], mat_kernelY[i], sum);
#else
sum = mad(lsmem[liy + i][clocX], mat_kernelY[i], sum);
#endif
lsmemDy[liy][clocX] = sum;
clocX += BLK_X;
}
while(clocX < BLK_X+(RADIUSX*2));
barrier(CLK_LOCAL_MEM_FENCE);
if ((x < dst_cols) && (y + liy < dst_rows))
{
sum = 0.0f;
for (i=0; i<=2*RADIUSX; i++)
#if (defined(INTEGER_ARITHMETIC) && !INTEL_DEVICE)
sum = mad24(lsmemDy[liy][lix+i], mat_kernelX[i], sum);
#else
sum = mad(lsmemDy[liy][lix+i], mat_kernelX[i], sum);
#endif
#ifdef INTEGER_ARITHMETIC
#ifdef INTEL_DEVICE
sum = (sum + (1 << (SHIFT_BITS-1))) / (1 << SHIFT_BITS);
#else
sum = (sum + (1 << (SHIFT_BITS-1))) >> SHIFT_BITS;
#endif
#endif
storepix(convertToDstT(sum + (WT)(delta)), Dst + mad24(y + liy, dst_step, mad24(x, DSTSIZE, dst_offset)));
}
for (int i = liy * BLK_X + lix; i < (RADIUSY*2) * (BLK_X+(RADIUSX*2)); i += BLK_X * BLK_Y)
{
int clocX = i % (BLK_X+(RADIUSX*2));
int clocY = i / (BLK_X+(RADIUSX*2));
lsmem[clocY][clocX] = lsmem[clocY + BLK_Y][clocX];
}
barrier(CLK_LOCAL_MEM_FENCE);
int yb = y + liy + BLK_Y + srcOffsetY + RADIUSY;
EXTRAPOLATE(yb, (height));
clocX = lix;
int cSrcX = x + srcOffsetX - RADIUSX;
do
{
int xb = cSrcX;
EXTRAPOLATE(xb,(width));
lsmem[liy + 2*RADIUSY][clocX] = ELEM(xb, yb, (width), (height), 0 );
clocX += BLK_X;
cSrcX += BLK_X;
}
while(clocX < BLK_X+(RADIUSX*2));
barrier(CLK_LOCAL_MEM_FENCE);
}
}


// buildOptions=-D BLK_X=16 -D BLK_Y=8 -D RADIUSX=3 -D RADIUSY=4 -D KERNEL_MATRIX_X=DIG(-0.02230604738f)DIG(0.2124560773f)DIG(-0.2290304899f)DIG(0.08035211265f)DIG(-0.1796571612f)DIG(0.2580593526f)DIG(0.01813877001f) -D KERNEL_MATRIX_Y=DIG(-0.06147346646f)DIG(-0.07180448622f)DIG(0.1147519723f)DIG(-0.1352790445f)DIG(-0.1516204625f)DIG(-0.1217835024f)DIG(-0.1543113738f)DIG(-0.1373673230f)DIG(-0.05160841346f) -D srcT=uchar2 -D convertToWT=convert_float2 -D WT=float2 -D dstT=uchar2 -D convertToDstT=convert_uchar2_sat_rte -D BORDER_REPLICATE -D srcT1=uchar -D dstT1=uchar -D WT1=float -D CN=2 -D SHIFT_BITS=16 -D INTEL_DEVICE
// RUN: %occ-cli %s --cl-options="-I%cwd -I%S -D BLK_X=16 -D BLK_Y=8 -D RADIUSX=3 -D RADIUSY=4 -D KERNEL_MATRIX_X=DIG(-0.02230604738f)DIG(0.2124560773f)DIG(-0.2290304899f)DIG(0.08035211265f)DIG(-0.1796571612f)DIG(0.2580593526f)DIG(0.01813877001f) -D KERNEL_MATRIX_Y=DIG(-0.06147346646f)DIG(-0.07180448622f)DIG(0.1147519723f)DIG(-0.1352790445f)DIG(-0.1516204625f)DIG(-0.1217835024f)DIG(-0.1543113738f)DIG(-0.1373673230f)DIG(-0.05160841346f) -D srcT=uchar2 -D convertToWT=convert_float2 -D WT=float2 -D dstT=uchar2 -D convertToDstT=convert_uchar2_sat_rte -D BORDER_REPLICATE -D srcT1=uchar -D dstT1=uchar -D WT1=float -D CN=2 -D SHIFT_BITS=16 -D INTEL_DEVICE" %cfg_path --cl-device=%cl_device 2>&1
