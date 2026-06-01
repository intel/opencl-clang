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
