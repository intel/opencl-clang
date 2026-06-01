#define FILTER_RAD 11
#define FILTER_SIZE 23

__constant float filterWeights[ 23 ] =
{
0.001734826248139143f,
0.003530573099851608f,
0.006714947987347841f,
0.01193572673946619f,
0.0198273491114378f,
0.03078155219554901f,
0.04466084390878677f,
0.06055838614702225f,
0.07674197852611542f,
0.09088732302188873f,
0.1005970910191536f,
0.1040589511394501f,
0.1005970910191536f,
0.09088733792304993f,
0.07674197852611542f,
0.06055837497115135f,
0.04466082900762558f,
0.03078154288232327f,
0.01982733979821205f,
0.01193571835756302f,
0.006714943796396256f,
0.003530571004375815f,
0.001734825200401247f
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
