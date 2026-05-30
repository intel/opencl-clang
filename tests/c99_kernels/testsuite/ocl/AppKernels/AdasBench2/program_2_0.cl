
__kernel void kv_image_scaling(
	__read_only image2d_t input,
	__write_only image2d_t output,
	const unsigned int rect_x,
	const unsigned int rect_y,
	const float scale_x,
	const float scale_y )
{
	const sampler_t sampler =
		CLK_NORMALIZED_COORDS_FALSE |
		CLK_ADDRESS_CLAMP_TO_EDGE |
		CLK_FILTER_LINEAR;

	const int x = get_global_id(0);
	const int y = get_global_id(1);

	float scale_squared = scale_x*scale_y;
	float pix_pos_add = 0.5f;	//+0.5f, +0.5f: To read ecsact pixel location. This is correct if zoom is close to 1.

	if (scale_squared < 0.7f*0.7f){
		pix_pos_add = 0.0f;
		//this averages 4 pixels by the linear interpolation circuits.
		//this is fine if zoom is close to 0.5...
	}

	const float2 readpos = (float2)((float)x / scale_x + rect_x + pix_pos_add, (float)y / scale_y + rect_y + pix_pos_add);
	const float4 p = read_imagef(input, sampler, readpos);
	write_imagef(output, (int2)(x, y), p);
}




// buildOptions=
// RUN: %occ-cli %s --cl-options="-I%cwd -I%S " %cfg_path --cl-device=%cl_device 2>&1
