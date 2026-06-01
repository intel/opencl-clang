#ifdef DOUBLE_SUPPORT
#ifdef cl_amd_fp64
#pragma OPENCL EXTENSION cl_amd_fp64:enable
#elif defined cl_khr_fp64
#pragma OPENCL EXTENSION cl_khr_fp64:enable
#endif
#endif
#ifdef INTEL_DEVICE
#pragma OPENCL FP_CONTRACT ON
#pragma OPENCL FP_FAST_FMAF ON
#pragma OPENCL FP_FAST_FMA ON
#endif
#if depth <= 5
#define CV_PI M_PI_F
#else
#define CV_PI M_PI
#endif
#ifndef cn
#define cn 1
#endif
#if cn == 1
#undef srcT1_C1
#undef srcT2_C1
#undef dstT_C1
#define srcT1_C1 srcT1
#define srcT2_C1 srcT2
#define dstT_C1 dstT
#endif
#if cn != 3
#define storedst(val) *(__global dstT *)(dstptr + dst_index) = val
#define storedst2(val) *(__global dstT *)(dstptr2 + dst_index2) = val
#else
#define storedst(val) vstore3(val, 0, (__global dstT_C1 *)(dstptr + dst_index))
#define storedst2(val) vstore3(val, 0, (__global dstT_C1 *)(dstptr2 + dst_index2))
#endif
#define noconvert
#ifndef workT
#ifndef srcT1
#define srcT1 dstT
#endif
#ifndef srcT1_C1
#define srcT1_C1 dstT_C1
#endif
#ifndef srcT2
#define srcT2 dstT
#endif
#ifndef srcT2_C1
#define srcT2_C1 dstT_C1
#endif
#define workT dstT
#if cn != 3
#define srcelem1 *(__global srcT1 *)(srcptr1 + src1_index)
#define srcelem2 *(__global srcT2 *)(srcptr2 + src2_index)
#else
#define srcelem1 vload3(0, (__global srcT1_C1 *)(srcptr1 + src1_index))
#define srcelem2 vload3(0, (__global srcT2_C1 *)(srcptr2 + src2_index))
#endif
#ifndef convertToDT
#define convertToDT noconvert
#endif
#else
#ifndef convertToWT2
#define convertToWT2 convertToWT1
#endif
#if cn != 3
#define srcelem1 convertToWT1(*(__global srcT1 *)(srcptr1 + src1_index))
#define srcelem2 convertToWT2(*(__global srcT2 *)(srcptr2 + src2_index))
#else
#define srcelem1 convertToWT1(vload3(0, (__global srcT1_C1 *)(srcptr1 + src1_index)))
#define srcelem2 convertToWT2(vload3(0, (__global srcT2_C1 *)(srcptr2 + src2_index)))
#endif
#endif
#ifndef workST
#define workST workT
#endif
#define EXTRA_PARAMS
#define EXTRA_INDEX
#define EXTRA_INDEX_ADD
#if defined OP_ADD
#define PROCESS_ELEM storedst(convertToDT(srcelem1 + srcelem2))
#elif defined OP_SUB
#define PROCESS_ELEM storedst(convertToDT(srcelem1 - srcelem2))
#elif defined OP_RSUB
#define PROCESS_ELEM storedst(convertToDT(srcelem2 - srcelem1))
#elif defined OP_ABSDIFF
#if wdepth <= 4
#define PROCESS_ELEM \
storedst(convertToDT(convertFromU(abs_diff(srcelem1, srcelem2))))
#else
#define PROCESS_ELEM \
storedst(convertToDT(fabs(srcelem1 - srcelem2)))
#endif
#elif defined OP_AND
#define PROCESS_ELEM storedst(srcelem1 & srcelem2)
#elif defined OP_OR
#define PROCESS_ELEM storedst(srcelem1 | srcelem2)
#elif defined OP_XOR
#define PROCESS_ELEM storedst(srcelem1 ^ srcelem2)
#elif defined OP_NOT
#define PROCESS_ELEM storedst(~srcelem1)
#elif defined OP_MIN
#define PROCESS_ELEM storedst(min(srcelem1, srcelem2))
#elif defined OP_MAX
#define PROCESS_ELEM storedst(max(srcelem1, srcelem2))
#elif defined OP_MUL
#define PROCESS_ELEM storedst(convertToDT(srcelem1 * srcelem2))
#elif defined OP_MUL_SCALE
#undef EXTRA_PARAMS
#ifdef UNARY_OP
#define EXTRA_PARAMS , workST srcelem2_, scaleT scale
#undef srcelem2
#define srcelem2 srcelem2_
#else
#define EXTRA_PARAMS , scaleT scale
#endif
#define PROCESS_ELEM storedst(convertToDT(srcelem1 * scale * srcelem2))
#elif defined OP_DIV
#define PROCESS_ELEM \
workT e2 = srcelem2, zero = (workT)(0); \
storedst(convertToDT(e2 != zero ? srcelem1 / e2 : zero))
#elif defined OP_DIV_SCALE
#undef EXTRA_PARAMS
#ifdef UNARY_OP
#define EXTRA_PARAMS , workST srcelem2_, scaleT scale
#undef srcelem2
#define srcelem2 srcelem2_
#else
#define EXTRA_PARAMS , scaleT scale
#endif
#define PROCESS_ELEM \
workT e2 = srcelem2, zero = (workT)(0); \
storedst(convertToDT(e2 == zero ? zero : (srcelem1 * (workT)(scale) / e2)))
#elif defined OP_RDIV_SCALE
#undef EXTRA_PARAMS
#ifdef UNARY_OP
#define EXTRA_PARAMS , workST srcelem2_, scaleT scale
#undef srcelem2
#define srcelem2 srcelem2_
#else
#define EXTRA_PARAMS , scaleT scale
#endif
#define PROCESS_ELEM \
workT e1 = srcelem1, zero = (workT)(0); \
storedst(convertToDT(e1 == zero ? zero : (srcelem2 * (workT)(scale) / e1)))
#elif defined OP_RECIP_SCALE
#undef EXTRA_PARAMS
#define EXTRA_PARAMS , scaleT scale
#define PROCESS_ELEM \
workT e1 = srcelem1, zero = (workT)(0); \
storedst(convertToDT(e1 != zero ? scale / e1 : zero))
#elif defined OP_ADDW
#undef EXTRA_PARAMS
#define EXTRA_PARAMS , scaleT alpha, scaleT beta, scaleT gamma
#if wdepth <= 4
#define PROCESS_ELEM storedst(convertToDT(mad24(srcelem1, alpha, mad24(srcelem2, beta, gamma))))
#else
#define PROCESS_ELEM storedst(convertToDT(fma(srcelem1, alpha, fma(srcelem2, beta, gamma))))
#endif
#elif defined OP_MAG
#define PROCESS_ELEM storedst(hypot(srcelem1, srcelem2))
#elif defined OP_PHASE_RADIANS
#define PROCESS_ELEM \
workT tmp = atan2(srcelem2, srcelem1); \
if (tmp < 0) \
tmp += 2 * CV_PI; \
storedst(tmp)
#elif defined OP_PHASE_DEGREES
#define PROCESS_ELEM \
workT tmp = degrees(atan2(srcelem2, srcelem1)); \
if (tmp < 0) \
tmp += 360; \
storedst(tmp)
#elif defined OP_EXP
#if wdepth == 5
#define PROCESS_ELEM storedst(native_exp(srcelem1))
#else
#define PROCESS_ELEM storedst(exp(srcelem1))
#endif
#elif defined OP_POW
#define PROCESS_ELEM storedst(pow(srcelem1, srcelem2))
#elif defined OP_POWN
#undef workT
#define workT int
#define PROCESS_ELEM storedst(pown(srcelem1, srcelem2))
#elif defined OP_SQRT
#if depth <= 5
#define PROCESS_ELEM storedst(native_sqrt(srcelem1))
#else
#define PROCESS_ELEM storedst(sqrt(srcelem1))
#endif
#elif defined OP_LOG
#define PROCESS_ELEM \
storedst(log(fabs(srcelem1)))
#elif defined OP_CMP
#define srcT2 srcT1
#ifndef convertToWT1
#define convertToWT1
#endif
#define PROCESS_ELEM \
storedst(srcelem1 CMP_OPERATOR srcelem2 ? (dstT)(255) : (dstT)(0))
#elif defined OP_CONVERT_SCALE_ABS
#undef EXTRA_PARAMS
#define EXTRA_PARAMS , workT1 alpha, workT1 beta
#if wdepth <= 4
#define PROCESS_ELEM \
workT value = mad24(srcelem1, (workT)(alpha), (workT)(beta)); \
storedst(convertToDT(abs(value)))
#else
#define PROCESS_ELEM \
workT value = fma(srcelem1, (workT)(alpha), (workT)(beta)); \
storedst(convertToDT(fabs(value)))
#endif
#elif defined OP_SCALE_ADD
#undef EXTRA_PARAMS
#define EXTRA_PARAMS , workT1 alpha
#if wdepth <= 4
#define PROCESS_ELEM storedst(convertToDT(mad24(srcelem1, (workT)(alpha), srcelem2)))
#else
#define PROCESS_ELEM storedst(convertToDT(fma(srcelem1, (workT)(alpha), srcelem2)))
#endif
#elif defined OP_CTP_AD || defined OP_CTP_AR
#if depth <= 5
#define CV_EPSILON FLT_EPSILON
#else
#define CV_EPSILON DBL_EPSILON
#endif
#ifdef OP_CTP_AD
#define TO_DEGREE cartToPolar = degrees(cartToPolar);
#elif defined OP_CTP_AR
#define TO_DEGREE
#endif
#define PROCESS_ELEM \
dstT x = srcelem1, y = srcelem2; \
dstT x2 = x * x, y2 = y * y; \
dstT magnitude = sqrt(x2 + y2); \
dstT tmp = y >= 0 ? 0 : CV_PI * 2; \
tmp = x < 0 ? CV_PI : tmp; \
dstT tmp1 = y >= 0 ? CV_PI * 0.5f : CV_PI * 1.5f; \
dstT cartToPolar = y2 <= x2 ? x * y / mad((dstT)(0.28f), y2, x2 + CV_EPSILON) + tmp : (tmp1 - x * y / mad((dstT)(0.28f), x2, y2 + CV_EPSILON)); \
TO_DEGREE \
storedst(magnitude); \
storedst2(cartToPolar)
#elif defined OP_PTC_AD || defined OP_PTC_AR
#ifdef OP_PTC_AD
#define FROM_DEGREE y = radians(y)
#else
#define FROM_DEGREE
#endif
#define PROCESS_ELEM \
dstT x = srcelem1, y = srcelem2, cosval; \
FROM_DEGREE; \
storedst2(sincos(y, &cosval) * x); \
storedst(cosval * x);
#elif defined OP_PATCH_NANS
#undef EXTRA_PARAMS
#define EXTRA_PARAMS , dstT val
#define PROCESS_ELEM \
if (isnan(srcelem1)) \
storedst(val)
#else
#error "unknown op type"
#endif
#if defined OP_CTP_AD || defined OP_CTP_AR || defined OP_PTC_AD || defined OP_PTC_AR
#undef EXTRA_PARAMS
#define EXTRA_PARAMS , __global uchar* dstptr2, int dststep2, int dstoffset2
#undef EXTRA_INDEX
#define EXTRA_INDEX int dst_index2 = mad24(y0, dststep2, mad24(x, (int)sizeof(dstT_C1) * cn, dstoffset2))
#undef EXTRA_INDEX_ADD
#define EXTRA_INDEX_ADD dst_index2 += dststep2
#endif
#if defined UNARY_OP || defined MASK_UNARY_OP
#if defined OP_AND || defined OP_OR || defined OP_XOR || defined OP_ADD || defined OP_SAT_ADD || \
defined OP_SUB || defined OP_SAT_SUB || defined OP_RSUB || defined OP_SAT_RSUB || \
defined OP_ABSDIFF || defined OP_CMP || defined OP_MIN || defined OP_MAX || defined OP_POW || \
defined OP_MUL || defined OP_DIV || defined OP_POWN || defined OP_POWR || defined OP_ROOTN
#undef EXTRA_PARAMS
#define EXTRA_PARAMS , workST srcelem2_
#undef srcelem2
#define srcelem2 srcelem2_
#endif
#if cn == 3
#undef srcelem2
#define srcelem2 (workT)(srcelem2_.x, srcelem2_.y, srcelem2_.z)
#endif
#endif
#if defined BINARY_OP
__kernel void KF(__global const uchar * srcptr1, int srcstep1, int srcoffset1,
__global const uchar * srcptr2, int srcstep2, int srcoffset2,
__global uchar * dstptr, int dststep, int dstoffset,
int rows, int cols EXTRA_PARAMS )
{
int x = get_global_id(0);
int y0 = get_global_id(1) * rowsPerWI;
if (x < cols)
{
int src1_index = mad24(y0, srcstep1, mad24(x, (int)sizeof(srcT1_C1) * cn, srcoffset1));
#if !(defined(OP_RECIP_SCALE) || defined(OP_NOT))
int src2_index = mad24(y0, srcstep2, mad24(x, (int)sizeof(srcT2_C1) * cn, srcoffset2));
#endif
int dst_index  = mad24(y0, dststep, mad24(x, (int)sizeof(dstT_C1) * cn, dstoffset));
EXTRA_INDEX;
for (int y = y0, y1 = min(rows, y0 + rowsPerWI); y < y1; ++y, src1_index += srcstep1, dst_index += dststep)
{
PROCESS_ELEM;
#if !(defined(OP_RECIP_SCALE) || defined(OP_NOT))
src2_index += srcstep2;
#endif
EXTRA_INDEX_ADD;
}
}
}
#elif defined MASK_BINARY_OP
__kernel void KF(__global const uchar * srcptr1, int srcstep1, int srcoffset1,
__global const uchar * srcptr2, int srcstep2, int srcoffset2,
__global const uchar * mask, int maskstep, int maskoffset,
__global uchar * dstptr, int dststep, int dstoffset,
int rows, int cols EXTRA_PARAMS )
{
int x = get_global_id(0);
int y0 = get_global_id(1) * rowsPerWI;
if (x < cols)
{
int mask_index = mad24(y0, maskstep, x + maskoffset);
int src1_index = mad24(y0, srcstep1, mad24(x, (int)sizeof(srcT1_C1) * cn, srcoffset1));
int src2_index = mad24(y0, srcstep2, mad24(x, (int)sizeof(srcT2_C1) * cn, srcoffset2));
int dst_index  = mad24(y0, dststep, mad24(x, (int)sizeof(dstT_C1) * cn, dstoffset));
for (int y = y0, y1 = min(rows, y0 + rowsPerWI); y < y1; ++y, src1_index += srcstep1, src2_index += srcstep2,
mask_index += maskstep, dst_index += dststep)
if (mask[mask_index])
{
PROCESS_ELEM;
}
}
}
#elif defined UNARY_OP
__kernel void KF(__global const uchar * srcptr1, int srcstep1, int srcoffset1,
__global uchar * dstptr, int dststep, int dstoffset,
int rows, int cols EXTRA_PARAMS )
{
int x = get_global_id(0);
int y0 = get_global_id(1) * rowsPerWI;
if (x < cols)
{
int src1_index = mad24(y0, srcstep1, mad24(x, (int)sizeof(srcT1_C1) * cn, srcoffset1));
int dst_index  = mad24(y0, dststep, mad24(x, (int)sizeof(dstT_C1) * cn, dstoffset));
for (int y = y0, y1 = min(rows, y0 + rowsPerWI); y < y1; ++y, src1_index += srcstep1, dst_index += dststep)
{
PROCESS_ELEM;
}
}
}
#elif defined MASK_UNARY_OP
__kernel void KF(__global const uchar * srcptr1, int srcstep1, int srcoffset1,
__global const uchar * mask, int maskstep, int maskoffset,
__global uchar * dstptr, int dststep, int dstoffset,
int rows, int cols EXTRA_PARAMS )
{
int x = get_global_id(0);
int y0 = get_global_id(1) * rowsPerWI;
if (x < cols)
{
int mask_index = mad24(y0, maskstep, x + maskoffset);
int src1_index = mad24(y0, srcstep1, mad24(x, (int)sizeof(srcT1_C1) * cn, srcoffset1));
int dst_index  = mad24(y0, dststep, mad24(x, (int)sizeof(dstT_C1) * cn, dstoffset));
for (int y = y0, y1 = min(rows, y0 + rowsPerWI); y < y1; ++y, src1_index += srcstep1, mask_index += maskstep, dst_index += dststep)
if (mask[mask_index])
{
PROCESS_ELEM;
}
}
}
#else
#error "Unknown operation type"
#endif


// buildOptions=-D UNARY_OP -D OP_ADD -D srcT1=short3 -D srcT1_C1=short -D srcT2=int3 -D srcT2_C1=int -D dstT=short3 -D dstT_C1=short -D workT=int3 -D workST=int4 -D scaleT=int -D wdepth=4 -D convertToWT1=convert_int3 -D convertToWT2=noconvert -D convertToDT=convert_short3_sat -D cn=3 -D rowsPerWI=4 -D convertFromU=noconvert -D INTEL_DEVICE
// RUN: %occ-cli %s --cl-options="-I%cwd -I%S -D UNARY_OP -D OP_ADD -D srcT1=short3 -D srcT1_C1=short -D srcT2=int3 -D srcT2_C1=int -D dstT=short3 -D dstT_C1=short -D workT=int3 -D workST=int4 -D scaleT=int -D wdepth=4 -D convertToWT1=convert_int3 -D convertToWT2=noconvert -D convertToDT=convert_short3_sat -D cn=3 -D rowsPerWI=4 -D convertFromU=noconvert -D INTEL_DEVICE" %cfg_path --cl-device=%cl_device 2>&1
