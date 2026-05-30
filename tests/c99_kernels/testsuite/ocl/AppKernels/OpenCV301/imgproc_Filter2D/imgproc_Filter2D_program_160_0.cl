#ifdef EXTRA_EXTRAPOLATION
#ifdef BORDER_CONSTANT
#define EXTRAPOLATE(x, minV, maxV)
#elif defined BORDER_REPLICATE
#define EXTRAPOLATE(x, minV, maxV) \
{ \
(x) = clamp((x), (minV), (maxV)-1); \
}
#elif defined BORDER_WRAP
#define EXTRAPOLATE(x, minV, maxV) \
{ \
if ((x) < (minV)) \
(x) += ((maxV) - (minV)); \
if ((x) >= (maxV)) \
(x) -= ((maxV) - (minV)); \
}
#elif defined BORDER_REFLECT
#define EXTRAPOLATE(x, minV, maxV) \
{ \
if ((maxV) - (minV) == 1) \
(x) = (minV); \
else \
while ((x) >= (maxV) || (x) < (minV)) \
{ \
if ((x) < (minV)) \
(x) = (minV) - ((x) - (minV)) - 1; \
else \
(x) = (maxV) - 1 - ((x) - (maxV)); \
} \
}
#elif defined BORDER_REFLECT_101 || defined BORDER_REFLECT101
#define EXTRAPOLATE(x, minV, maxV) \
{ \
if ((maxV) - (minV) == 1) \
(x) = (minV); \
else \
while ((x) >= (maxV) || (x) < (minV)) \
{ \
if ((x) < (minV)) \
(x) = (minV) - ((x) - (minV)); \
else \
(x) = (maxV) - 1 - ((x) - (maxV)) - 1; \
} \
}
#else
#error No extrapolation method
#endif
#else
#ifdef BORDER_CONSTANT
#define EXTRAPOLATE(x, minV, maxV)
#elif defined BORDER_REPLICATE
#define EXTRAPOLATE(x, minV, maxV) \
{ \
(x) = clamp((x), (minV), (maxV)-1); \
}
#elif defined BORDER_WRAP
#define EXTRAPOLATE(x, minV, maxV) \
{ \
if ((x) < (minV)) \
(x) += (((minV) - (x)) / ((maxV) - (minV)) + 1) * ((maxV) - (minV)); \
if ((x) >= (maxV)) \
(x) = ((x) - (minV)) % ((maxV) - (minV)) + (minV); \
}
#elif defined BORDER_REFLECT
#define EXTRAPOLATE(x, minV, maxV) \
{ \
(x) = clamp((x), 2 * (minV) - (x) - 1, 2 * (maxV) - (x) - 1); \
}
#elif defined BORDER_REFLECT_101 || defined BORDER_REFLECT101
#define EXTRAPOLATE(x, minV, maxV) \
{ \
(x) = clamp((x), 2 * (minV) - (x), 2 * (maxV) - (x) - 2); \
}
#else
#error No extrapolation method
#endif
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
#define UPDATE_COLUMN_SUM(col) \
__constant WT1 * k = &kernelData[KERNEL_SIZE_Y2_ALIGNED * col]; \
WT tmp_sum = 0;                                                 \
for (int sy = 0; sy < KERNEL_SIZE_Y; sy++)                      \
tmp_sum += data[sy] * k[sy];                                \
sumOfCols[local_id] = tmp_sum;                                  \
barrier(CLK_LOCAL_MEM_FENCE);
#define UPDATE_TOTAL_SUM(col) \
int id = local_id + col - ANCHOR_X; \
if (id >= 0 && id < LOCAL_SIZE)     \
total_sum += sumOfCols[id];     \
barrier(CLK_LOCAL_MEM_FENCE);
#define noconvert
#define DIG(a) a,
__constant WT1 kernelData[] = { COEFF };
__kernel void filter2D(__global const uchar * srcptr, int src_step, int srcOffsetX, int srcOffsetY, int srcEndX, int srcEndY,
__global uchar * dstptr, int dst_step, int dst_offset, int rows, int cols, float delta)
{
int local_id = get_local_id(0);
int x = local_id + (LOCAL_SIZE - (KERNEL_SIZE_X - 1)) * get_group_id(0) - ANCHOR_X;
int y = get_global_id(1);
WT data[KERNEL_SIZE_Y];
__local WT sumOfCols[LOCAL_SIZE];
#ifdef BORDER_ISOLATED
int srcBeginX = srcOffsetX;
int srcBeginY = srcOffsetY;
#else
int srcBeginX = 0;
int srcBeginY = 0;
#endif
int srcX = srcOffsetX + x;
int srcY = srcOffsetY + y - ANCHOR_Y;
__global dstT *dst = (__global dstT *)(dstptr + mad24(y, dst_step, mad24(x, DSTSIZE, dst_offset)));
#ifdef BORDER_CONSTANT
if (srcX >= srcBeginX && srcX < srcEndX)
{
for (int sy = 0, sy_index = 0; sy < KERNEL_SIZE_Y; sy++, srcY++)
{
if (srcY >= srcBeginY && srcY < srcEndY)
data[sy + sy_index] = convertToWT(loadpix(srcptr + mad24(srcY, src_step, srcX * SRCSIZE)));
else
data[sy + sy_index] = (WT)(0);
}
}
else
{
for (int sy = 0, sy_index = 0; sy < KERNEL_SIZE_Y; sy++, srcY++)
{
data[sy + sy_index] = (WT)(0);
}
}
#else
EXTRAPOLATE(srcX, srcBeginX, srcEndX);
for (int sy = 0, sy_index = 0; sy < KERNEL_SIZE_Y; sy++, srcY++)
{
int tempY = srcY;
EXTRAPOLATE(tempY, srcBeginY, srcEndY);
data[sy + sy_index] = convertToWT(loadpix(srcptr + mad24(tempY, src_step, srcX * SRCSIZE)));
}
#endif
WT total_sum = 0;
for (int sx = 0; sx < ANCHOR_X; sx++)
{
UPDATE_COLUMN_SUM(sx);
UPDATE_TOTAL_SUM(sx);
}
__constant WT1 * k = &kernelData[KERNEL_SIZE_Y2_ALIGNED * ANCHOR_X];
for (int sy = 0; sy < KERNEL_SIZE_Y; sy++)
total_sum += data[sy] * k[sy];
for (int sx = ANCHOR_X + 1; sx < KERNEL_SIZE_X; sx++)
{
UPDATE_COLUMN_SUM(sx);
UPDATE_TOTAL_SUM(sx);
}
if (local_id >= ANCHOR_X && local_id < LOCAL_SIZE - (KERNEL_SIZE_X - 1 - ANCHOR_X) && x >= 0 && x < cols)
storepix(convertToDstT(total_sum + (WT)(delta)), dst);
}


// buildOptions=-D LOCAL_SIZE=128 -D cn=4 -D ANCHOR_X=2 -D ANCHOR_Y=4 -D KERNEL_SIZE_X=5 -D KERNEL_SIZE_Y=5 -D KERNEL_SIZE_Y2_ALIGNED=12 -D BORDER_REPLICATE -D EXTRA_EXTRAPOLATION -D NO_BORDER_ISOLATED -D COEFF=DIG(-0.05276617780f)DIG(-0.04470018670f)DIG(-0.01594762318f)DIG(-0.05306454748f)DIG(0.02005895041f)DIG(-0.05276617780f)DIG(-0.04470018670f)DIG(-0.01594762318f)DIG(-0.05306454748f)DIG(0.02005895041f)DIG(0.0000000000f)DIG(0.0000000000f)DIG(-0.02600976266f)DIG(-0.07384630293f)DIG(-0.02897979878f)DIG(-0.02242335863f)DIG(-0.06834634393f)DIG(-0.02600976266f)DIG(-0.07384630293f)DIG(-0.02897979878f)DIG(-0.02242335863f)DIG(-0.06834634393f)DIG(0.0000000000f)DIG(0.0000000000f)DIG(0.05077016354f)DIG(-0.03577987105f)DIG(0.04538633674f)DIG(-0.05935856327f)DIG(-0.03985077888f)DIG(0.05077016354f)DIG(-0.03577987105f)DIG(0.04538633674f)DIG(-0.05935856327f)DIG(-0.03985077888f)DIG(0.0000000000f)DIG(0.0000000000f)DIG(-0.03640502691f)DIG(0.06885126978f)DIG(0.01110663824f)DIG(0.06730707735f)DIG(0.04123077169f)DIG(-0.03640502691f)DIG(0.06885126978f)DIG(0.01110663824f)DIG(0.06730707735f)DIG(0.04123077169f)DIG(0.0000000000f)DIG(0.0000000000f)DIG(0.06652115285f)DIG(-0.001180781052f)DIG(0.002152414527f)DIG(-0.03550439700f)DIG(-0.03245172277f)DIG(0.06652115285f)DIG(-0.001180781052f)DIG(0.002152414527f)DIG(-0.03550439700f)DIG(-0.03245172277f)DIG(0.0000000000f)DIG(0.0000000000f) -D srcT=uchar4 -D srcT1=uchar -D dstT=uchar4 -D dstT1=uchar -D WT=float4 -D WT1=float -D convertToWT=convert_float4 -D convertToDstT=convert_uchar4_sat_rte -D INTEL_DEVICE
// RUN: %occ-cli %s --cl-options="-I%cwd -I%S -D LOCAL_SIZE=128 -D cn=4 -D ANCHOR_X=2 -D ANCHOR_Y=4 -D KERNEL_SIZE_X=5 -D KERNEL_SIZE_Y=5 -D KERNEL_SIZE_Y2_ALIGNED=12 -D BORDER_REPLICATE -D EXTRA_EXTRAPOLATION -D NO_BORDER_ISOLATED -D COEFF=DIG(-0.05276617780f)DIG(-0.04470018670f)DIG(-0.01594762318f)DIG(-0.05306454748f)DIG(0.02005895041f)DIG(-0.05276617780f)DIG(-0.04470018670f)DIG(-0.01594762318f)DIG(-0.05306454748f)DIG(0.02005895041f)DIG(0.0000000000f)DIG(0.0000000000f)DIG(-0.02600976266f)DIG(-0.07384630293f)DIG(-0.02897979878f)DIG(-0.02242335863f)DIG(-0.06834634393f)DIG(-0.02600976266f)DIG(-0.07384630293f)DIG(-0.02897979878f)DIG(-0.02242335863f)DIG(-0.06834634393f)DIG(0.0000000000f)DIG(0.0000000000f)DIG(0.05077016354f)DIG(-0.03577987105f)DIG(0.04538633674f)DIG(-0.05935856327f)DIG(-0.03985077888f)DIG(0.05077016354f)DIG(-0.03577987105f)DIG(0.04538633674f)DIG(-0.05935856327f)DIG(-0.03985077888f)DIG(0.0000000000f)DIG(0.0000000000f)DIG(-0.03640502691f)DIG(0.06885126978f)DIG(0.01110663824f)DIG(0.06730707735f)DIG(0.04123077169f)DIG(-0.03640502691f)DIG(0.06885126978f)DIG(0.01110663824f)DIG(0.06730707735f)DIG(0.04123077169f)DIG(0.0000000000f)DIG(0.0000000000f)DIG(0.06652115285f)DIG(-0.001180781052f)DIG(0.002152414527f)DIG(-0.03550439700f)DIG(-0.03245172277f)DIG(0.06652115285f)DIG(-0.001180781052f)DIG(0.002152414527f)DIG(-0.03550439700f)DIG(-0.03245172277f)DIG(0.0000000000f)DIG(0.0000000000f) -D srcT=uchar4 -D srcT1=uchar -D dstT=uchar4 -D dstT1=uchar -D WT=float4 -D WT1=float -D convertToWT=convert_float4 -D convertToDstT=convert_uchar4_sat_rte -D INTEL_DEVICE" %cfg_path --cl-device=%cl_device 2>&1
