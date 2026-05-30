__kernel void SobelFilterLuminance
(
	__global const uchar *restrict image,
	__local uchar *pixels,
	__global uchar *result
)
{
	const int width = get_global_size(0);
	const int lWidth = get_local_size(0);
	const int lWidthSucc2 = lWidth+2;
	const int height = get_global_size(1);
	const int lHeight = get_local_size(1);
	const int lHeightSucc2 = lHeight+2;

	const int widthPrec = width - 1;
	const int heightPrec = height - 1;

	const int pX = get_global_id(0);
	int lPX = get_local_id(0);

	const int pY = get_global_id(1);
	int lPY = get_local_id(1);

	const int lId = lPY*lWidth + lPX;

	{
		const int2 gBase = (int2)(pX, pY) - (int2)(lPX, lPY) - (int2)(1,1);
		const int lws = lWidthSucc2*lHeightSucc2;
		const int lw = lWidth*lHeight;
		for(int p = lId; p < lws; p += lw)
		{
			int2 actP = gBase + (int2)(p%(lWidthSucc2), p/(lWidthSucc2));
			actP = clamp(actP, (int2)(0), (int2)(widthPrec, heightPrec));
			pixels[p] = image[actP.y*width + actP.x];
		}
	}
	barrier(CLK_LOCAL_MEM_FENCE);

	lPX += 1;
	lPY += 1;
	int lPXPrec = lPX - 1;
	int lPXSucc = lPX + 1;

	int lPYPrec = lPY - 1;
	int lPYSucc = lPY + 1;
	int lPYPrec_lWidth = lPYPrec * (lWidthSucc2);
	int lPY_lWidth = lPY * (lWidth+2);
	int lPYSucc_lWidth = lPYSucc * (lWidthSucc2);

	const int G00 = pixels[lPYPrec_lWidth + lPXPrec];
	int G01x2 = pixels[lPYPrec_lWidth + lPX];
	const int G02 = pixels[lPYPrec_lWidth + lPXSucc];

	int G10x2 = pixels[lPY_lWidth + lPXPrec];
	int G12x2 = pixels[lPY_lWidth + lPXSucc];

	const int G20 = pixels[lPYSucc_lWidth + lPXPrec];
	int G21x2 = pixels[lPYSucc_lWidth + lPX];
	const int G22 = pixels[lPYSucc_lWidth + lPXSucc];

	G01x2 <<= 1;
	G10x2 <<= 1;
	G12x2 <<= 1;
	G21x2 <<= 1;

	const int Gx = (G02 + G12x2 + G22) - (G00 + G10x2 + G20);
	const int Gy = (G20 + G21x2 + G22) - (G00 + G01x2 + G02);

	result[pY*width + pX] = convert_uchar_sat_rte(sqrt(convert_float(Gx*Gx + Gy*Gy)));
}

__kernel void SobelFilterRGBA
(
	__global const uchar4 *restrict image,
	__local uchar4 *pixels,
	__global uchar *result
)
{
	const int width = get_global_size(0);
	const int lWidth = get_local_size(0);
	const int lWidthSucc2 = lWidth+2;
	const int height = get_global_size(1);
	const int lHeight = get_local_size(1);
	const int lHeightSucc2 = lHeight+2;

	const int widthPrec = width - 1;
	const int heightPrec = height - 1;

	const int pX = get_global_id(0);
	int lPX = get_local_id(0);

	const int pY = get_global_id(1);
	int lPY = get_local_id(1);

	const int lId = lPY*lWidth + lPX;
	{
		const int2 gBase = (int2)(pX, pY) - (int2)(lPX, lPY) - (int2)(1,1);
		const int lws = lWidthSucc2*lHeightSucc2;
		const int lw = lWidth*lHeight;
		for(int p = lId; p < lws; p += lw)
		{
			int2 actP = gBase + (int2)(p%(lWidthSucc2), p/(lWidthSucc2));
			actP = clamp(actP, (int2)(0), (int2)(widthPrec, heightPrec));
			pixels[p] = image[actP.y*width + actP.x];
		}
	}
	barrier(CLK_LOCAL_MEM_FENCE);

	lPX += 1;
	lPY += 1;
	int lPXPrec = lPX - 1;
	int lPXSucc = lPX + 1;

	int lPYPrec = lPY - 1;
	int lPYSucc = lPY + 1;
	int lPYPrec_lWidth = lPYPrec * (lWidthSucc2);
	int lPY_lWidth = lPY * (lWidthSucc2);
	int lPYSucc_lWidth = lPYSucc * (lWidthSucc2);

	const int3 G00 = convert_int3(pixels[lPYPrec_lWidth + lPXPrec].xyz);
	int3 G01x2 = convert_int3(pixels[lPYPrec_lWidth + lPX].xyz);
	const int3 G02 = convert_int3(pixels[lPYPrec_lWidth + lPXSucc].xyz);

	int3 G10x2 = convert_int3(pixels[lPY_lWidth + lPXPrec].xyz);
	int3 G12x2 = convert_int3(pixels[lPY_lWidth + lPXSucc].xyz);

	const int3 G20 = convert_int3(pixels[lPYSucc_lWidth + lPXPrec].xyz);
	int3 G21x2 = convert_int3(pixels[lPYSucc_lWidth + lPX].xyz);
	const int3 G22 = convert_int3(pixels[lPYSucc_lWidth + lPXSucc].xyz);

	G01x2 <<= 1;
	G10x2 <<= 1;
	G12x2 <<= 1;
	G21x2 <<= 1;

	const int3 Gx = (G02 + G12x2 + G22) - (G00 + G10x2 + G20);
	const int3 Gy = (G20 + G21x2 + G22) - (G00 + G01x2 + G02);

	const float3 G3f = convert_float3(Gx*Gx + Gy*Gy);
	result[pY*width + pX] = convert_uchar_sat_rte(sqrt(max(G3f.s0, max(G3f.s1, G3f.s2))));
}


// buildOptions=
// RUN: %occ-cli %s --cl-options="-I%cwd -I%S " %cfg_path --cl-device=%cl_device 2>&1
