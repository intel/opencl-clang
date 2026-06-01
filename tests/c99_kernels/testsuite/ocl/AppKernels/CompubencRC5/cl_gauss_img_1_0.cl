#define FILTER_RAD 0
#define FILTER_SIZE 1

__constant float filterWeights[ 1 ] =
{
1.0f
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
