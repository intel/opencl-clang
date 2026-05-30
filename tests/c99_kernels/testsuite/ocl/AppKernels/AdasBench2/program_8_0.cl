
__kernel void scaling1( __read_only image2d_t input,
					   __write_only image2d_t output  )
{
	const sampler_t sampler =
		CLK_NORMALIZED_COORDS_FALSE |
		CLK_ADDRESS_CLAMP_TO_EDGE |
		CLK_FILTER_LINEAR;

	const int x = get_global_id(0);
	const int y = get_global_id(1);

	float4 out_val = read_imagef(input, sampler, (int2)( (x + 0.5f) * 2.0f, (y + 0.5f) * 2.0f) );
	write_imagef(output, (int2)(x, y), out_val);
}



// buildOptions=
// RUN: %occ-cli %s --cl-options="-I%cwd -I%S " %cfg_path --cl-device=%cl_device 2>&1
