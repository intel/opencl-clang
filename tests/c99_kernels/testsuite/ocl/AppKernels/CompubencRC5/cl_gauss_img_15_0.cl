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

//@ FILTER_RAD,filterWeights

__kernel
void gauss
(
	__read_only image2d_t srcImg,
	__write_only image2d_t dstImg
)
{
	const int pX = get_global_id(0);
	const int pY = get_global_id(1);

	const sampler_t sampler =
		CLK_NORMALIZED_COORDS_FALSE |
		CLK_ADDRESS_CLAMP_TO_EDGE |
		CLK_FILTER_NEAREST;

	float4 out = read_imagef(srcImg, sampler, (int2)(pX, pY));
	out *= filterWeights[ FILTER_RAD ];

	for(int r = 0; r < FILTER_RAD; ++r)
	{
		float4 c0 = read_imagef(srcImg, sampler, (int2)(pX + (r - FILTER_RAD), pY));
		float4 c1 = read_imagef(srcImg, sampler, (int2)(pX + (FILTER_RAD - r), pY));

		out += c0 * filterWeights[r];
		out += c1 * filterWeights[r];
	}

	//// out = transposed in
	write_imagef(dstImg, (int2)(pY,pX), out);
}


// buildOptions=-cl-fast-relaxed-math
// RUN: %occ-cli %s --cl-options="-I%cwd -I%S -cl-fast-relaxed-math" %cfg_path --cl-device=%cl_device 2>&1
