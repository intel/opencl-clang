inline float2 cplxMul(const float2 cmplxA, const float2 cmplxB)
{
    return (float2)(cmplxA.x*cmplxB.x - cmplxA.y*cmplxB.y, cmplxA.x*cmplxB.y + cmplxA.y*cmplxB.x);
}

inline float2 twiddle(const float2 a, const int k, const float alpha)
{
    //float sn = sin(k*alpha);
    //float cs = cos(k*alpha);

    float sn = native_sin(k*alpha);
    float cs = native_cos(k*alpha);

    return cplxMul(a, (float2)(cs,sn));
}

__constant float SQRT_1_2 = 0.707106781188f;

inline float2 mul_p0q2(float2 a) { return a; }
inline float2 mul_p1q2(float2 a) { return (float2)(a.y,-a.x); }

inline float2 mul_p0q4(float2 a) { return a; }
inline float2 mul_p1q4(float2 a) { return (float2)(SQRT_1_2*(a.x+a.y),SQRT_1_2*(-a.x+a.y)); }
inline float2 mul_p2q4(float2 a) { return (float2)(a.y,-a.x); }
inline float2 mul_p3q4(float2 a) { return (float2)(SQRT_1_2*(-a.x+a.y),SQRT_1_2*(-a.x-a.y)); }

__kernel void fftRadix8( __global const float2* restrict dataIn, __global float2* restrict dataOut, const int iStage)
{
	unsigned int iThread = get_global_id(0);
	//unsigned int nThread = get_global_size(0);

	int subSeqLength = (1<<(3*iStage));

	int tps = 512 / 8;
	int inputOffset = (iThread / tps) * 512;
	iThread = iThread&(tps-1);

	int inSeqIdx = iThread&(subSeqLength-1);
	int outIdx = ((iThread-inSeqIdx)<<3) + inSeqIdx;
	float alpha = -M_PI_F * inSeqIdx / (4.0f*subSeqLength);

	// read and twiddle input
	float2 u0 = dataIn[iThread + inputOffset];
	float2 u1 = twiddle(dataIn[iThread + 1*tps + inputOffset], 1, alpha);
	float2 u2 = twiddle(dataIn[iThread + 2*tps + inputOffset], 2, alpha);
	float2 u3 = twiddle(dataIn[iThread + 3*tps + inputOffset], 3, alpha);
	float2 u4 = twiddle(dataIn[iThread + 4*tps + inputOffset], 4, alpha);
	float2 u5 = twiddle(dataIn[iThread + 5*tps + inputOffset], 5, alpha);
	float2 u6 = twiddle(dataIn[iThread + 6*tps + inputOffset], 6, alpha);
	float2 u7 = twiddle(dataIn[iThread + 7*tps + inputOffset], 7, alpha);

	// 4x DFT2 and twiddle
	float2 v0 = u0 + u4;
	float2 v1 = u1 + u5;
	float2 v2 = u2 + u6;
	float2 v3 = u3 + u7;
	float2 v4 = mul_p0q4(u0 - u4);
	float2 v5 = mul_p1q4(u1 - u5);
	float2 v6 = mul_p2q4(u2 - u6);
	float2 v7 = mul_p3q4(u3 - u7);

	// 4x DFT2 and twiddle
	u0 = v0 + v2;
	u1 = v1 + v3;
	u2 = mul_p0q2(v0 - v2);
	u3 = mul_p1q2(v1 - v3);
	u4 = v4 + v6;
	u5 = v5 + v7;
	u6 = mul_p0q2(v4 - v6);
	u7 = mul_p1q2(v5 - v7);

	// 4x DFT2 and write
	dataOut[outIdx+inputOffset] = u0 + u1;
	dataOut[outIdx+1*subSeqLength+inputOffset] = u4 + u5;
	dataOut[outIdx+2*subSeqLength+inputOffset] = u2 + u3;
	dataOut[outIdx+3*subSeqLength+inputOffset] = u6 + u7;
	dataOut[outIdx+4*subSeqLength+inputOffset] = u0 - u1;
	dataOut[outIdx+5*subSeqLength+inputOffset] = u4 - u5;
	dataOut[outIdx+6*subSeqLength+inputOffset] = u2 - u3;
	dataOut[outIdx+7*subSeqLength+inputOffset] = u6 - u7;
}

__kernel void fftScale( __global float2* data )
{
	unsigned int x = get_global_id(0);
	unsigned int y = get_global_id(1);

	unsigned int size = get_global_size(0) * get_global_size(1);

	unsigned int id = y * get_global_size(0) + x;

	data[id] = data[id] / (float2)(size,size);
}

__kernel void fftSwapReIm( __global float2* data )
{
	unsigned int id = get_global_id(0);
	data[id] = data[id].yx;
}

#define FFT_POINTS 512

__kernel __attribute__((reqd_work_group_size (64,1,1)))
void fftRadix8LDS512( __global const float2* restrict dataIn, __global float2* restrict dataOut)
{
	unsigned int lThread = get_local_id(0);
	//unsigned int nThread = get_global_size(0);
	unsigned int group_id = get_group_id(0);

	__local float2 lds[FFT_POINTS];

	lds[lThread+64*0] = dataIn[lThread+64*0 + group_id*FFT_POINTS].yx;
	lds[lThread+64*1] = dataIn[lThread+64*1 + group_id*FFT_POINTS].yx;
	lds[lThread+64*2] = dataIn[lThread+64*2 + group_id*FFT_POINTS].yx;
	lds[lThread+64*3] = dataIn[lThread+64*3 + group_id*FFT_POINTS].yx;
	lds[lThread+64*4] = dataIn[lThread+64*4 + group_id*FFT_POINTS].yx;
	lds[lThread+64*5] = dataIn[lThread+64*5 + group_id*FFT_POINTS].yx;
	lds[lThread+64*6] = dataIn[lThread+64*6 + group_id*FFT_POINTS].yx;
	lds[lThread+64*7] = dataIn[lThread+64*7 + group_id*FFT_POINTS].yx;
	barrier(CLK_LOCAL_MEM_FENCE);

	#pragma unroll
	for(int iStage = 0 ; iStage < 3; ++iStage)
	{
		int subSeqLength = (1<<(3*iStage));

		int inSeqIdx = lThread&(subSeqLength-1);
		int outIdx = ((lThread-inSeqIdx)<<3) + inSeqIdx;
		float alpha = -M_PI_F * inSeqIdx / (4.0f*subSeqLength);

		// read and twiddle input
		float2 u0 =			lds[lThread+64*0];
		float2 u1 = twiddle(lds[lThread+64*1], 1, alpha);
		float2 u2 = twiddle(lds[lThread+64*2], 2, alpha);
		float2 u3 = twiddle(lds[lThread+64*3], 3, alpha);
		float2 u4 = twiddle(lds[lThread+64*4], 4, alpha);
		float2 u5 = twiddle(lds[lThread+64*5], 5, alpha);
		float2 u6 = twiddle(lds[lThread+64*6], 6, alpha);
		float2 u7 = twiddle(lds[lThread+64*7], 7, alpha);

		// 4x DFT2 and twiddle
		float2 v0 = u0 + u4;
		float2 v1 = u1 + u5;
		float2 v2 = u2 + u6;
		float2 v3 = u3 + u7;
		float2 v4 = mul_p0q4(u0 - u4);
		float2 v5 = mul_p1q4(u1 - u5);
		float2 v6 = mul_p2q4(u2 - u6);
		float2 v7 = mul_p3q4(u3 - u7);

		// 4x DFT2 and twiddle
		u0 = v0 + v2;
		u1 = v1 + v3;
		u2 = mul_p0q2(v0 - v2);
		u3 = mul_p1q2(v1 - v3);
		u4 = v4 + v6;
		u5 = v5 + v7;
		u6 = mul_p0q2(v4 - v6);
		u7 = mul_p1q2(v5 - v7);

		// 4x DFT2 and write
		barrier(CLK_LOCAL_MEM_FENCE);

		lds[outIdx+0*subSeqLength] = u0 + u1;
		lds[outIdx+1*subSeqLength] = u4 + u5;
		lds[outIdx+2*subSeqLength] = u2 + u3;
		lds[outIdx+3*subSeqLength] = u6 + u7;
		lds[outIdx+4*subSeqLength] = u0 - u1;
		lds[outIdx+5*subSeqLength] = u4 - u5;
		lds[outIdx+6*subSeqLength] = u2 - u3;
		lds[outIdx+7*subSeqLength] = u6 - u7;

		barrier(CLK_LOCAL_MEM_FENCE);
	}

	dataOut[lThread+64*0 + group_id*FFT_POINTS] = lds[lThread+64*0].yx;
	dataOut[lThread+64*1 + group_id*FFT_POINTS] = lds[lThread+64*1].yx;
	dataOut[lThread+64*2 + group_id*FFT_POINTS] = lds[lThread+64*2].yx;
	dataOut[lThread+64*3 + group_id*FFT_POINTS] = lds[lThread+64*3].yx;
	dataOut[lThread+64*4 + group_id*FFT_POINTS] = lds[lThread+64*4].yx;
	dataOut[lThread+64*5 + group_id*FFT_POINTS] = lds[lThread+64*5].yx;
	dataOut[lThread+64*6 + group_id*FFT_POINTS] = lds[lThread+64*6].yx;
	dataOut[lThread+64*7 + group_id*FFT_POINTS] = lds[lThread+64*7].yx;
}


// buildOptions=-cl-fast-relaxed-math
// RUN: %occ-cli %s --cl-options="-I%cwd -I%S -cl-fast-relaxed-math" %cfg_path --cl-device=%cl_device 2>&1
