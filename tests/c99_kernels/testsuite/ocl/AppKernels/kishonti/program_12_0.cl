__kernel void HorizontalGaussFilter
(
	__read_only image2d_t input,
	__constant float *coefficients,
	__write_only image2d_t output
)
{
	const sampler_t sampler =
		CLK_NORMALIZED_COORDS_FALSE |
		CLK_ADDRESS_CLAMP_TO_EDGE |
		CLK_FILTER_NEAREST;

	const int pX = get_global_id(0);
	const int pY = get_global_id(1);

	float4 aggregate = read_imagef(input, sampler, (int2)(pX, pY)) * coefficients[samplingOffset];

	for(int o = 1; o <= samplingOffset; ++o)
	{
		aggregate = mad(read_imagef(input, sampler, (int2)(pX - o, pY)), (float4)(coefficients[samplingOffset - o]),
						mad(read_imagef(input, sampler, (int2)(pX + o, pY)), (float4)(coefficients[samplingOffset + o]),
						aggregate)
					); // quiet enough precision
	}

	write_imagef(output, (int2)(pX, pY), aggregate);
}

__kernel void VerticalGaussFilter
(
	__read_only image2d_t input,
	__constant float *coefficients,
	__write_only image2d_t output
)
{
	const sampler_t sampler =
		CLK_NORMALIZED_COORDS_FALSE |
		CLK_ADDRESS_CLAMP_TO_EDGE |
		CLK_FILTER_NEAREST;

	const int pX = get_global_id(0);
	const int pY = get_global_id(1);

	float4 aggregate = read_imagef(input, sampler, (int2)(pX, pY)) * coefficients[samplingOffset];

	for(int o = 1; o <= samplingOffset; ++o)
	{
		aggregate = mad(read_imagef(input, sampler, (int2)(pX, pY - o)), (float4)(coefficients[samplingOffset - o]),
						mad(read_imagef(input, sampler, (int2)(pX, pY + o)), (float4)(coefficients[samplingOffset + o]),
						aggregate)
					); // quiet enough precision
	}

	write_imagef(output, (int2)(pX, pY), aggregate);
}

/*
__kernel void GaussFilterRGBA
(
	__read_only image2d_t input,
	__constant float *coefficients,
	__global uchar4 *output
)
{
	const sampler_t sampler =
		CLK_NORMALIZED_COORDS_FALSE |
		CLK_ADDRESS_CLAMP_TO_EDGE |
		CLK_FILTER_NEAREST;

	const int pX = get_global_id(0);
	const int pY = get_global_id(1);

	float4 aggregate = (float4)(0.0f);

	for(int o = 0; o < samplingOffset; ++o)
	{
		aggregate
	}

	//#pragma unroll samplingLength
	for(int y = pY - samplingOffset, ey = 0; ey < samplingLength; ++y, ++ey)
	{
		const int ey_samplingLength = ey*samplingLength;

		//#pragma unroll samplingLength
		for(int x = pX - samplingOffset, ex = 0; ex < samplingLength; ++x, ++ex)
		{
			aggregate += read_imagef(input, sampler, (int2)(x, y)) * coefficients[ey_samplingLength + ex];
		}
	}
	uchar4 rgba = convert_uchar4(clamp(aggregate, 0.0f, 1.0f) * 255.0f + 0.5f);

	output[pY*get_global_size(0) + pX] = rgba;
}
*/


// buildOptions=-D samplingOffset=5
// RUN: %occ-cli %s --cl-options="-I%cwd -I%S -D samplingOffset=5" %cfg_path --cl-device=%cl_device 2>&1
