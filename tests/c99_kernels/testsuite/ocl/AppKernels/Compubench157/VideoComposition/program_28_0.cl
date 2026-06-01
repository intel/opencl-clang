#define USE_UCHAR4

__constant float filterWeights[ 43 ] =
{
0.000767266f,
0.0011429f,
0.00166966f,
0.00239225f,
0.00336157f,
0.00463272f,
0.00626163f,
0.00830036f,
0.0107911f,
0.0137591f,
0.0172057f,
0.0211015f,
0.0253813f,
0.0299413f,
0.0346406f,
0.039306f,
0.0437411f,
0.0477396f,
0.0511006f,
0.0536452f,
0.0552325f,
0.0557719f,
0.0552324f,
0.0536453f,
0.0511006f,
0.0477396f,
0.0437411f,
0.039306f,
0.0346406f,
0.0299413f,
0.0253813f,
0.0211015f,
0.0172057f,
0.0137591f,
0.0107911f,
0.00830035f,
0.00626163f,
0.00463271f,
0.00336157f,
0.00239225f,
0.00166966f,
0.0011429f,
0.000767266f
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


// buildOptions=-cl-fast-relaxed-math -D FILTER_RAD=21 -D FILTER_SIZE=43
// RUN: %occ-cli %s --cl-options="-I%cwd -I%S -cl-fast-relaxed-math -D FILTER_RAD=21 -D FILTER_SIZE=43" %cfg_path --cl-device=%cl_device 2>&1
