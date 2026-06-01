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


// buildOptions=-D LOCAL_SIZE=128 -D cn=1 -D ANCHOR_X=0 -D ANCHOR_Y=6 -D KERNEL_SIZE_X=7 -D KERNEL_SIZE_Y=7 -D KERNEL_SIZE_Y2_ALIGNED=16 -D BORDER_REFLECT_101 -D EXTRA_EXTRAPOLATION -D NO_BORDER_ISOLATED -D COEFF=DIG(-0.02725243382f)DIG(-0.01847942546f)DIG(0.001111669233f)DIG(-0.03529921174f)DIG(-0.008649390191f)DIG(0.03817887604f)DIG(-0.02023173124f)DIG(-0.02725243382f)DIG(-0.01847942546f)DIG(0.001111669233f)DIG(-0.03529921174f)DIG(-0.008649390191f)DIG(0.03817887604f)DIG(-0.02023173124f)DIG(0.0000000000f)DIG(0.0000000000f)DIG(-0.01343340334f)DIG(0.03555998951f)DIG(-0.02740653418f)DIG(-0.02058194764f)DIG(-0.006461249199f)DIG(-0.001772922231f)DIG(-0.008748698980f)DIG(-0.01343340334f)DIG(0.03555998951f)DIG(-0.02740653418f)DIG(-0.02058194764f)DIG(-0.006461249199f)DIG(-0.001772922231f)DIG(-0.008748698980f)DIG(0.0000000000f)DIG(0.0000000000f)DIG(0.02622154169f)DIG(-0.0006098443992f)DIG(-0.01158111356f)DIG(0.02129467949f)DIG(-0.002079067053f)DIG(-0.02924925461f)DIG(0.006588196848f)DIG(0.02622154169f)DIG(-0.0006098443992f)DIG(-0.01158111356f)DIG(0.02129467949f)DIG(-0.002079067053f)DIG(-0.02924925461f)DIG(0.006588196848f)DIG(0.0000000000f)DIG(0.0000000000f)DIG(-0.01880230196f)DIG(-0.008236556314f)DIG(-0.03065724112f)DIG(-0.01676051877f)DIG(-0.02708500624f)DIG(-0.01680412702f)DIG(0.02050732076f)DIG(-0.01880230196f)DIG(-0.008236556314f)DIG(-0.03065724112f)DIG(-0.01676051877f)DIG(-0.02708500624f)DIG(-0.01680412702f)DIG(0.02050732076f)DIG(0.0000000000f)DIG(0.0000000000f)DIG(0.03435654193f)DIG(-0.01496735495f)DIG(0.03476245329f)DIG(-0.02802082710f)DIG(0.03969863430f)DIG(-0.02038707212f)DIG(0.01215005200f)DIG(0.03435654193f)DIG(-0.01496735495f)DIG(0.03476245329f)DIG(-0.02802082710f)DIG(0.03969863430f)DIG(-0.02038707212f)DIG(0.01215005200f)DIG(0.0000000000f)DIG(0.0000000000f)DIG(-0.02308654971f)DIG(0.02344092913f)DIG(-0.01833714917f)DIG(-0.01861881837f)DIG(0.02282703109f)DIG(-0.01925713755f)DIG(0.03189887851f)DIG(-0.02308654971f)DIG(0.02344092913f)DIG(-0.01833714917f)DIG(-0.01861881837f)DIG(0.02282703109f)DIG(-0.01925713755f)DIG(0.03189887851f)DIG(0.0000000000f)DIG(0.0000000000f)DIG(-0.03813980147f)DIG(0.005736306310f)DIG(0.01035995502f)DIG(-0.02824934386f)DIG(0.03922891989f)DIG(-0.002393281087f)DIG(-0.03443874046f)DIG(-0.03813980147f)DIG(0.005736306310f)DIG(0.01035995502f)DIG(-0.02824934386f)DIG(0.03922891989f)DIG(-0.002393281087f)DIG(-0.03443874046f)DIG(0.0000000000f)DIG(0.0000000000f) -D srcT=uchar -D srcT1=uchar -D dstT=uchar -D dstT1=uchar -D WT=float -D WT1=float -D convertToWT=convert_float -D convertToDstT=convert_uchar_sat_rte -D INTEL_DEVICE
// RUN: %occ-cli %s --cl-options="-I%cwd -I%S -D LOCAL_SIZE=128 -D cn=1 -D ANCHOR_X=0 -D ANCHOR_Y=6 -D KERNEL_SIZE_X=7 -D KERNEL_SIZE_Y=7 -D KERNEL_SIZE_Y2_ALIGNED=16 -D BORDER_REFLECT_101 -D EXTRA_EXTRAPOLATION -D NO_BORDER_ISOLATED -D COEFF=DIG(-0.02725243382f)DIG(-0.01847942546f)DIG(0.001111669233f)DIG(-0.03529921174f)DIG(-0.008649390191f)DIG(0.03817887604f)DIG(-0.02023173124f)DIG(-0.02725243382f)DIG(-0.01847942546f)DIG(0.001111669233f)DIG(-0.03529921174f)DIG(-0.008649390191f)DIG(0.03817887604f)DIG(-0.02023173124f)DIG(0.0000000000f)DIG(0.0000000000f)DIG(-0.01343340334f)DIG(0.03555998951f)DIG(-0.02740653418f)DIG(-0.02058194764f)DIG(-0.006461249199f)DIG(-0.001772922231f)DIG(-0.008748698980f)DIG(-0.01343340334f)DIG(0.03555998951f)DIG(-0.02740653418f)DIG(-0.02058194764f)DIG(-0.006461249199f)DIG(-0.001772922231f)DIG(-0.008748698980f)DIG(0.0000000000f)DIG(0.0000000000f)DIG(0.02622154169f)DIG(-0.0006098443992f)DIG(-0.01158111356f)DIG(0.02129467949f)DIG(-0.002079067053f)DIG(-0.02924925461f)DIG(0.006588196848f)DIG(0.02622154169f)DIG(-0.0006098443992f)DIG(-0.01158111356f)DIG(0.02129467949f)DIG(-0.002079067053f)DIG(-0.02924925461f)DIG(0.006588196848f)DIG(0.0000000000f)DIG(0.0000000000f)DIG(-0.01880230196f)DIG(-0.008236556314f)DIG(-0.03065724112f)DIG(-0.01676051877f)DIG(-0.02708500624f)DIG(-0.01680412702f)DIG(0.02050732076f)DIG(-0.01880230196f)DIG(-0.008236556314f)DIG(-0.03065724112f)DIG(-0.01676051877f)DIG(-0.02708500624f)DIG(-0.01680412702f)DIG(0.02050732076f)DIG(0.0000000000f)DIG(0.0000000000f)DIG(0.03435654193f)DIG(-0.01496735495f)DIG(0.03476245329f)DIG(-0.02802082710f)DIG(0.03969863430f)DIG(-0.02038707212f)DIG(0.01215005200f)DIG(0.03435654193f)DIG(-0.01496735495f)DIG(0.03476245329f)DIG(-0.02802082710f)DIG(0.03969863430f)DIG(-0.02038707212f)DIG(0.01215005200f)DIG(0.0000000000f)DIG(0.0000000000f)DIG(-0.02308654971f)DIG(0.02344092913f)DIG(-0.01833714917f)DIG(-0.01861881837f)DIG(0.02282703109f)DIG(-0.01925713755f)DIG(0.03189887851f)DIG(-0.02308654971f)DIG(0.02344092913f)DIG(-0.01833714917f)DIG(-0.01861881837f)DIG(0.02282703109f)DIG(-0.01925713755f)DIG(0.03189887851f)DIG(0.0000000000f)DIG(0.0000000000f)DIG(-0.03813980147f)DIG(0.005736306310f)DIG(0.01035995502f)DIG(-0.02824934386f)DIG(0.03922891989f)DIG(-0.002393281087f)DIG(-0.03443874046f)DIG(-0.03813980147f)DIG(0.005736306310f)DIG(0.01035995502f)DIG(-0.02824934386f)DIG(0.03922891989f)DIG(-0.002393281087f)DIG(-0.03443874046f)DIG(0.0000000000f)DIG(0.0000000000f) -D srcT=uchar -D srcT1=uchar -D dstT=uchar -D dstT1=uchar -D WT=float -D WT1=float -D convertToWT=convert_float -D convertToDstT=convert_uchar_sat_rte -D INTEL_DEVICE" %cfg_path --cl-device=%cl_device 2>&1
