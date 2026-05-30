__kernel void SobelFilterLuminance
(
	__global const uchar *image,
	__global uchar *result
)
{
	const int width = get_global_size(0);
	const int height = get_global_size(1);

	const int widthPrec = width - 1;
	const int heightPrec = height - 1;

	int pX = get_global_id(0);
	int pXPrec = max(pX - 1, 0);
	int pXSucc = min(pX + 1, widthPrec);

	int pY_width = get_global_id(1);
	int pYPrec_width = max(pY_width - 1, 0);
	int pYSucc_width = min(pY_width + 1, heightPrec);

	pY_width *= width;
	pYPrec_width *= width;
	pYSucc_width *= width;

	const int G00 = image[pYPrec_width + pXPrec];
	int G01x2 = image[pYPrec_width + pX];
	const int G02 = image[pYPrec_width + pXSucc];

	int G10x2 = image[pY_width + pXPrec];
	int G12x2 = image[pY_width + pXSucc];

	const int G20 = image[pYSucc_width + pXPrec];
	int G21x2 = image[pYSucc_width + pX];
	const int G22 = image[pYSucc_width + pXSucc];

	G01x2 <<= 1;
	G10x2 <<= 1;
	G12x2 <<= 1;
	G21x2 <<= 1;

	const int Gx = (G02 + G12x2 + G22) - (G00 + G10x2 + G20);
	const int Gy = (G20 + G21x2 + G22) - (G00 + G01x2 + G02);

	result[pY_width + pX] = convert_uchar_sat_rte(sqrt(convert_float(Gx*Gx + Gy*Gy)));
}

__kernel void SobelFilterRGBA
(
	__global const uchar4 *image,
	__global uchar *result
)
{
	const int width = get_global_size(0);
	const int height = get_global_size(1);

	const int widthPrec = width - 1;
	const int heightPrec = height - 1;

	int pX = get_global_id(0);
	int pXPrec = max(pX - 1, 0);
	int pXSucc = min(pX + 1, widthPrec);

	int pY_width = get_global_id(1);
	int pYPrec_width = max(pY_width - 1, 0);
	int pYSucc_width = min(pY_width + 1, heightPrec);

	pY_width *= width;
	pYPrec_width *= width;
	pYSucc_width *= width;

	const int3 G00 = convert_int3(image[pYPrec_width + pXPrec].xyz);
	int3 G01x2 = convert_int3(image[pYPrec_width + pX].xyz);
	const int3 G02 = convert_int3(image[pYPrec_width + pXSucc].xyz);

	int3 G10x2 = convert_int3(image[pY_width + pXPrec].xyz);
	int3 G12x2 = convert_int3(image[pY_width + pXSucc].xyz);

	const int3 G20 = convert_int3(image[pYSucc_width + pXPrec].xyz);
	int3 G21x2 = convert_int3(image[pYSucc_width + pX].xyz);
	const int3 G22 = convert_int3(image[pYSucc_width + pXSucc].xyz);

	G01x2 <<= 1;
	G10x2 <<= 1;
	G12x2 <<= 1;
	G21x2 <<= 1;

	const int3 Gx = (G02 + G12x2 + G22) - (G00 + G10x2 + G20);
	const int3 Gy = (G20 + G21x2 + G22) - (G00 + G01x2 + G02);

	const float3 G3f = convert_float3(Gx*Gx + Gy*Gy);
	result[pY_width + pX] = convert_uchar_sat_rte(sqrt(max(G3f.s0, max(G3f.s1, G3f.s2))));
}


// buildOptions=
// RUN: %occ-cli %s --cl-options="-I%cwd -I%S " %cfg_path --cl-device=%cl_device 2>&1
