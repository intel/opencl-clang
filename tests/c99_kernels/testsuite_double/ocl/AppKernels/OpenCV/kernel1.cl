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
__kernel void warpAffineNN_C1_D0(__global uchar const * restrict src, __global uchar * dst, int src_cols, int src_rows,
int dst_cols, int dst_rows, int srcStep, int dstStep,
int src_offset, int dst_offset,  __constant F * M, int threadCols )
{
int dx = get_global_id(0);
int dy = get_global_id(1);
if( dx < threadCols && dy < dst_rows)
{
dx = (dx<<2) - (dst_offset&3);
int round_delta = (AB_SCALE>>1);
int4 X, Y;
int4 sx, sy;
int4 DX = (int4)(dx, dx+1, dx+2, dx+3);
DX = (DX << AB_BITS);
F4 M0DX, M3DX;
M0DX = M[0] * convert_F4(DX);
M3DX = M[3] * convert_F4(DX);
X = convert_int4(rint(M0DX));
Y = convert_int4(rint(M3DX));
int tmp1, tmp2;
tmp1 = rint((M[1]*dy + M[2]) * AB_SCALE);
tmp2 = rint((M[4]*dy + M[5]) * AB_SCALE);
X += tmp1 + round_delta;
Y += tmp2 + round_delta;
sx = convert_int4(convert_short4(X >> AB_BITS));
sy = convert_int4(convert_short4(Y >> AB_BITS));
__global uchar4 * d = (__global uchar4 *)(dst+dst_offset+dy*dstStep+dx);
uchar4 dval = *d;
DX = (int4)(dx, dx+1, dx+2, dx+3);
int4 dcon = DX >= 0 && DX < dst_cols && dy >= 0 && dy < dst_rows;
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
