#ifndef WAVE_SIZE
#define WAVE_SIZE 1
#endif
static int calc_lut(__local int* smem, int val, int tid)
{
smem[tid] = val;
barrier(CLK_LOCAL_MEM_FENCE);
if (tid == 0)
for (int i = 1; i < 256; ++i)
smem[i] += smem[i - 1];
barrier(CLK_LOCAL_MEM_FENCE);
return smem[tid];
}
#ifdef CPU
static void reduce(volatile __local int* smem, int val, int tid)
{
smem[tid] = val;
barrier(CLK_LOCAL_MEM_FENCE);
if (tid < 128)
smem[tid] = val += smem[tid + 128];
barrier(CLK_LOCAL_MEM_FENCE);
if (tid < 64)
smem[tid] = val += smem[tid + 64];
barrier(CLK_LOCAL_MEM_FENCE);
if (tid < 32)
smem[tid] += smem[tid + 32];
barrier(CLK_LOCAL_MEM_FENCE);
if (tid < 16)
smem[tid] += smem[tid + 16];
barrier(CLK_LOCAL_MEM_FENCE);
if (tid < 8)
smem[tid] += smem[tid + 8];
barrier(CLK_LOCAL_MEM_FENCE);
if (tid < 4)
smem[tid] += smem[tid + 4];
barrier(CLK_LOCAL_MEM_FENCE);
if (tid < 2)
smem[tid] += smem[tid + 2];
barrier(CLK_LOCAL_MEM_FENCE);
if (tid < 1)
smem[256] = smem[tid] + smem[tid + 1];
barrier(CLK_LOCAL_MEM_FENCE);
}
#else
static void reduce(__local volatile int* smem, int val, int tid)
{
smem[tid] = val;
barrier(CLK_LOCAL_MEM_FENCE);
if (tid < 128)
smem[tid] = val += smem[tid + 128];
barrier(CLK_LOCAL_MEM_FENCE);
if (tid < 64)
smem[tid] = val += smem[tid + 64];
barrier(CLK_LOCAL_MEM_FENCE);
if (tid < 32)
{
smem[tid] += smem[tid + 32];
#if WAVE_SIZE < 32
} barrier(CLK_LOCAL_MEM_FENCE);
if (tid < 16)
{
#endif
smem[tid] += smem[tid + 16];
#if WAVE_SIZE < 16
}
barrier(CLK_LOCAL_MEM_FENCE);
if (tid < 8)
{
#endif
smem[tid] += smem[tid + 8];
smem[tid] += smem[tid + 4];
smem[tid] += smem[tid + 2];
smem[tid] += smem[tid + 1];
}
}
#endif
__kernel void calcLut(__global __const uchar * src, __global uchar * lut,
const int srcStep, const int dstStep,
const int2 tileSize, const int tilesX,
const int clipLimit, const float lutScale,
const int src_offset, const int dst_offset)
{
__local int smem[512];
int tx = get_group_id(0);
int ty = get_group_id(1);
int tid = get_local_id(1) * get_local_size(0)
+ get_local_id(0);
smem[tid] = 0;
barrier(CLK_LOCAL_MEM_FENCE);
for (int i = get_local_id(1); i < tileSize.y; i += get_local_size(1))
{
__global const uchar* srcPtr = src + mad24(ty * tileSize.y + i, srcStep, tx * tileSize.x + src_offset);
for (int j = get_local_id(0); j < tileSize.x; j += get_local_size(0))
{
const int data = srcPtr[j];
atomic_inc(&smem[data]);
}
}
barrier(CLK_LOCAL_MEM_FENCE);
int tHistVal = smem[tid];
barrier(CLK_LOCAL_MEM_FENCE);
if (clipLimit > 0)
{
int clipped = 0;
if (tHistVal > clipLimit)
{
clipped = tHistVal - clipLimit;
tHistVal = clipLimit;
}
reduce(smem, clipped, tid);
barrier(CLK_LOCAL_MEM_FENCE);
#ifdef CPU
clipped = smem[256];
#else
clipped = smem[0];
#endif
__local int totalClipped;
if (tid == 0)
totalClipped = clipped;
barrier(CLK_LOCAL_MEM_FENCE);
int redistBatch = totalClipped / 256;
tHistVal += redistBatch;
int residual = totalClipped - redistBatch * 256;
if (tid < residual)
++tHistVal;
}
const int lutVal = calc_lut(smem, tHistVal, tid);
uint ires = (uint)convert_int_rte(lutScale * lutVal);
lut[(ty * tilesX + tx) * dstStep + tid + dst_offset] =
convert_uchar(clamp(ires, (uint)0, (uint)255));
}
__kernel void transform(__global __const uchar * src,
__global uchar * dst,
__global uchar * lut,
const int srcStep, const int dstStep, const int lutStep,
const int cols, const int rows,
const int2 tileSize,
const int tilesX, const int tilesY,
const int src_offset, const int dst_offset, int lut_offset)
{
const int x = get_global_id(0);
const int y = get_global_id(1);
if (x >= cols || y >= rows)
return;
const float tyf = (convert_float(y) / tileSize.y) - 0.5f;
int ty1 = convert_int_rtn(tyf);
int ty2 = ty1 + 1;
const float ya = tyf - ty1;
ty1 = max(ty1, 0);
ty2 = min(ty2, tilesY - 1);
const float txf = (convert_float(x) / tileSize.x) - 0.5f;
int tx1 = convert_int_rtn(txf);
int tx2 = tx1 + 1;
const float xa = txf - tx1;
tx1 = max(tx1, 0);
tx2 = min(tx2, tilesX - 1);
const int srcVal = src[mad24(y, srcStep, x + src_offset)];
float res = 0;
res += lut[mad24(ty1 * tilesX + tx1, lutStep, srcVal + lut_offset)] * ((1.0f - xa) * (1.0f - ya));
res += lut[mad24(ty1 * tilesX + tx2, lutStep, srcVal + lut_offset)] * ((xa) * (1.0f - ya));
res += lut[mad24(ty2 * tilesX + tx1, lutStep, srcVal + lut_offset)] * ((1.0f - xa) * (ya));
res += lut[mad24(ty2 * tilesX + tx2, lutStep, srcVal + lut_offset)] * ((xa) * (ya));
uint ires = (uint)convert_int_rte(res);
dst[mad24(y, dstStep, x + dst_offset)] = convert_uchar(clamp(ires, (uint)0, (uint)255));
}


// buildOptions= -D INTEL_DEVICE
// RUN: %occ-cli %s --cl-options="-I%cwd -I%S  -D INTEL_DEVICE" %cfg_path --cl-device=%cl_device 2>&1
// XFAIL: *
