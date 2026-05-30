
#define USE_MAD

#if defined(USE_DOUBLE)

#if defined(cl_khr_fp64)
#pragma OPENCL EXTENSION cl_khr_fp64 : enable
#elif defined(cl_amd_fp64)
#pragma OPENCL EXTENSION cl_amd_fp64 : enable
#else
#error "FP64 not supported!"
#endif

#define real			double
#define realbase		double
#define REAL(x)			x

#elif defined(USE_HALF)

#if defined(cl_khr_fp16)
#pragma OPENCL EXTENSION cl_khr_fp16 : enable
#else
#error "FP16 not supported!"
#endif

#define real			half
#define realbase		float
#define REAL(x)			x ## h

#else

#define real			float
#define realbase		float
#define REAL(x)			x ## f

#endif


struct TOptionData
{
    real	S;
    real	X;
    real	T;
    real	R;
    real	V;

	real	filler;
};

struct TCallData
{
	real	CallResult;
	real	PutResult;
};


inline real cndVal(const real d)
{
    const real       A1 = REAL(0.31938153);
    const real       A2 = REAL(-0.356563782);
    const real       A3 = REAL(1.781477937);
    const real       A4 = REAL(-1.821255978);
    const real       A5 = REAL(1.330274429);
    const real RSQRT2PI = REAL(0.39894228040143267793994605993438);

    const real K = REAL(1.0) / (REAL(1.0) + REAL(0.2316419) * fabs(d));

    const real cnd = RSQRT2PI * exp( REAL(-0.5) * d * d) *
          (K * (A1 + K * (A2 + K * (A3 + K * (A4 + K * A5)))));

    return (d > REAL(0.0)) ? (REAL(1.0) - cnd) : (cnd);
}

inline void BlackScholes(__global const struct TOptionData* restrict optionData,
	__global struct TCallData* restrict callData)
{
    const real S = optionData->S;
    const real X = optionData->X;
    const real T = optionData->T;
    const real R = optionData->R;
    const real V = optionData->V;

    const real sqrtT = sqrt(T);
    const real d1 = (log(S / X) + (R + REAL(0.5) * V * V) * T) / (V * sqrtT);
    const real d2 = d1 - V * sqrtT;

    const real CNDD1 = cndVal(d1);
    const real CNDD2 = cndVal(d2);

        const real expRT = exp( -R * T);

    callData->CallResult = S * CNDD1 - X * expRT * CNDD2;
    callData->PutResult  = X * expRT * (REAL(1.0) - CNDD2) - S * (REAL(1.0) - CNDD1);
}


__kernel void MainKernel(__global const struct TOptionData* restrict pOptionData,
	__global struct TCallData* restrict pCallData,
	const uint iOptN)
{
        const size_t tid = get_global_id(0);
    const size_t THREAD_N = get_global_size(0);

            for (size_t opt = tid; opt < iOptN; opt += THREAD_N) {
        BlackScholes(&pOptionData[opt], &pCallData[opt]);
	}
}


// buildOptions=
// RUN: %occ-cli %s --cl-options="-I%cwd -I%S " %cfg_path --cl-device=%cl_device 2>&1
