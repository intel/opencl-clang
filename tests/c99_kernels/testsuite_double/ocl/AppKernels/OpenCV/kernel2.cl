#if defined DOUBLE_SUPPORT
#pragma OPENCL EXTENSION cl_khr_fp64:enable
typedef double F;
typedef double4 F4;
#define convert_F4 convert_double4
#else
typedef float F;
typedef float4 F4;
#define convert_F4 convert_float4
#endif
#define INTER_BITS 5
#define INTER_TAB_SIZE (1 << INTER_BITS)
#define INTER_SCALE 1.f/INTER_TAB_SIZE
#define AB_BITS max(10, (int)INTER_BITS)
#define AB_SCALE (1 << AB_BITS)
#define INTER_REMAP_COEF_BITS 15
#define INTER_REMAP_COEF_SCALE (1 << INTER_REMAP_COEF_BITS)
inline void interpolateCubic( float x, float* coeffs )
{
const float A = -0.75f;
coeffs[0] = ((A*(x + 1.f) - 5.0f*A)*(x + 1.f) + 8.0f*A)*(x + 1.f) - 4.0f*A;
coeffs[1] = ((A + 2.f)*x - (A + 3.f))*x*x + 1.f;
coeffs[2] = ((A + 2.f)*(1.f - x) - (A + 3.f))*(1.f - x)*(1.f - x) + 1.f;
coeffs[3] = 1.f - coeffs[0] - coeffs[1] - coeffs[2];
}
__kernel void warpPerspectiveNN_C1_D0(__global uchar const * restrict src, __global uchar * dst, int src_cols, int src_rows,
int dst_cols, int dst_rows, int srcStep, int dstStep,
int src_offset, int dst_offset,  __constant F * M, int threadCols )
{
int dx = get_global_id(0);
int dy = get_global_id(1);
if( dx < threadCols && dy < dst_rows)
{
dx = (dx<<2) - (dst_offset&3);
F4 DX = (F4)(dx, dx+1, dx+2, dx+3);
F4 X0 = M[0]*DX + M[1]*dy + M[2];
F4 Y0 = M[3]*DX + M[4]*dy + M[5];
F4 W = M[6]*DX + M[7]*dy + M[8],one=1,zero=0;
W = (W!=zero) ? one/W : zero;
short4 X = convert_short4(rint(X0*W));
short4 Y = convert_short4(rint(Y0*W));
int4 sx = convert_int4(X);
int4 sy = convert_int4(Y);
int4 DXD = (int4)(dx, dx+1, dx+2, dx+3);
__global uchar4 * d = (__global uchar4 *)(dst+dst_offset+dy*dstStep+dx);
uchar4 dval = *d;
int4 dcon = DXD >= 0 && DXD < dst_cols && dy >= 0 && dy < dst_rows;
int4 scon = sx >= 0 && sx < src_cols && sy >= 0 && sy < src_rows;
int4 spos = src_offset + sy * srcStep + sx;
uchar4 sval;
sval.s0 = scon.s0 ? src[spos.s0] : 0;
sval.s1 = scon.s1 ? src[spos.s1] : 0;
sval.s2 = scon.s2 ? src[spos.s2] : 0;
sval.s3 = scon.s3 ? src[spos.s3] : 0;
dval = convert_uchar4(dcon != 0) ? sval : dval;
*d = dval;
}
}


// buildOptions=
// RUN: %occ-cli %s --cl-options="-I%cwd -I%S " %cfg_path --cl-device=%cl_device 2>&1
