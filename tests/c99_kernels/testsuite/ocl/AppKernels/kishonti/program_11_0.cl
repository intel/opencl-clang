__kernel void TranspositionalGaussFilter
(
	__global const uchar4 *restrict input,
	__constant float *coefficients,
	__global uchar4 *output
)
{
	const int pX = get_global_id(0);
	const int pY = get_global_id(1);
	const int widthPrec = get_global_size(0) - 1;
	const int pY_width = pY*get_global_size(0);

	float4 aggregate = convert_float4(input[pY_width + pX]) * coefficients[samplingOffset];

	for(int o = 1; o <= samplingOffset; ++o)
	{
		aggregate = mad(convert_float4(input[pY_width + max(pX - o, 0)]), (float4)(coefficients[samplingOffset - o]), //coalesced read
						mad(convert_float4(input[pY_width + min(pX + o, widthPrec)]), (float4)(coefficients[samplingOffset + o]), //coalesced read
						aggregate)
					); // quiet enough precision
	}

	output[pX*get_global_size(1) + pY] = convert_uchar4_sat_rte(aggregate); //uncoalesced transpositional write
}

__kernel void TranspositionalGaussFilterLuminance ( __global const uchar *input,
													__constant float *coefficients,
													__global uchar *output )
{
	const int pX = get_global_id(0);
	const int pY = get_global_id(1);
	const int widthPrec = get_global_size(0) - 1;
	const int pY_width = pY*get_global_size(0);

	float aggregate = convert_float(input[pY_width + pX]) * coefficients[samplingOffset];

	for(int o = 1; o <= samplingOffset; ++o)
	{
		aggregate = mad(convert_float(input[pY_width + max(pX - o, 0)]), coefficients[samplingOffset - o], //coalesced read
						mad(convert_float(input[pY_width + min(pX + o, widthPrec)]), coefficients[samplingOffset + o], //coalesced read
						aggregate)
					); // quiet enough precision
	}

	output[pX*get_global_size(1) + pY] = convert_uchar_sat_rte(aggregate); //uncoalesced transpositional write
}


// buildOptions=-D samplingOffset=5
// RUN: %occ-cli %s --cl-options="-I%cwd -I%S -D samplingOffset=5" %cfg_path --cl-device=%cl_device 2>&1
