#define USE_UCHAR4

__constant float filterWeights[ 45 ] =
{
0.000726154f,
0.00106361f,
0.00153047f,
0.0021635f,
0.00300456f,
0.00409917f,
0.00549415f,
0.00723429f,
0.00935798f,
0.0118921f,
0.0148466f,
0.0182089f,
0.0219398f,
0.02597f,
0.0301996f,
0.0345002f,
0.0387198f,
0.0426908f,
0.0462409f,
0.049205f,
0.0514379f,
0.0528259f,
0.0532969f,
0.0528259f,
0.0514379f,
0.049205f,
0.046241f,
0.0426908f,
0.0387198f,
0.0345002f,
0.0301996f,
0.02597f,
0.0219398f,
0.0182089f,
0.0148466f,
0.0118921f,
0.00935798f,
0.00723429f,
0.00549415f,
0.00409916f,
0.00300456f,
0.0021635f,
0.00153047f,
0.00106361f,
0.000726154f
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


// buildOptions=-cl-fast-relaxed-math -D FILTER_RAD=22 -D FILTER_SIZE=45
// RUN: %occ-cli %s --cl-options="-I%cwd -I%S -cl-fast-relaxed-math -D FILTER_RAD=22 -D FILTER_SIZE=45" %cfg_path --cl-device=%cl_device 2>&1
