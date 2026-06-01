#define FILTER_RAD 12
#define FILTER_SIZE 25

__constant float filterWeights[ 25 ] =
{
0.001544296741485596f,
0.002985666738823056f,
0.005450720898807049f,
0.009396557696163654f,
0.01529629901051521f,
0.02351294085383415f,
0.03412957116961479f,
0.04677980020642281f,
0.06054658070206642f,
0.0739988312125206f,
0.0854012593626976f,
0.09306959062814713f,
0.0957757756114006f,
0.09306960552930832f,
0.085401251912117f,
0.0739988312125206f,
0.06054656580090523f,
0.04677978903055191f,
0.0341295562684536f,
0.02351293154060841f,
0.01529629342257977f,
0.009396553970873356f,
0.005450717639178038f,
0.002985665109008551f,
0.001544295926578343f
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
