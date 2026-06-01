#define FILTER_RAD 9
#define FILTER_SIZE 19

__constant float filterWeights[ 19 ] =
{
0.002291248878464103f,
0.005311185959726572f,
0.01115189492702484f,
0.02121027000248432f,
0.03654151037335396f,
0.05702579766511917f,
0.08061249554157257f,
0.1032240390777588f,
0.1197312623262405f,
0.1258006989955902f,
0.1197312474250794f,
0.1032240316271782f,
0.08061248064041138f,
0.05702577903866768f,
0.03654148802161217f,
0.02121025882661343f,
0.01115188654512167f,
0.005311182234436274f,
0.002291247248649597f
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
