#define FILTER_RAD 8
#define FILTER_SIZE 17

__constant float filterWeights[ 17 ] =
{
0.002717046067118645f,
0.006850321777164936f,
0.01526735629886389f,
0.03007882833480835f,
0.05238497629761696f,
0.08065012842416763f,
0.1097637116909027f,
0.1320596635341644f,
0.1404560655355454f,
0.1320596486330032f,
0.1097636967897415f,
0.08065009117126465f,
0.05238495022058487f,
0.03007880970835686f,
0.01526734605431557f,
0.006850316654890776f,
0.002717043738812208f
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
