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
