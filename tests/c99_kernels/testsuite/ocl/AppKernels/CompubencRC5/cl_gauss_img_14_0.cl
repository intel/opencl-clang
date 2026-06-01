#define FILTER_RAD 13
#define FILTER_SIZE 27

__constant float filterWeights[ 27 ] =
{
0.001390425022691488f,
0.002571211894974113f,
0.004526556469500065f,
0.00758643914014101f,
0.01210454292595387f,
0.01838650740683079f,
0.0265883132815361f,
0.03660354390740395f,
0.04797293990850449f,
0.05985641106963158f,
0.07109943777322769f,
0.08040126413106918f,
0.08655675500631332f,
0.08871155977249146f,
0.08655675500631332f,
0.08040126413106918f,
0.0710994228720665f,
0.05985639989376068f,
0.04797292500734329f,
0.03660352900624275f,
0.02658830396831036f,
0.01838650181889534f,
0.01210453826934099f,
0.007586436811834574f,
0.004526553675532341f,
0.002571210497990251f,
0.001390424207784236f
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
