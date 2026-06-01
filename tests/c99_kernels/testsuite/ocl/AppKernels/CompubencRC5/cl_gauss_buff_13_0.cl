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
