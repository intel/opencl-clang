#ifdef BORDER_CONSTANT
#define EXTRAPOLATE(x, maxV)
#elif defined BORDER_REPLICATE
#define EXTRAPOLATE(x, maxV) \
{ \
(x) = max(min((x), (maxV) - 1), 0); \
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
#elif defined BORDER_REFLECT_101
#define EXTRAPOLATE(x, maxV) \
{ \
(x) = min(((maxV)-1)*2-(x), max((x),-(x)) ); \
}
#else
#error No extrapolation method
#endif
#define SRC(_x,_y) CONVERT_SRCTYPE(((global SRCTYPE*)(Src+(_y)*SrcPitch))[_x])
#ifdef BORDER_CONSTANT
#define ELEM(_x,_y,r_edge,t_edge,const_v) (_x)<0 | (_x) >= (r_edge) | (_y)<0 | (_y) >= (t_edge) ? (const_v) : SRC((_x),(_y))
#else
#define ELEM(_x,_y,r_edge,t_edge,const_v) SRC((_x),(_y))
#endif
#define DST(_x,_y) (((global DSTTYPE*)(Dst+DstOffset+(_y)*DstPitch))[_x])
__constant uint mat_kernelX[] = {KERNEL_MATRIX_X};
__constant uint mat_kernelY[] = {KERNEL_MATRIX_Y};
__kernel __attribute__((reqd_work_group_size(BLK_X,BLK_Y,1))) void sep_filter_singlepass
(
__global uchar* Src,
const uint      SrcPitch,
const int       srcOffsetX,
const int       srcOffsetY,
__global uchar* Dst,
const int       DstOffset,
const uint      DstPitch,
int             width,
int             height,
int             dstWidth,
int             dstHeight
)
{
__local WORKTYPE lsmem[BLK_Y+2*RADIUSY][BLK_X+2*RADIUSX];
__local WORKTYPE lsmemDy[BLK_Y][BLK_X+2*RADIUSX];
int lix = get_local_id(0);
int liy = get_local_id(1);
int x = (int)get_global_id(0);
int y = (int)get_global_id(1);
int srcX = x + srcOffsetX - RADIUSX;
int srcY = y + srcOffsetY - RADIUSY;
int xb = srcX;
int yb = srcY;
int clocY = liy;
int cSrcY = srcY;
do
{
int yb = cSrcY;
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
cSrcY += BLK_Y;
}
while(clocY < BLK_Y+(RADIUSY*2));
barrier(CLK_LOCAL_MEM_FENCE);
int i;
WORKTYPE sum = 0.0f;
int clocX = lix;
do
{
sum = 0.0f;
for(i=0; i<=2*RADIUSY; i++)
sum = mad(lsmem[liy+i][clocX], as_float(mat_kernelY[i]), sum);
lsmemDy[liy][clocX] = sum;
clocX += BLK_X;
}
while(clocX < BLK_X+(RADIUSX*2));
barrier(CLK_LOCAL_MEM_FENCE);
if( x >= dstWidth || y >=dstHeight )  return;
sum = 0.0f;
for(i=0; i<=2*RADIUSX; i++)
sum = mad(lsmemDy[liy][lix+i], as_float(mat_kernelX[i]), sum);
DST(x,y) = CONVERT_DSTTYPE(sum);
}


// buildOptions= -D INTEL_DEVICE -D BLK_X=16 -D BLK_Y=16 -D RADIUSX=1 -D RADIUSY=1 -D KERNEL_MATRIX_X=0xbf800000,0x0,0x3f800000,0x0 -D KERNEL_MATRIX_Y=0xbf800000,0x0,0x3f800000,0x0 -D SRCTYPE=uchar4 -D CONVERT_SRCTYPE=convert_float4 -D WORKTYPE=float4 -D DSTTYPE=uchar4 -D CONVERT_DSTTYPE=convert_uchar4_sat -D BORDER_REFLECT_101
// RUN: %occ-cli %s --cl-options="-I%cwd -I%S  -D INTEL_DEVICE -D BLK_X=16 -D BLK_Y=16 -D RADIUSX=1 -D RADIUSY=1 -D KERNEL_MATRIX_X=0xbf800000,0x0,0x3f800000,0x0 -D KERNEL_MATRIX_Y=0xbf800000,0x0,0x3f800000,0x0 -D SRCTYPE=uchar4 -D CONVERT_SRCTYPE=convert_float4 -D WORKTYPE=float4 -D DSTTYPE=uchar4 -D CONVERT_DSTTYPE=convert_uchar4_sat -D BORDER_REFLECT_101" %cfg_path --cl-device=%cl_device 2>&1
