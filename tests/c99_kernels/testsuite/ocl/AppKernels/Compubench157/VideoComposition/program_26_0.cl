#define USE_UCHAR4

__constant float filterWeights[ 39 ] =
{
0.000864968f,
0.00133903f,
0.00202453f,
0.00298949f,
0.00431133f,
0.00607248f,
0.00835338f,
0.0112227f,
0.0147257f,
0.0188711f,
0.0236187f,
0.0288707f,
0.0344667f,
0.0401867f,
0.0457622f,
0.0508946f,
0.0552813f,
0.0586443f,
0.0607595f,
0.0614813f,
0.0607594f,
0.0586443f,
0.0552813f,
0.0508946f,
0.0457622f,
0.0401867f,
0.0344667f,
0.0288707f,
0.0236187f,
0.0188711f,
0.0147257f,
0.0112227f,
0.00835338f,
0.00607248f,
0.00431133f,
0.00298949f,
0.00202453f,
0.00133903f,
0.000864967f
};

#ifdef USE_FLOAT4
	#define DATATYPE float4
	#define DATATYPEIMG float4
	#define READIMG read_imagef
	#define WRITEIMG write_imagef
	#define CONVERTU4(x) x
	#define CONVERTU4IMG(x) x
	#define CONVERTF4
#endif

#ifdef USE_UCHAR4
	#define DATATYPE uchar4
	#define DATATYPEIMG uint4
	#define WRITEIMG write_imageui
	#define READIMG read_imageui
	#define CONVERTU4(x) convert_uchar4(x+(float4)(0.5f))
	#define CONVERTU4IMG(x) convert_uint4(x+(float4)(0.5f))
	#define CONVERTF4 convert_float4
#endif

__kernel void gauss1DBuffer
(
	__global const DATATYPE* restrict input,
	__global DATATYPE* restrict output
)
{
	const int pX = get_global_id(0);
	const int pY = get_global_id(1);

	const int IMAGE_W = get_global_size(0);
	const int IMAGE_H = get_global_size(1);

	float4 out = CONVERTF4( input[pY * IMAGE_W + pX] ) * filterWeights[ FILTER_RAD ];

	for(int r = 0; r < FILTER_RAD; ++r)
	{
		const DATATYPE c0 = input[pY * IMAGE_W + max(pX + (r - FILTER_RAD),			0)];
		const DATATYPE c1 = input[pY * IMAGE_W + min(pX + (FILTER_RAD - r), IMAGE_W-1)];

#ifdef USE_UCHAR4
		out += CONVERTF4(c0) * filterWeights[ r ];
		out += CONVERTF4(c1) * filterWeights[ r ];
#else
		out += CONVERTF4(c0+c0) * filterWeights[ r ];
#endif
	}

	// out = in
	//output[pY * IMAGE_W + pX] = CONVERTU4(out);

	// out = transposed in
	output[pX * IMAGE_H + pY] = CONVERTU4(out);
}

__kernel void gauss1DImage
(
	__read_only image2d_t input,
	__write_only image2d_t output
)
{
	const sampler_t sampler =
		CLK_NORMALIZED_COORDS_FALSE |
		CLK_ADDRESS_CLAMP_TO_EDGE |
		CLK_FILTER_NEAREST;

	const int pX = get_global_id(0);
	const int pY = get_global_id(1);

	float4 out = CONVERTF4( READIMG(input, sampler, (int2)(pX,pY)) ) * filterWeights[ FILTER_RAD ];

	for(int r = 0; r < FILTER_RAD; ++r)
	{
		const DATATYPEIMG c0 = READIMG(input, sampler, (int2)(pX + (r - FILTER_RAD), pY));
		const DATATYPEIMG c1 = READIMG(input, sampler, (int2)(pX + (FILTER_RAD - r), pY));

		out += CONVERTF4(c0) * filterWeights[ r ];
		out += CONVERTF4(c1) * filterWeights[ r ];
	}

	// out = in
	//WRITEIMG(output, (int2)(pX, pY), CONVERTU4IMG(out));

	// out = transposed in
	WRITEIMG(output, (int2)(pY,pX), CONVERTU4IMG(out));
}


// buildOptions=-cl-fast-relaxed-math -D FILTER_RAD=19 -D FILTER_SIZE=39
// RUN: %occ-cli %s --cl-options="-I%cwd -I%S -cl-fast-relaxed-math -D FILTER_RAD=19 -D FILTER_SIZE=39" %cfg_path --cl-device=%cl_device 2>&1
