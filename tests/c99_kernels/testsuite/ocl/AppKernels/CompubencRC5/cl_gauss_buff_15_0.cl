#define FILTER_RAD 14
#define FILTER_SIZE 29

__constant float filterWeights[ 29 ] =
{
0.001263737911358476f,
0.002247713273391128f,
0.00383088830858469f,
0.006256518885493279f,
0.009791315533220768f,
0.01468331925570965f,
0.0211000107228756f,
0.02905469760298729f,
0.03833762928843498f,
0.04847408458590508f,
0.05873128399252892f,
0.06818751245737076f,
0.07586051523685455f,
0.08087278157472611f,
0.08261608332395554f,
0.08087277412414551f,
0.07586052268743515f,
0.06818750500679016f,
0.05873127654194832f,
0.04847408086061478f,
0.03833762183785439f,
0.02905468456447125f,
0.02110000140964985f,
0.01468331459909678f,
0.00979131180793047f,
0.006256517954170704f,
0.003830885980278254f,
0.002247711876407266f,
0.001263737212866545f
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
