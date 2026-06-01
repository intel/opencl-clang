#define FILTER_RAD 10
#define FILTER_SIZE 21

__constant float filterWeights[ 21 ] =
{
0.001976305386051536f,
0.004269676748663187f,
0.008505838923156261f,
0.01562506519258022f,
0.0264673363417387f,
0.04134121164679527f,
0.05954451858997345f,
0.0790836289525032f,
0.09685413539409638f,
0.1093797609210014f,
0.1139051094651222f,
0.1093797609210014f,
0.09685412049293518f,
0.07908362150192261f,
0.05954449996352196f,
0.04134120419621468f,
0.02646732144057751f,
0.01562505774199963f,
0.008505835197865963f,
0.004269673489034176f,
0.001976303523406386f
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
