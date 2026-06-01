#define USE_UCHAR4

__constant float filterWeights[ 107 ] =
{
0.000271225f,
0.000319893f,
0.000376109f,
0.000440817f,
0.000515035f,
0.000599861f,
0.000696465f,
0.000806088f,
0.000930037f,
0.00106968f,
0.00122642f,
0.00140172f,
0.00159705f,
0.00181389f,
0.0020537f,
0.00231792f,
0.00260793f,
0.002925f,
0.00327033f,
0.00364496f,
0.00404974f,
0.00448536f,
0.00495225f,
0.00545057f,
0.0059802f,
0.00654071f,
0.0071313f,
0.00775081f,
0.00839771f,
0.00907003f,
0.00976544f,
0.0104812f,
0.011214f,
0.0119605f,
0.0127166f,
0.0134781f,
0.0142403f,
0.0149984f,
0.0157473f,
0.0164817f,
0.0171962f,
0.0178854f,
0.0185438f,
0.0191661f,
0.0197471f,
0.0202818f,
0.0207657f,
0.0211944f,
0.021564f,
0.0218712f,
0.0221132f,
0.0222877f,
0.022393f,
0.0224282f,
0.022393f,
0.0222877f,
0.0221132f,
0.0218712f,
0.021564f,
0.0211944f,
0.0207657f,
0.0202818f,
0.0197471f,
0.0191661f,
0.0185438f,
0.0178854f,
0.0171962f,
0.0164817f,
0.0157473f,
0.0149984f,
0.0142403f,
0.0134781f,
0.0127166f,
0.0119605f,
0.011214f,
0.0104812f,
0.00976544f,
0.00907003f,
0.00839771f,
0.00775081f,
0.0071313f,
0.00654071f,
0.0059802f,
0.00545057f,
0.00495225f,
0.00448536f,
0.00404974f,
0.00364496f,
0.00327033f,
0.002925f,
0.00260793f,
0.00231792f,
0.0020537f,
0.00181389f,
0.00159705f,
0.00140172f,
0.00122642f,
0.00106968f,
0.000930037f,
0.000806087f,
0.000696464f,
0.000599861f,
0.000515035f,
0.000440817f,
0.000376109f,
0.000319893f,
0.000271225f
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


// buildOptions=-cl-fast-relaxed-math -D FILTER_RAD=53 -D FILTER_SIZE=107
// RUN: %occ-cli %s --cl-options="-I%cwd -I%S -cl-fast-relaxed-math -D FILTER_RAD=53 -D FILTER_SIZE=107" %cfg_path --cl-device=%cl_device 2>&1
