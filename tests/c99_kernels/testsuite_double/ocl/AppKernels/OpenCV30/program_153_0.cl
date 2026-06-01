#ifdef DOUBLE_SUPPORT
#ifdef cl_amd_fp64
#pragma OPENCL EXTENSION cl_amd_fp64:enable
#elif defined (cl_khr_fp64)
#pragma OPENCL EXTENSION cl_khr_fp64:enable
#endif
#endif
#if DATA_DEPTH == 0
#define BASE_TYPE uchar
#elif DATA_DEPTH == 1
#error data_depth char, use uchar datatype instead
#elif DATA_DEPTH == 2
#define BASE_TYPE ushort
#elif DATA_DEPTH == 3
#error data_depth short, use ushort datatype instead
#elif DATA_DEPTH == 4
#define BASE_TYPE int
#elif DATA_DEPTH == 5
#define BASE_TYPE float
#elif DATA_DEPTH == 6
#define BASE_TYPE double
#else
#error data_depth
#endif
#if DATA_CHAN == 2
#define SRC_VEC_SIZE 2
#elif DATA_CHAN == 3
#define SRC_VEC_SIZE 4
#elif DATA_CHAN == 4
#define SRC_VEC_SIZE 4
#else
#error data_chan
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
#define TYPE BASE_TYPE
#define SRC_TYPE CAT(BASE_TYPE, SRC_VEC_SIZE)
#define DST_VEC_TYPE CAT(BASE_TYPE, VEC_SIZE)
#define vstore1 vstore
#define VSTORE CAT(vstore, VEC_SIZE)
#define VSTORE_ALIGNED(ptr, v) *((__global DST_VEC_TYPE*)(ptr)) = (v)
#define VSTORE_UNALIGNED(ptr, v) VSTORE((v), 0, (__global TYPE*)(ptr))
#ifdef DST0_ALIGNED
#define VSTORE_dst0 VSTORE_ALIGNED
#else
#define VSTORE_dst0 VSTORE_UNALIGNED
#endif
#ifdef DST1_ALIGNED
#define VSTORE_dst1 VSTORE_ALIGNED
#else
#define VSTORE_dst1 VSTORE_UNALIGNED
#endif
#ifdef DST2_ALIGNED
#define VSTORE_dst2 VSTORE_ALIGNED
#else
#define VSTORE_dst2 VSTORE_UNALIGNED
#endif
#ifdef DST3_ALIGNED
#define VSTORE_dst3 VSTORE_ALIGNED
#else
#define VSTORE_dst3 VSTORE_UNALIGNED
#endif
__kernel void split_vector(
__global SRC_TYPE* src, int srcStepBytes, int2 srcOffset,
__global TYPE* dst0, int dst0StepBytes, int2 dst0Offset,
__global TYPE* dst1, int dst1StepBytes, int2 dst1Offset,
#if DATA_CHAN > 2
__global TYPE* dst2, int dst2StepBytes, int2 dst2Offset,
#endif
#if DATA_CHAN > 3
__global TYPE* dst3, int dst3StepBytes, int2 dst3Offset,
#endif
int2 size)
{
int x = get_global_id(0) * VEC_SIZE;
int y = get_global_id(1);
if (x < size.x && y < size.y)
{
SRC_TYPE srcData[VEC_SIZE];
int xOffsetLimitBytes = srcOffset.x + size.x * sizeof(SRC_TYPE);
int xOffsetBytes = srcOffset.x + x * sizeof(SRC_TYPE);
int yOffsetBytes = (srcOffset.y + y) * srcStepBytes;
#pragma unroll
for (int i = 0; i < VEC_SIZE; i++, xOffsetBytes += sizeof(SRC_TYPE))
{
srcData[i] = (xOffsetBytes >= xOffsetLimitBytes) ? (SRC_TYPE)0 :
*(__global SRC_TYPE*)((__global char*)src + yOffsetBytes + xOffsetBytes);
}
#if VEC_SIZE == 1
TYPE dstC0 = srcData[0].s0;
TYPE dstC1 = srcData[0].s1;
#if DATA_CHAN > 2
TYPE dstC2 = srcData[0].s2;
#endif
#if DATA_CHAN > 3
TYPE dstC3 = srcData[0].s3;
#endif
# define VEC_TO_ARRAY(v, a) TYPE a[1] = {v};
#elif VEC_SIZE == 2
DST_VEC_TYPE dstC0 = (DST_VEC_TYPE)(srcData[0].s0, srcData[1].s0);
DST_VEC_TYPE dstC1 = (DST_VEC_TYPE)(srcData[0].s1, srcData[1].s1);
#if DATA_CHAN > 2
DST_VEC_TYPE dstC2 = (DST_VEC_TYPE)(srcData[0].s2, srcData[1].s2);
#endif
#if DATA_CHAN > 3
DST_VEC_TYPE dstC3 = (DST_VEC_TYPE)(srcData[0].s3, srcData[1].s3);
#endif
# define VEC_TO_ARRAY(v, a) TYPE a[2] = {v.s0, v.s1};
#elif VEC_SIZE == 4
DST_VEC_TYPE dstC0 = (DST_VEC_TYPE)(srcData[0].s0, srcData[1].s0, srcData[2].s0, srcData[3].s0);
DST_VEC_TYPE dstC1 = (DST_VEC_TYPE)(srcData[0].s1, srcData[1].s1, srcData[2].s1, srcData[3].s1);
#if DATA_CHAN > 2
DST_VEC_TYPE dstC2 = (DST_VEC_TYPE)(srcData[0].s2, srcData[1].s2, srcData[2].s2, srcData[3].s2);
#endif
#if DATA_CHAN > 3
DST_VEC_TYPE dstC3 = (DST_VEC_TYPE)(srcData[0].s3, srcData[1].s3, srcData[2].s3, srcData[3].s3);
#endif
# define VEC_TO_ARRAY(v, a) TYPE a[4] = {v.s0, v.s1, v.s2, v.s3};
#endif
#ifndef BYPASS_VSTORE
#define BYPASS_VSTORE false
#endif
#define WRITE_VEC_DST(dst, vecValue) \
{ \
int dst ## xOffsetLimitBytes = dst ## Offset.x + size.x * sizeof(TYPE); \
int dst ## xOffsetBytes = dst ## Offset.x + x * sizeof(TYPE); \
int dst ## yOffsetBytes = (dst ## Offset.y + y) * dst ## StepBytes; \
if (!BYPASS_VSTORE && dst ## xOffsetBytes + (int)sizeof(DST_VEC_TYPE) <= dst ## xOffsetLimitBytes) \
{ \
VSTORE_ ## dst(((__global char*)dst + dst ## yOffsetBytes + dst ## xOffsetBytes), vecValue); \
} \
else \
{ \
VEC_TO_ARRAY(vecValue, vecValue##Array); \
for (int i = 0; i < VEC_SIZE; i++, dst ## xOffsetBytes += sizeof(TYPE)) \
{ \
if (dst ## xOffsetBytes + (int)sizeof(TYPE) <= dst ## xOffsetLimitBytes) \
*(__global TYPE*)((__global char*)dst + dst ## yOffsetBytes + dst ## xOffsetBytes) = vecValue##Array[i]; \
else \
break; \
} \
} \
}
WRITE_VEC_DST(dst0, dstC0);
WRITE_VEC_DST(dst1, dstC1);
#if DATA_CHAN > 2
WRITE_VEC_DST(dst2, dstC2);
#endif
#if DATA_CHAN > 3
WRITE_VEC_DST(dst3, dstC3);
#endif
}
}


// buildOptions= -D INTEL_DEVICE -D VEC_SIZE=4 -D DATA_DEPTH=5 -D DATA_CHAN=3 -D DST0_ALIGNED -D DST1_ALIGNED -D DST2_ALIGNED
// RUN: %occ-cli %s --cl-options="-I%cwd -I%S  -D INTEL_DEVICE -D VEC_SIZE=4 -D DATA_DEPTH=5 -D DATA_CHAN=3 -D DST0_ALIGNED -D DST1_ALIGNED -D DST2_ALIGNED" %cfg_path --cl-device=%cl_device 2>&1
