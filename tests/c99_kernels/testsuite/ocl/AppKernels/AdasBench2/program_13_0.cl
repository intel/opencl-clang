#define CONVOLUTION_TYPE 3
#if CONVOLUTION_TYPE == 0
	typedef float T;
	typedef float K;
	float mul(float val1, float val2) { return val1 * val2; }
	float div(float val1, float val2) { return val1 / val2; }
#elif CONVOLUTION_TYPE == 1
	typedef float4 T;
	typedef float4 K;
	float4 mul(float val1, float4 val2) { return val1 * val2; }
	float4 div(float4 val1, float val2) { return val1 / val2; }
#elif CONVOLUTION_TYPE == 2
	typedef int T;
	typedef float K;
	float mul(float val1, int val2) { return val1 * convert_float(val2); }
	int div(float val1, float val2) { return convert_int(val1 / val2); }
#elif CONVOLUTION_TYPE == 3
	typedef int4 T;
	typedef float4 K;
	float4 mul(float val1, int4 val2) { return val1 * convert_float4(val2); }
	int4 div(float4 val1, float val2) { return convert_int4(val1 / val2); }
#elif CONVOLUTION_TYPE == 4
	typedef uchar T;
	typedef float K;
	float mul(float val1, uchar val2) { return val1 * convert_float(val2); }
	uchar div(float val1, float val2) { return convert_uchar(val1 / val2); }
#elif CONVOLUTION_TYPE == 5
	typedef uchar4 T;
	typedef float4 K;
	float4 mul(float val1, uchar4 val2) { return val1 * convert_float4(val2); }
	uchar4 div(float4 val1, float val2) { return convert_uchar4(val1 / val2); }
#endif

__kernel void buffer_convolution( __global T *input,
								  __global T *output,
								  __constant float *ckernel,
								  const int kernel_size )
{
	const int x = get_global_id(0);
	const int y = get_global_id(1);
	const int width = get_global_size(0);
	const int height = get_global_size(1);

	const int half_size = kernel_size / 2;

	const int start_y	= y - half_size;
	const int end_y		= y + half_size;
	const int start_x	= x - half_size;
	const int end_x		= x + half_size;

	K sum = 0;
	int counter = 0;
	float kernel_sum = 0.0f;
	for (int yi = start_y; yi<=end_y; ++yi)
		for (int xi = start_x; xi<=end_x; ++xi)
		{
			const int h = min( max(0, yi), height-1);
			const int w = min( max(0, xi), width-1);
			T p = input[h*width + w];
			sum += mul(ckernel[counter], p);
			kernel_sum += ckernel[counter];
			++counter;
		}

	output[y*width + x] = div(sum, kernel_sum);
}



// buildOptions=
// RUN: %occ-cli %s --cl-options="-I%cwd -I%S " %cfg_path --cl-device=%cl_device 2>&1
