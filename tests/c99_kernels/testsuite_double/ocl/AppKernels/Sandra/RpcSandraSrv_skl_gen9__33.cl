
#define USE_MAD


#ifdef USE_DOUBLE

#if defined(cl_khr_fp64)
#pragma OPENCL EXTENSION cl_khr_fp64 : enable
#elif defined(cl_amd_fp64)
#pragma OPENCL EXTENSION cl_amd_fp64 : enable
#else
#error "FP64 not supported!"
#endif

#define real		double
#define realbase	real

#define REAL(x)		x

#define cdouble		double2
#define creal		cdouble

#define cdouble2	double4
#define creal2		cdouble2

#define cdouble4	double8
#define creal4		cdouble4

#define rsincos		sincos

#ifdef FP_FAST_FMA
#define fma_f	fma
#else
#define	fma_f	mad
#endif

#elif defined(USE_HALF)

#if defined(cl_khr_fp16)
#pragma OPENCL EXTENSION cl_khr_fp16 : enable
#else
#error "FP16 not supported!"
#endif

#define real		half
#define realbase	float

#define REAL(x)		x ## h

#define chalf		half2
#define creal		chalf

#define chalf2	half4
#define creal2		chalf2

#define chalf4	half8
#define creal4		chalf4

#define rsincos		sincos

#ifdef FP_FAST_FMAF
#define fma_f	fma
#else
#define	fma_f	mad
#endif

#else

#define real		float
#define realbase	real

#define REAL(x)		x ## f

#define cfloat		float2
#define creal		cfloat

#define cfloat2		float4
#define creal2		cfloat2

#define cfloat4		float8
#define creal4		cfloat4

#define rsincos		sincos

#ifdef FP_FAST_FMAF
#define fma_f	fma
#else
#define	fma_f	mad
#endif

#endif


inline creal cadd(const creal a, const creal b)
{
	return a+b;
}

inline creal csub(const creal a, const creal b)
{
	return a-b;
}

inline creal cmuls(const creal a, const real s)
{
	return a*(creal)(s, s);
}

inline creal cmul(const creal a, const creal b)
{
#ifdef USE_MAD
	return (creal)(fma_f(a.x, b.x, -a.y*b.y), fma_f(a.x, b.y, a.y*b.x));
#else
	return (creal)(a.x*b.x - a.y*b.y, a.x*b.y + a.y*b.x);
#endif
}


#define PI			REAL(3.1415926535897932384626433832795)

#ifndef USE_CONST_MEM

inline creal twiddle(const creal a, const real angle)
{
	real sina, cosa;
	sina = rsincos(angle, &cosa);

	return cmul(a, (creal)(cosa, sina));
}

#else

inline creal twiddle(const creal a, const creal asincos)
{
	return cmul(a, asincos);
}

#endif

#define FFT2(T, u0, u1)		{ \
	const T temp = csub(u0, u1); u0 = cadd(u0, u1); u1 = temp; \
	} \

__kernel void
FftRadix2Krnl(__global const creal* restrict pIn, __global creal* restrict pOut,
#ifdef USE_CONST_MEM
	__global const creal* restrict pSinCos, const int scoffset,
#endif
	const real fsign, const int p, const int t)
{
	const int i = get_global_id(0);
	if (i < t) {

	const int k = i & (p-1);				const int j = ((i-k) << 1) + k;
#if defined(USE_CONST_MEM)
	const int s = k + scoffset;
#else
	const real angle = -PI*fsign*(real)k/(real)p;
#endif

	creal u0 = pIn[i];
	const creal m1 = pIn[i+t];

#ifdef USE_CONST_MEM
	const creal sc1 = pSinCos[s];

	creal u1 = twiddle(m1, sc1);
#else
	creal u1 = twiddle(m1, angle);
#endif

	FFT2(creal, u0, u1);

	pOut[j] = u0;
	pOut[j+p] = u1;
	}
}

__kernel void
FftRadix2P1Krnl(__global const creal* restrict pIn, __global creal* restrict pOut,
	const real fsign, const int t)
{
	const int i = get_global_id(0);
	if (i < t) {

	const int j = ((i) << 1);
	creal u0 = pIn[i];
	creal u1 = pIn[i+t];

	FFT2(creal, u0, u1);

	pOut[j] = u0;
	pOut[j+1] = u1;
	}
}


inline creal twiddle_0_2(const creal a, const real fsign)
{
	return a;
}

inline creal twiddle_1_2(const creal a, const real fsign)
{
	return cmuls( (creal)(a.y, -a.x), fsign);
}

#define FFT4(T, I, \
  u0, u1, u2, u3)	{ \
	FFT2(T, u0, u2); FFT2(T, u1, u3); \
	u3=twiddle_1_2(u3, I); \
	FFT2(T, u0, u1); FFT2(T, u2, u3); \
	} \

__kernel void
FftRadix4Krnl(__global const creal* restrict pIn, __global creal* restrict pOut,
#ifdef USE_CONST_MEM
	__global const creal* restrict pSinCos, const int scoffset,
#endif
	const real fsign, const int p, const int t)
{
	const int i = get_global_id(0);
	if (i < t) {

	const int k = i & (p-1);				const int j = ((i-k) << 2) + k;
#if defined(USE_CONST_MEM)
	const int s = k + scoffset;
#else
	const real angle = -PI*fsign*(real)k/(real)(2*p);
#endif

	creal u0 = pIn[i];
	const creal m1 = pIn[i+t];
	const creal m2 = pIn[i+2*t];
	const creal m3 = pIn[i+3*t];

#ifdef USE_CONST_MEM
	const creal sc1 = pSinCos[s];
	const creal sc2 = pSinCos[s+p];
	const creal sc3 = pSinCos[s+2*p];

	creal u1 = twiddle(m1, sc1);
	creal u2 = twiddle(m2, sc2);
	creal u3 = twiddle(m3, sc3);
#else
	creal u1 = twiddle(m1,   angle);
	creal u2 = twiddle(m2, 2*angle);
	creal u3 = twiddle(m3, 3*angle);
#endif

	FFT4(creal, fsign,
		u0, u1, u2, u3);

	pOut[j]   = u0;
	pOut[j+p] = u2;

	pOut[j+2*p] = u1;
	pOut[j+3*p] = u3;
	}
}

__kernel void
FftRadix4P1Krnl(__global const creal* restrict pIn, __global creal* restrict pOut,
	const realbase fsign, const int t)
{
	const int i = get_global_id(0);
	if (i < t) {

	const int j = ((i) << 2);
	creal u0 = pIn[i];
	creal u1 = pIn[i+t];
	creal u2 = pIn[i+2*t];
	creal u3 = pIn[i+3*t];

	FFT4(creal, fsign,
		u0, u1, u2, u3);

	pOut[j]   = u0;
	pOut[j+1] = u2;

	pOut[j+2] = u1;
	pOut[j+3] = u3;
	}
}


#define twiddle_0_4		twiddle_0_2
#define twiddle_2_4		twiddle_1_2

#define COS_P4			REAL(0.70710678118654752440084436210485)

inline creal twiddle_1_4(const creal a, const real fsign) {
	return cmuls( (creal)(a.x+a.y*fsign, -a.x*fsign+a.y), COS_P4);
}

inline creal twiddle_3_4(const creal a, const real fsign) {
	return cmuls( (creal)(-a.x+a.y*fsign, -a.x*fsign-a.y), COS_P4);
}

#define FFT8(T, I, \
  u0, u1, u2, u3, u4, u5, u6, u7)	{ \
	FFT2(T, u0, u4); FFT2(T, u1, u5); FFT2(T, u2, u6); FFT2(T, u3, u7); \
	u4=twiddle_0_4(u4, I); u5=twiddle_1_4(u5, I); u6=twiddle_2_4(u6, I); u7=twiddle_3_4(u7, I); \
	FFT2(T, u0, u2); FFT2(T, u1, u3); FFT2(T, u4, u6); FFT2(T, u5, u7); \
	u3=twiddle_1_2(u3, I); u7=twiddle_1_2(u7, I); \
	FFT2(T, u0, u1); FFT2(T, u2, u3); FFT2(T, u4, u5); FFT2(T, u6, u7); \
	} \

__kernel void
FftRadix8Krnl(__global const creal* restrict pIn, __global creal* restrict pOut,
#ifdef USE_CONST_MEM
	__global const creal* restrict pSinCos, const int scoffset,
#endif
	const realbase fsign, const int p, const int t)
{
	const int i = get_global_id(0);
	if (i < t) {

	const int k = i & (p-1);				const int j = ((i-k) << 3) + k;
#if defined(USE_CONST_MEM)
	const int s = k + scoffset;
#else
	const real angle = -PI*fsign*(real)k/(real)(4*p);
#endif

	creal u0 = pIn[i];
	const creal m1 = pIn[i+t];
	const creal m2 = pIn[i+2*t];
	const creal m3 = pIn[i+3*t];

	const creal m4 = pIn[i+4*t];
	const creal m5 = pIn[i+5*t];
	const creal m6 = pIn[i+6*t];
	const creal m7 = pIn[i+7*t];

#ifdef USE_CONST_MEM
	const creal sc1 = pSinCos[s];
	const creal sc2 = pSinCos[s+p];
	const creal sc3 = pSinCos[s+2*p];

	const creal sc4 = pSinCos[s+3*p];
	const creal sc5 = pSinCos[s+4*p];
	const creal sc6 = pSinCos[s+5*p];
	const creal sc7 = pSinCos[s+6*p];

	creal u1 = twiddle(m1, sc1);
	creal u2 = twiddle(m2, sc2);
	creal u3 = twiddle(m3, sc3);

	creal u4 = twiddle(m4, sc4);
	creal u5 = twiddle(m5, sc5);
	creal u6 = twiddle(m6, sc6);
	creal u7 = twiddle(m7, sc7);
#else
	creal u1 = twiddle(m1,   angle);
	creal u2 = twiddle(m2, 2*angle);
	creal u3 = twiddle(m3, 3*angle);

	creal u4 = twiddle(m4, 4*angle);
	creal u5 = twiddle(m5, 5*angle);
	creal u6 = twiddle(m6, 6*angle);
	creal u7 = twiddle(m7, 7*angle);
#endif

	FFT8(creal, fsign,
		u0, u1, u2, u3, u4, u5, u6, u7);

	pOut[j] = u0;
	pOut[j+p] = u4;
	pOut[j+2*p] = u2;
	pOut[j+3*p] = u6;

	pOut[j+4*p] = u1;
	pOut[j+5*p] = u5;
	pOut[j+6*p] = u3;
	pOut[j+7*p] = u7;

	}
}

__kernel void
FftRadix8P1Krnl(__global const creal* restrict pIn, __global creal* restrict pOut,
	const realbase fsign, const int t)
{
	const int i = get_global_id(0);
	if (i < t) {

	const int j = ((i) << 3);
	creal u0 = pIn[i];
	creal u1 = pIn[i+t];
	creal u2 = pIn[i+2*t];
	creal u3 = pIn[i+3*t];

	creal u4 = pIn[i+4*t];
	creal u5 = pIn[i+5*t];
	creal u6 = pIn[i+6*t];
	creal u7 = pIn[i+7*t];

	FFT8(creal, fsign,
		u0, u1, u2, u3, u4, u5, u6, u7);

	pOut[j] = u0;
	pOut[j+1] = u4;
	pOut[j+2] = u2;
	pOut[j+3] = u6;

	pOut[j+4] = u1;
	pOut[j+5] = u5;
	pOut[j+6] = u3;
	pOut[j+7] = u7;

	}
}


#define twiddle_0_8 twiddle_0_4
#define twiddle_2_8 twiddle_1_4
#define twiddle_4_8 twiddle_2_4
#define twiddle_6_8 twiddle_3_4

#define	COS_P8		REAL(0.92387953251128675612818318939679)
#define SIN_P8		REAL(0.3826834323650897717284599840304)

inline creal twiddle_1_8(const creal a, const real fsign)
{
	return cmul( (creal)(COS_P8, -SIN_P8*fsign), a);
}

inline creal twiddle_3_8(const creal a, const real fsign)
{
	return cmul( (creal)(SIN_P8, -COS_P8*fsign), a);
}

inline creal twiddle_5_8(const creal a, const real fsign)
{
	return cmul( (creal)(-SIN_P8, -COS_P8*fsign), a);
}

inline creal twiddle_7_8(const creal a, const real fsign)
{
	return cmul( (creal)(-COS_P8, -SIN_P8*fsign), a);
}

#define FFT16(T, I, \
  u0, u1, u2, u3, u4, u5, u6, u7, u8, u9, uA, uB, uC, uD, uE, uF) { \
	FFT2(T, u0, u8); FFT2(T, u1, u9); FFT2(T, u2, uA); FFT2(T, u3, uB); \
	FFT2(T, u4, uC); FFT2(T, u5, uD); FFT2(T, u6, uE); FFT2(T, u7, uF); \
	u8 = twiddle_0_8(u8, I); u9 = twiddle_1_8(u9, I); uA = twiddle_2_8(uA, I); uB = twiddle_3_8(uB, I); \
	uC = twiddle_4_8(uC, I); uD = twiddle_5_8(uD, I); uE = twiddle_6_8(uE, I); uF = twiddle_7_8(uF, I); \
	FFT2(T, u0, u4); FFT2(T, u1, u5); FFT2(T, u2, u6); FFT2(T, u3, u7); \
	FFT2(T, u8, uC); FFT2(T, u9, uD); FFT2(T, uA, uE); FFT2(T, uB, uF); \
	u4 = twiddle_0_4(u4, I); u5 = twiddle_1_4(u5, I); u6 = twiddle_2_4(u6, I); u7 = twiddle_3_4(u7, I); \
	uC = twiddle_0_4(uC, I); uD = twiddle_1_4(uD, I); uE = twiddle_2_4(uE, I); uF = twiddle_3_4(uF, I); \
	FFT2(T, u0, u2); FFT2(T, u1, u3); FFT2(T, u4, u6); FFT2(T, u5, u7); \
	FFT2(T, u8, uA); FFT2(T, u9, uB); FFT2(T, uC, uE); FFT2(T, uD, uF); \
	u2 = twiddle_0_2(u2, I); u3 = twiddle_1_2(u3, I); u6 = twiddle_0_2(u6, I); u7 = twiddle_1_2(u7, I);\
	uA = twiddle_0_2(uA, I); uB = twiddle_1_2(uB, I); uE = twiddle_0_2(uE, I); uF = twiddle_1_2(uF, I);\
	FFT2(T, u0, u1); FFT2(T, u2, u3); FFT2(T, u4, u5); FFT2(T, u6, u7); \
	FFT2(T, u8, u9); FFT2(T, uA, uB); FFT2(T, uC, uD); FFT2(T, uE, uF); \
	} \

__kernel void
FftRadix16Krnl(__global const creal* restrict pIn, __global creal* restrict pOut,
#ifdef USE_CONST_MEM
	__global const creal* restrict pSinCos, const int scoffset,
#endif
	const realbase fsign, const int p, const int t)
{
	const int i = get_global_id(0);
	if (i < t) {

	const int k = i & (p-1);				const int j = ((i-k) << 4) + k;
#if defined(USE_CONST_MEM)
	const int s = k + scoffset;
#else
	const real angle = -PI*fsign*(real)k/(real)(8*p);
#endif

	creal u0 = pIn[i];
	const creal m1 = pIn[i+t];
	const creal m2 = pIn[i+2*t];
	const creal m3 = pIn[i+3*t];
	const creal m4 = pIn[i+4*t];
	const creal m5 = pIn[i+5*t];
	const creal m6 = pIn[i+6*t];
	const creal m7 = pIn[i+7*t];

	const creal m8 = pIn[i+8*t];
	const creal m9 = pIn[i+9*t];
	const creal mA = pIn[i+0xA*t];
	const creal mB = pIn[i+0xB*t];
	const creal mC = pIn[i+0xC*t];
	const creal mD = pIn[i+0xD*t];
	const creal mE = pIn[i+0xE*t];
	const creal mF = pIn[i+0xF*t];

#ifdef USE_CONST_MEM
	const creal sc1 = pSinCos[s];
	const creal sc2 = pSinCos[s+p];
	const creal sc3 = pSinCos[s+2*p];
	const creal sc4 = pSinCos[s+3*p];
	const creal sc5 = pSinCos[s+4*p];
	const creal sc6 = pSinCos[s+5*p];
	const creal sc7 = pSinCos[s+6*p];

	const creal sc8 = pSinCos[s+7*p];
	const creal sc9 = pSinCos[s+8*p];
	const creal scA = pSinCos[s+9*p];
	const creal scB = pSinCos[s+0xA*p];
	const creal scC = pSinCos[s+0xB*p];
	const creal scD = pSinCos[s+0xC*p];
	const creal scE = pSinCos[s+0xD*p];
	const creal scF = pSinCos[s+0xE*p];

	creal u1 = twiddle(m1, sc1);
	creal u2 = twiddle(m2, sc2);
	creal u3 = twiddle(m3, sc3);
	creal u4 = twiddle(m4, sc4);
	creal u5 = twiddle(m5, sc5);
	creal u6 = twiddle(m6, sc6);
	creal u7 = twiddle(m7, sc7);

	creal u8 = twiddle(m8, sc8);
	creal u9 = twiddle(m9, sc9);
	creal uA = twiddle(mA, scA);
	creal uB = twiddle(mB, scB);
	creal uC = twiddle(mC, scC);
	creal uD = twiddle(mD, scD);
	creal uE = twiddle(mE, scE);
	creal uF = twiddle(mF, scF);
#else
	creal u1 = twiddle(m1,   angle);
	creal u2 = twiddle(m2, 2*angle);
	creal u3 = twiddle(m3, 3*angle);
	creal u4 = twiddle(m4, 4*angle);
	creal u5 = twiddle(m5, 5*angle);
	creal u6 = twiddle(m6, 6*angle);
	creal u7 = twiddle(m7, 7*angle);

	creal u8 = twiddle(m8,   8*angle);
	creal u9 = twiddle(m9,   9*angle);
	creal uA = twiddle(mA, 0xA*angle);
	creal uB = twiddle(mB, 0xB*angle);
	creal uC = twiddle(mC, 0xC*angle);
	creal uD = twiddle(mD, 0xD*angle);
	creal uE = twiddle(mE, 0xE*angle);
	creal uF = twiddle(mF, 0xF*angle);
#endif

	FFT16(creal, fsign,
		u0, u1, u2, u3, u4, u5, u6, u7,
		u8, u9, uA, uB, uC, uD, uE, uF);

	pOut[j] = u0;
	pOut[j+p] = u8;
	pOut[j+2*p] = u4;
	pOut[j+3*p] = uC;
	pOut[j+4*p] = u2;
	pOut[j+5*p] = uA;
	pOut[j+6*p] = u6;
	pOut[j+7*p] = uE;

	pOut[j+8*p] = u1;
	pOut[j+9*p] = u9;
	pOut[j+0xA*p] = u5;
	pOut[j+0xB*p] = uD;
	pOut[j+0xC*p] = u3;
	pOut[j+0xD*p] = uB;
	pOut[j+0xE*p] = u7;
	pOut[j+0xF*p] = uF;
	}
}

__kernel void
FftRadix16P1Krnl(__global const creal* restrict pIn, __global creal* restrict pOut,
	const realbase fsign, const int t)
{
	const int i = get_global_id(0);
	if (i < t) {

	const int j = ((i) << 4);
	creal u0 = pIn[i];
	creal u1 = pIn[i+t];
	creal u2 = pIn[i+2*t];
	creal u3 = pIn[i+3*t];
	creal u4 = pIn[i+4*t];
	creal u5 = pIn[i+5*t];
	creal u6 = pIn[i+6*t];
	creal u7 = pIn[i+7*t];

	creal u8 = pIn[i+8*t];
	creal u9 = pIn[i+9*t];
	creal uA = pIn[i+0xA*t];
	creal uB = pIn[i+0xB*t];
	creal uC = pIn[i+0xC*t];
	creal uD = pIn[i+0xD*t];
	creal uE = pIn[i+0xE*t];
	creal uF = pIn[i+0xF*t];

	FFT16(creal, fsign,
		u0, u1, u2, u3, u4, u5, u6, u7,
		u8, u9, uA, uB, uC, uD, uE, uF);

	pOut[j] = u0;
	pOut[j+1] = u8;
	pOut[j+2] = u4;
	pOut[j+3] = uC;
	pOut[j+4] = u2;
	pOut[j+5] = uA;
	pOut[j+6] = u6;
	pOut[j+7] = uE;

	pOut[j+8] = u1;
	pOut[j+9] = u9;
	pOut[j+0xA] = u5;
	pOut[j+0xB] = uD;
	pOut[j+0xC] = u3;
	pOut[j+0xD] = uB;
	pOut[j+0xE] = u7;
	pOut[j+0xF] = uF;
	}
}


#define twiddle_0_16 twiddle_0_8
#define twiddle_2_16 twiddle_1_8
#define twiddle_4_16 twiddle_2_8
#define twiddle_6_16 twiddle_3_8

#define twiddle_8_16 twiddle_4_8
#define twiddle_A_16 twiddle_5_8
#define twiddle_C_16 twiddle_6_8
#define twiddle_E_16 twiddle_7_8

#define	COS_P16		REAL(0.98078528040323044912618223613424)		#define SIN_P16		REAL(0.19509032201612826784828486847702)
inline creal twiddle_1_16(const creal a, const real fsign) {
	return a;
}

inline creal twiddle_3_16(const creal a, const real fsign) {
	return a;
}

inline creal twiddle_5_16(const creal a, const real fsign) {
	return a;
}

inline creal twiddle_7_16(const creal a, const real fsign) {
	return a;
}

inline creal twiddle_9_16(const creal a, const real fsign) {
	return a;
}

inline creal twiddle_B_16(const creal a, const real fsign) {
	return a;
}

inline creal twiddle_D_16(const creal a, const real fsign) {
	return a;
}

inline creal twiddle_F_16(const creal a, const real fsign) {
	return a;
}

#define FFT32(T, I, \
  u0, u1, u2, u3, u4, u5, u6, u7, u8, u9, uA, uB, uC, uD, uE, uF, \
  u10, u11, u12, u13, u14, u15, u16, u17, u18, u19, u1A, u1B, u1C, u1D, u1E, u1F) { \
	FFT2(T, u0, u10); FFT2(T, u1, u11); FFT2(T, u2, u12); FFT2(T, u3, u13); \
	FFT2(T, u4, u14); FFT2(T, u5, u15); FFT2(T, u6, u16); FFT2(T, u7, u17); \
	FFT2(T, u8, u18); FFT2(T, u9, u19); FFT2(T, uA, u1A); FFT2(T, uB, u1B); \
	FFT2(T, uC, u1C); FFT2(T, uD, u1D); FFT2(T, uE, u1E); FFT2(T, uF, u1F); \
	u10=twiddle_0_16(u10, I); u11=twiddle_1_16(u11, I); u12=twiddle_2_16(u12, I); u13=twiddle_3_16(u13, I); \
	u14=twiddle_4_16(u14, I); u15=twiddle_5_16(u15, I); u16=twiddle_6_16(u16, I); u17=twiddle_7_16(u17, I); \
	u18=twiddle_8_16(u18, I); u19=twiddle_9_16(u19, I); u1A=twiddle_A_16(u1A, I); u1B=twiddle_B_16(u1B, I); \
	u1C=twiddle_C_16(u1C, I); u1D=twiddle_D_16(u1D, I); u1E=twiddle_E_16(u1E, I); u1F=twiddle_F_16(u1F, I); \
	FFT2(T, u0, u8); FFT2(T, u1, u9); FFT2(T, u2, uA); FFT2(T, u3, uB); \
	FFT2(T, u4, uC); FFT2(T, u5, uD); FFT2(T, u6, uE); FFT2(T, u7, uF); \
	FFT2(T, u10, u18); FFT2(T, u11, u19); FFT2(T, u12, u1A); FFT2(T, u13, u1B); \
	FFT2(T, u14, u1C); FFT2(T, u15, u1D); FFT2(T, u16, u1E); FFT2(T, u17, u1F); \
	u8 = twiddle_0_8(u8, I); u9 = twiddle_1_8(u9, I); uA = twiddle_2_8(uA, I); uB = twiddle_3_8(uB, I); \
	uC = twiddle_4_8(uC, I); uD = twiddle_5_8(uD, I); uE = twiddle_6_8(uE, I); uF = twiddle_7_8(uF, I); \
	u18 = twiddle_0_8(u18, I); u19 = twiddle_1_8(u19, I); u1A = twiddle_2_8(u1A, I); u1B = twiddle_3_8(u1B, I); \
	u1C = twiddle_4_8(u1C, I); u1D = twiddle_5_8(u1D, I); u1E = twiddle_6_8(u1E, I); u1F = twiddle_7_8(u1F, I); \
	FFT2(T, u0, u4); FFT2(T, u1, u5); FFT2(T, u2, u6); FFT2(T, u3, u7); \
	FFT2(T, u8, uC); FFT2(T, u9, uD); FFT2(T, uA, uE); FFT2(T, uB, uF); \
	FFT2(T, u10, u14); FFT2(T, u11, u15); FFT2(T, u12, u16); FFT2(T, u13, u17); \
	FFT2(T, u18, u1C); FFT2(T, u19, u1D); FFT2(T, u1A, u1E); FFT2(T, u1B, u1F); \
	u4 = twiddle_0_4(u4, I); u5 = twiddle_1_4(u5, I); u6 = twiddle_2_4(u6, I); u7 = twiddle_3_4(u7, I); \
	uC = twiddle_0_4(uC, I); uD = twiddle_1_4(uD, I); uE = twiddle_2_4(uE, I); uF = twiddle_3_4(uF, I); \
	u14 = twiddle_0_4(u14, I); u15 = twiddle_1_4(u15, I); u16 = twiddle_2_4(u16, I); u17 = twiddle_3_4(u17, I); \
	u1C = twiddle_0_4(u1C, I); u1D = twiddle_1_4(u1D, I); u1E = twiddle_2_4(u1E, I); u1F = twiddle_3_4(u1F, I); \
	FFT2(T, u0, u2); FFT2(T, u1, u3); FFT2(T, u4, u6); FFT2(T, u5, u7); \
	FFT2(T, u8, uA); FFT2(T, u9, uB); FFT2(T, uC, uE); FFT2(T, uD, uF); \
	FFT2(T, u10, u12); FFT2(T, u11, u13); FFT2(T, u12, u14); FFT2(T, u13, u15); \
	FFT2(T, u18, u1A); FFT2(T, u19, u1B); FFT2(T, u1C, u1E); FFT2(T, u1D, u1F); \
	u2 = twiddle_0_2(u2, I); u3 = twiddle_1_2(u3, I); u6 = twiddle_0_2(u6, I); u7 = twiddle_1_2(u7, I); \
	uA = twiddle_0_2(uA, I); uB = twiddle_1_2(uB, I); uE = twiddle_0_2(uE, I); uF = twiddle_1_2(uF, I); \
	u12 = twiddle_0_2(u12, I); u13 = twiddle_1_2(u13, I); u16 = twiddle_0_2(u16, I); u17 = twiddle_0_2(u17, I); \
	u1A = twiddle_0_2(u1A, I); u1B = twiddle_1_2(u1B, I); u1E = twiddle_0_2(u1E, I); u1F = twiddle_0_2(u1F, I); \
	FFT2(T, u0, u1); FFT2(T, u2, u3); FFT2(T, u4, u5); FFT2(T, u6, u7); \
	FFT2(T, u8, u9); FFT2(T, uA, uB); FFT2(T, uC, uD); FFT2(T, uE, uF); \
	FFT2(T, u10, u11); FFT2(T, u12, u13); FFT2(T, u14, u15); FFT2(T, u16, u17); \
	FFT2(T, u18, u19); FFT2(T, u1A, u1B); FFT2(T, u1C, u1D); FFT2(T, u1E, u1F); \
	} \

__kernel void
FftRadix32Krnl(__global const creal* restrict pIn, __global creal* restrict pOut,
#ifdef USE_CONST_MEM
	__global const creal* restrict pSinCos, const int scoffset,
#endif
	const realbase fsign, const int p, const int t)
{
	const int i = get_global_id(0);
	if (i < t) {

	const int k = i & (p-1);				const int j = ((i-k) << 5) + k;
#if defined(USE_CONST_MEM)
	const int s = k + scoffset;
#else
	const real angle = -PI*fsign*(real)k/(real)(16*p);
#endif

	creal u0 = pIn[i];
	const creal m1 = pIn[i+t];
	const creal m2 = pIn[i+2*t];
	const creal m3 = pIn[i+3*t];
	const creal m4 = pIn[i+4*t];
	const creal m5 = pIn[i+5*t];
	const creal m6 = pIn[i+6*t];
	const creal m7 = pIn[i+7*t];

	const creal m8 = pIn[i+8*t];
	const creal m9 = pIn[i+9*t];
	const creal mA = pIn[i+0xA*t];
	const creal mB = pIn[i+0xB*t];
	const creal mC = pIn[i+0xC*t];
	const creal mD = pIn[i+0xD*t];
	const creal mE = pIn[i+0xE*t];
	const creal mF = pIn[i+0xF*t];

	const creal m10 = pIn[i+0x10*t];
	const creal m11 = pIn[i+0x11*t];
	const creal m12 = pIn[i+0x12*t];
	const creal m13 = pIn[i+0x13*t];
	const creal m14 = pIn[i+0x14*t];
	const creal m15 = pIn[i+0x15*t];
	const creal m16 = pIn[i+0x16*t];
	const creal m17 = pIn[i+0x17*t];

	const creal m18 = pIn[i+0x18*t];
	const creal m19 = pIn[i+0x19*t];
	const creal m1A = pIn[i+0x1A*t];
	const creal m1B = pIn[i+0x1B*t];
	const creal m1C = pIn[i+0x1C*t];
	const creal m1D = pIn[i+0x1D*t];
	const creal m1E = pIn[i+0x1E*t];
	const creal m1F = pIn[i+0x1F*t];

#ifdef USE_CONST_MEM
	const creal sc1 = pSinCos[s];
	const creal sc2 = pSinCos[s+p];
	const creal sc3 = pSinCos[s+2*p];
	const creal sc4 = pSinCos[s+3*p];
	const creal sc5 = pSinCos[s+4*p];
	const creal sc6 = pSinCos[s+5*p];
	const creal sc7 = pSinCos[s+6*p];

	const creal sc8 = pSinCos[s+7*p];
	const creal sc9 = pSinCos[s+8*p];
	const creal scA = pSinCos[s+9*p];
	const creal scB = pSinCos[s+0xA*p];
	const creal scC = pSinCos[s+0xB*p];
	const creal scD = pSinCos[s+0xC*p];
	const creal scE = pSinCos[s+0xD*p];
	const creal scF = pSinCos[s+0xE*p];

	const creal sc10 = pSinCos[s+0xF*p];
	const creal sc11 = pSinCos[s+0x10*p];
	const creal sc12 = pSinCos[s+0x11*p];
	const creal sc13 = pSinCos[s+0x12*p];
	const creal sc14 = pSinCos[s+0x13*p];
	const creal sc15 = pSinCos[s+0x14*p];
	const creal sc16 = pSinCos[s+0x15*p];
	const creal sc17 = pSinCos[s+0x16*p];

	const creal sc18 = pSinCos[s+0x17*p];
	const creal sc19 = pSinCos[s+0x18*p];
	const creal sc1A = pSinCos[s+0x19*p];
	const creal sc1B = pSinCos[s+0x1A*p];
	const creal sc1C = pSinCos[s+0x1B*p];
	const creal sc1D = pSinCos[s+0x1C*p];
	const creal sc1E = pSinCos[s+0x1D*p];
	const creal sc1F = pSinCos[s+0x1E*p];

	creal u1 = twiddle(m1, sc1);
	creal u2 = twiddle(m2, sc2);
	creal u3 = twiddle(m3, sc3);
	creal u4 = twiddle(m4, sc4);
	creal u5 = twiddle(m5, sc5);
	creal u6 = twiddle(m6, sc6);
	creal u7 = twiddle(m7, sc7);

	creal u8 = twiddle(m8, sc8);
	creal u9 = twiddle(m9, sc9);
	creal uA = twiddle(mA, scA);
	creal uB = twiddle(mB, scB);
	creal uC = twiddle(mC, scC);
	creal uD = twiddle(mD, scD);
	creal uE = twiddle(mE, scE);
	creal uF = twiddle(mF, scF);

	creal u10 = twiddle(m10, sc10);
	creal u11 = twiddle(m11, sc11);
	creal u12 = twiddle(m12, sc12);
	creal u13 = twiddle(m13, sc13);
	creal u14 = twiddle(m14, sc14);
	creal u15 = twiddle(m15, sc15);
	creal u16 = twiddle(m16, sc16);
	creal u17 = twiddle(m17, sc17);

	creal u18 = twiddle(m18, sc18);
	creal u19 = twiddle(m19, sc19);
	creal u1A = twiddle(m1A, sc1A);
	creal u1B = twiddle(m1B, sc1B);
	creal u1C = twiddle(m1C, sc1C);
	creal u1D = twiddle(m1D, sc1D);
	creal u1E = twiddle(m1E, sc1E);
	creal u1F = twiddle(m1F, sc1F);
#else
	creal u1 = twiddle(m1,   angle);
	creal u2 = twiddle(m2, 2*angle);
	creal u3 = twiddle(m3, 3*angle);
	creal u4 = twiddle(m4, 4*angle);
	creal u5 = twiddle(m5, 5*angle);
	creal u6 = twiddle(m6, 6*angle);
	creal u7 = twiddle(m7, 7*angle);

	creal u8 = twiddle(m8,   8*angle);
	creal u9 = twiddle(m9,   9*angle);
	creal uA = twiddle(mA, 0xA*angle);
	creal uB = twiddle(mB, 0xB*angle);
	creal uC = twiddle(mC, 0xC*angle);
	creal uD = twiddle(mD, 0xD*angle);
	creal uE = twiddle(mE, 0xE*angle);
	creal uF = twiddle(mF, 0xF*angle);

	creal u10 = twiddle(m10, 0x10*angle);
	creal u11 = twiddle(m11, 0x11*angle);
	creal u12 = twiddle(m12, 0x12*angle);
	creal u13 = twiddle(m13, 0x13*angle);
	creal u14 = twiddle(m14, 0x14*angle);
	creal u15 = twiddle(m15, 0x15*angle);
	creal u16 = twiddle(m16, 0x16*angle);
	creal u17 = twiddle(m17, 0x17*angle);

	creal u18 = twiddle(m18, 0x18*angle);
	creal u19 = twiddle(m19, 0x19*angle);
	creal u1A = twiddle(m1A, 0x1A*angle);
	creal u1B = twiddle(m1B, 0x1B*angle);
	creal u1C = twiddle(m1C, 0x1C*angle);
	creal u1D = twiddle(m1D, 0x1D*angle);
	creal u1E = twiddle(m1E, 0x1E*angle);
	creal u1F = twiddle(m1F, 0x1F*angle);
#endif

	FFT32(creal, fsign,
		u0, u1, u2, u3, u4, u5, u6, u7,
		u8, u9, uA, uB, uC, uD, uE, uF,
		u10, u11, u12, u13, u14, u15, u16, u17,
		u18, u19, u1A, u1B, u1C, u1D, u1E, u1F);

	pOut[j] = u0;
	pOut[j+p] = u10;
	pOut[j+2*p] = u8;
	pOut[j+3*p] = u18;
	pOut[j+4*p] = u4;
	pOut[j+5*p] = u14;
	pOut[j+6*p] = uC;
	pOut[j+7*p] = u1C;

	pOut[j+8*p] = u2;
	pOut[j+9*p] = u12;
	pOut[j+0xA*p] = uA;
	pOut[j+0xB*p] = u1A;
	pOut[j+0xC*p] = u6;
	pOut[j+0xD*p] = u16;
	pOut[j+0xE*p] = uE;
	pOut[j+0xF*p] = u1E;

	pOut[j+0x10*p] = u1;
	pOut[j+0x11*p] = u11;
	pOut[j+0x12*p] = u9;
	pOut[j+0x13*p] = u19;
	pOut[j+0x14*p] = u5;
	pOut[j+0x15*p] = u15;
	pOut[j+0x16*p] = uD;
	pOut[j+0x17*p] = u1D;

	pOut[j+0x18*p] = u3;
	pOut[j+0x19*p] = u13;
	pOut[j+0x1A*p] = uB;
	pOut[j+0x1B*p] = u1B;
	pOut[j+0x1C*p] = u7;
	pOut[j+0x1D*p] = u17;
	pOut[j+0x1E*p] = uF;
	pOut[j+0x1F*p] = u1F;
	}
}

__kernel void
FftRadix32P1Krnl(__global const creal* restrict pIn, __global creal* restrict pOut,
#ifdef USE_CONST_MEM
	__global const creal* restrict pSinCos, const int scoffset,
#endif
	const realbase fsign, const int p, const int t)
{
	const int i = get_global_id(0);
	if (i < t) {

	const int j = ((i) << 5);
	creal u0 = pIn[i];
	creal u1 = pIn[i+t];
	creal u2 = pIn[i+2*t];
	creal u3 = pIn[i+3*t];
	creal u4 = pIn[i+4*t];
	creal u5 = pIn[i+5*t];
	creal u6 = pIn[i+6*t];
	creal u7 = pIn[i+7*t];

	creal u8 = pIn[i+8*t];
	creal u9 = pIn[i+9*t];
	creal uA = pIn[i+0xA*t];
	creal uB = pIn[i+0xB*t];
	creal uC = pIn[i+0xC*t];
	creal uD = pIn[i+0xD*t];
	creal uE = pIn[i+0xE*t];
	creal uF = pIn[i+0xF*t];

	creal u10 = pIn[i+0x10*t];
	creal u11 = pIn[i+0x11*t];
	creal u12 = pIn[i+0x12*t];
	creal u13 = pIn[i+0x13*t];
	creal u14 = pIn[i+0x14*t];
	creal u15 = pIn[i+0x15*t];
	creal u16 = pIn[i+0x16*t];
	creal u17 = pIn[i+0x17*t];

	creal u18 = pIn[i+0x18*t];
	creal u19 = pIn[i+0x19*t];
	creal u1A = pIn[i+0x1A*t];
	creal u1B = pIn[i+0x1B*t];
	creal u1C = pIn[i+0x1C*t];
	creal u1D = pIn[i+0x1D*t];
	creal u1E = pIn[i+0x1E*t];
	creal u1F = pIn[i+0x1F*t];

	FFT32(creal, fsign,
		u0, u1, u2, u3, u4, u5, u6, u7,
		u8, u9, uA, uB, uC, uD, uE, uF,
		u10, u11, u12, u13, u14, u15, u16, u17,
		u18, u19, u1A, u1B, u1C, u1D, u1E, u1F);

	pOut[j] = u0;
	pOut[j+p] = u10;
	pOut[j+2*p] = u8;
	pOut[j+3*p] = u18;
	pOut[j+4*p] = u4;
	pOut[j+5*p] = u14;
	pOut[j+6*p] = uC;
	pOut[j+7*p] = u1C;

	pOut[j+8*p] = u2;
	pOut[j+9*p] = u12;
	pOut[j+0xA*p] = uA;
	pOut[j+0xB*p] = u1A;
	pOut[j+0xC*p] = u6;
	pOut[j+0xD*p] = u16;
	pOut[j+0xE*p] = uE;
	pOut[j+0xF*p] = u1E;

	pOut[j+0x10*p] = u1;
	pOut[j+0x11*p] = u11;
	pOut[j+0x12*p] = u9;
	pOut[j+0x13*p] = u19;
	pOut[j+0x14*p] = u5;
	pOut[j+0x15*p] = u15;
	pOut[j+0x16*p] = uD;
	pOut[j+0x17*p] = u1D;

	pOut[j+0x18*p] = u3;
	pOut[j+0x19*p] = u13;
	pOut[j+0x1A*p] = uB;
	pOut[j+0x1B*p] = u1B;
	pOut[j+0x1C*p] = u7;
	pOut[j+0x1D*p] = u17;
	pOut[j+0x1E*p] = uF;
	pOut[j+0x1F*p] = u1F;
	}
}


#ifdef USE_CONST_MEM

__kernel void
FftSinCos(__global creal* restrict pSinCos,
	const realbase fPiInvPR,
	const int p, const int t, const int scoffset)
{
	const int k = get_global_id(0);
	if (k < t) {

		const int kd = k/p + 1;
		const int kx = k & (p-1);
				const real angle = (real)(kd*kx)*fPiInvPR;

				real sina, cosa;
		sina = rsincos(angle, &cosa);

				const int s = scoffset + k;
		pSinCos[s] = (creal)(cosa, sina);

	}
}

#endif


// buildOptions=
// RUN: %occ-cli %s --cl-options="-I%cwd -I%S " %cfg_path --cl-device=%cl_device 2>&1
