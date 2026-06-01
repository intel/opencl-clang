#define FILTER_RAD 15
#define FILTER_SIZE 31

__constant float filterWeights[ 31 ] =
{
0.001157727907411754f,
0.001989654498174787f,
0.003294046502560377f,
0.005253667943179607f,
0.008071915246546269f,
0.01194735523313284f,
0.01703523471951485f,
0.02339945174753666f,
0.03096310794353485f,
0.03946979716420174f,
0.04846926778554916f,
0.05733894929289818f,
0.06534528732299805f,
0.07173984497785568f,
0.07587315142154694f,
0.07730317860841751f,
0.07587313652038574f,
0.07173984497785568f,
0.06534528732299805f,
0.05733893439173698f,
0.04846926406025887f,
0.03946977853775024f,
0.03096309863030911f,
0.02339944429695606f,
0.0170352291315794f,
0.01194735337048769f,
0.008071913383901119f,
0.005253666546195746f,
0.003294044872745872f,
0.001989653799682856f,
0.001157727558165789f
};

#define USE_UCHAR4

#ifdef USE_UCHAR4
	#define DATATYPE uchar4
	#define DATATYPEIMG uint4
	#define WRITEIMG write_imageui
	#define READIMG read_imageui
	#define CONVERTU4(x) convert_uchar4(x+(float4)(0.5f))
	#define CONVERTU4IMG(x) convert_uint4(x+(float4)(0.5f))
	#define CONVERTF4 convert_float4
#endif

__kernel void gauss
(
	__global const DATATYPE* restrict input,
	__global DATATYPE* restrict output
)
{
	const int pX = get_global_id(0);
	const int pY = get_global_id(1);

	const int IMAGE_W = get_global_size(0);
	const int IMAGE_H = get_global_size(1);

	float4 out = CONVERTF4( input[pY * IMAGE_W + pX] );
	out *= filterWeights[ FILTER_RAD ];

	for(int r = 0; r < FILTER_RAD; ++r)
	{
		const DATATYPE c0 = input[pY * IMAGE_W + max(pX + (r - FILTER_RAD),			0)];
		const DATATYPE c1 = input[pY * IMAGE_W + min(pX + (FILTER_RAD - r), IMAGE_W-1)];

		out += CONVERTF4(c0) * filterWeights[ r ];
		out += CONVERTF4(c1) * filterWeights[ r ];
	}

	// out = transposed in
	output[pX * IMAGE_H + pY] = CONVERTU4(out);
}


// buildOptions=-cl-fast-relaxed-math
// RUN: %occ-cli %s --cl-options="-I%cwd -I%S -cl-fast-relaxed-math" %cfg_path --cl-device=%cl_device 2>&1
