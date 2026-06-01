#define FILTER_RAD 15
#define FILTER_SIZE 31

__constant float filterWeights[ 31 ] =
{
0.001157727907411754f,
0.001989654498174787f,
0.003294046502560377f,
0.005253667943179607f,
0.008071915246546269f,
0.01194735523313284f,
0.01703523471951485f,
0.02339945174753666f,
0.03096310794353485f,
0.03946979716420174f,
0.04846926778554916f,
0.05733894929289818f,
0.06534528732299805f,
0.07173984497785568f,
0.07587315142154694f,
0.07730317860841751f,
0.07587313652038574f,
0.07173984497785568f,
0.06534528732299805f,
0.05733893439173698f,
0.04846926406025887f,
0.03946977853775024f,
0.03096309863030911f,
0.02339944429695606f,
0.0170352291315794f,
0.01194735337048769f,
0.008071913383901119f,
0.005253666546195746f,
0.003294044872745872f,
0.001989653799682856f,
0.001157727558165789f
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
