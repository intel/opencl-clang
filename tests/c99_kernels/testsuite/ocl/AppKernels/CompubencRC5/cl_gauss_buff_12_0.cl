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
