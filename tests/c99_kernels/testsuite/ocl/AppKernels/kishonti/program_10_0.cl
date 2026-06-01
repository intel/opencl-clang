__kernel void SobelFilterLuminance
(
	__read_only image2d_t image,
	__write_only image2d_t result
)
{
	const sampler_t sampler =
		CLK_NORMALIZED_COORDS_FALSE |
		CLK_ADDRESS_CLAMP_TO_EDGE |
		CLK_FILTER_NEAREST;

	const int pX = get_global_id(0);
	const int pXPrec = pX - 1;
	const int pXSucc = pX + 1;
	const int pY = get_global_id(1);
	const int pYPrec = pY - 1;
	const int pYSucc = pY + 1;
	const unsigned int width = get_global_size(0);

	const float G00 = read_imagef(image, sampler, (int2)(pXPrec, pYPrec)).x;
	float G01x2 = read_imagef(image, sampler, (int2)(pX, pYPrec)).x;
	const float G02 = read_imagef(image, sampler, (int2)(pXSucc, pYPrec)).x;

	float G10x2 = read_imagef(image, sampler, (int2)(pXPrec, pY)).x;
	float G12x2 = read_imagef(image, sampler, (int2)(pXSucc, pY)).x;

	const float G20 = read_imagef(image, sampler, (int2)(pXPrec, pYSucc)).x;
	float G21x2 = read_imagef(image, sampler, (int2)(pX, pYSucc)).x;
	const float G22 = read_imagef(image, sampler, (int2)(pXSucc, pYSucc)).x;

	G01x2 *= 2.0f;
	G10x2 *= 2.0f;
	G12x2 *= 2.0f;
	G21x2 *= 2.0f;

	const float2 G = (float2)((G02 + G12x2 + G22) - (G00 + G10x2 + G20), (G20 + G21x2 + G22) - (G00 + G01x2 + G02));

	write_imagef(result, (int2)(pX, pY), (float4)(length(G)));
}

__kernel void SobelFilterRGBA
(
	__read_only image2d_t image,
	__write_only image2d_t result
)
{
	const sampler_t sampler =
		CLK_NORMALIZED_COORDS_FALSE |
		CLK_ADDRESS_CLAMP_TO_EDGE |
		CLK_FILTER_NEAREST;

	const int pX = get_global_id(0);
	const int pXPrec = pX - 1;
	const int pXSucc = pX + 1;
	const int pY = get_global_id(1);
	const int pYPrec = pY - 1;
	const int pYSucc = pY + 1;
	const unsigned int width = get_global_size(0);

	const float3 G00 = read_imagef(image, sampler, (int2)(pXPrec, pYPrec)).xyz;
	float3 G01x2 = read_imagef(image, sampler, (int2)(pX, pYPrec)).xyz;
	const float3 G02 = read_imagef(image, sampler, (int2)(pXSucc, pYPrec)).xyz;

	float3 G10x2 = read_imagef(image, sampler, (int2)(pXPrec, pY)).xyz;
	float3 G12x2 = read_imagef(image, sampler, (int2)(pXSucc, pY)).xyz;

	const float3 G20 = read_imagef(image, sampler, (int2)(pXPrec, pYSucc)).xyz;
	float3 G21x2 = read_imagef(image, sampler, (int2)(pX, pYSucc)).xyz;
	const float3 G22 = read_imagef(image, sampler, (int2)(pXSucc, pYSucc)).xyz;

	G01x2 *= 2.0f;
	G10x2 *= 2.0f;
	G12x2 *= 2.0f;
	G21x2 *= 2.0f;

	const float3 Gx = (G02 + G12x2 + G22) - (G00 + G10x2 + G20);
	const float3 Gy = (G20 + G21x2 + G22) - (G00 + G01x2 + G02);

	const float3 G = sqrt(Gx*Gx + Gy*Gy);

	write_imagef(result, (int2)(pX, pY), (float4)(max(G.x, max(G.y, G.z))));
}


// buildOptions=
// RUN: %occ-cli %s --cl-options="-I%cwd -I%S " %cfg_path --cl-device=%cl_device 2>&1
