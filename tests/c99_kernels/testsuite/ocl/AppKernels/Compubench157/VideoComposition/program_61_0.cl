#define USE_UCHAR4

__constant float filterWeights[ 109 ] =
{
0.000265832f,
0.000312602f,
0.000366489f,
0.000428365f,
0.000499174f,
0.000579929f,
0.000671709f,
0.000775661f,
0.000892992f,
0.00102496f,
0.00117288f,
0.00133808f,
0.00152193f,
0.0017258f,
0.00195107f,
0.00219907f,
0.0024711f,
0.00276837f,
0.00309204f,
0.00344309f,
0.0038224f,
0.00423067f,
0.00466838f,
0.0051358f,
0.00563292f,
0.00615948f,
0.00671488f,
0.00729823f,
0.00790826f,
0.00854336f,
0.00920155f,
0.00988047f,
0.0105774f,
0.0112892f,
0.0120125f,
0.0127435f,
0.013478f,
0.0142118f,
0.0149402f,
0.0156585f,
0.0163616f,
0.0170446f,
0.0177023f,
0.0183299f,
0.0189223f,
0.0194748f,
0.0199827f,
0.0204419f,
0.0208484f,
0.0211987f,
0.0214897f,
0.0217187f,
0.0218838f,
0.0219835f,
0.0220168f,
0.0219835f,
0.0218838f,
0.0217187f,
0.0214897f,
0.0211987f,
0.0208484f,
0.0204419f,
0.0199827f,
0.0194748f,
0.0189223f,
0.0183299f,
0.0177023f,
0.0170446f,
0.0163616f,
0.0156585f,
0.0149402f,
0.0142118f,
0.013478f,
0.0127435f,
0.0120125f,
0.0112892f,
0.0105774f,
0.00988047f,
0.00920155f,
0.00854336f,
0.00790826f,
0.00729823f,
0.00671488f,
0.00615947f,
0.00563292f,
0.00513579f,
0.00466838f,
0.00423067f,
0.0038224f,
0.00344309f,
0.00309203f,
0.00276837f,
0.0024711f,
0.00219907f,
0.00195107f,
0.0017258f,
0.00152193f,
0.00133808f,
0.00117288f,
0.00102496f,
0.000892992f,
0.000775661f,
0.000671709f,
0.000579928f,
0.000499174f,
0.000428365f,
0.000366489f,
0.000312602f,
0.000265832f
};

#ifdef USE_FLOAT4
	#define DATATYPE float4
	#define DATATYPEIMG float4
	#define READIMG read_imagef
	#define WRITEIMG write_imagef
	#define CONVERTU4(x) x
	#define CONVERTU4IMG(x) x
	#define CONVERTF4
#endif

#ifdef USE_UCHAR4
	#define DATATYPE uchar4
	#define DATATYPEIMG uint4
	#define WRITEIMG write_imageui
	#define READIMG read_imageui
	#define CONVERTU4(x) convert_uchar4(x+(float4)(0.5f))
	#define CONVERTU4IMG(x) convert_uint4(x+(float4)(0.5f))
	#define CONVERTF4 convert_float4
#endif

__kernel void gauss1DBuffer
(
	__global const DATATYPE* restrict input,
	__global DATATYPE* restrict output
)
{
	const int pX = get_global_id(0);
	const int pY = get_global_id(1);

	const int IMAGE_W = get_global_size(0);
	const int IMAGE_H = get_global_size(1);

	float4 out = CONVERTF4( input[pY * IMAGE_W + pX] ) * filterWeights[ FILTER_RAD ];

	for(int r = 0; r < FILTER_RAD; ++r)
	{
		const DATATYPE c0 = input[pY * IMAGE_W + max(pX + (r - FILTER_RAD),			0)];
		const DATATYPE c1 = input[pY * IMAGE_W + min(pX + (FILTER_RAD - r), IMAGE_W-1)];

#ifdef USE_UCHAR4
		out += CONVERTF4(c0) * filterWeights[ r ];
		out += CONVERTF4(c1) * filterWeights[ r ];
#else
		out += CONVERTF4(c0+c0) * filterWeights[ r ];
#endif
	}

	// out = in
	//output[pY * IMAGE_W + pX] = CONVERTU4(out);

	// out = transposed in
	output[pX * IMAGE_H + pY] = CONVERTU4(out);
}

__kernel void gauss1DImage
(
	__read_only image2d_t input,
	__write_only image2d_t output
)
{
	const sampler_t sampler =
		CLK_NORMALIZED_COORDS_FALSE |
		CLK_ADDRESS_CLAMP_TO_EDGE |
		CLK_FILTER_NEAREST;

	const int pX = get_global_id(0);
	const int pY = get_global_id(1);

	float4 out = CONVERTF4( READIMG(input, sampler, (int2)(pX,pY)) ) * filterWeights[ FILTER_RAD ];

	for(int r = 0; r < FILTER_RAD; ++r)
	{
		const DATATYPEIMG c0 = READIMG(input, sampler, (int2)(pX + (r - FILTER_RAD), pY));
		const DATATYPEIMG c1 = READIMG(input, sampler, (int2)(pX + (FILTER_RAD - r), pY));

		out += CONVERTF4(c0) * filterWeights[ r ];
		out += CONVERTF4(c1) * filterWeights[ r ];
	}

	// out = in
	//WRITEIMG(output, (int2)(pX, pY), CONVERTU4IMG(out));

	// out = transposed in
	WRITEIMG(output, (int2)(pY,pX), CONVERTU4IMG(out));
}


// buildOptions=-cl-fast-relaxed-math -D FILTER_RAD=54 -D FILTER_SIZE=109
// RUN: %occ-cli %s --cl-options="-I%cwd -I%S -cl-fast-relaxed-math -D FILTER_RAD=54 -D FILTER_SIZE=109" %cfg_path --cl-device=%cl_device 2>&1
