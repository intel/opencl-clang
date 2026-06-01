
__kernel void image_convolution( __read_only image2d_t input,
								 __write_only image2d_t output,
								 __constant float *ckernel,
								 const int kernel_size )
{
	const sampler_t sampler = CLK_NORMALIZED_COORDS_FALSE |
							  CLK_ADDRESS_CLAMP_TO_EDGE |
							  CLK_FILTER_NEAREST;

	const int x = get_global_id(0);
	const int y = get_global_id(1);

	const int half_size = (kernel_size - 1) / 2;

	const int start_y	= y - half_size;
	const int end_y		= y + half_size;
	const int start_x	= x - half_size;
	const int end_x		= x + half_size;

	float4 sum = (float4)(0.0f);
	int counter = 0;
	float kernel_sum = 0.0f;
	for (int yi = start_y; yi<=end_y; ++yi)
		for (int xi = start_x; xi<=end_x; ++xi)
		{
			const float4 p = read_imagef(input, sampler, (int2)(xi, yi));
			const float coefficient = ckernel[counter++];

			kernel_sum += coefficient;
			sum += p * coefficient;
		}

	write_imagef(output, (int2)(x, y), kernel_sum == 0.0f ? (float4)(0.0f) : sum / kernel_sum);
}



// buildOptions=
// RUN: %occ-cli %s --cl-options="-I%cwd -I%S " %cfg_path --cl-device=%cl_device 2>&1
