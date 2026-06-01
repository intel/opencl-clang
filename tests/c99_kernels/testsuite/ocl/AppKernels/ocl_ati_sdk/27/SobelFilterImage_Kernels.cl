/*
 * For a description of the algorithm and the terms used, please see the
 * documentation for this sample.
 *
 * Each thread calculates a pixel component(rgba), by applying a filter
 * on group of 8 neighbouring pixels in both x and y directions.
 * Both filters are summed (vector sum) to form the final result.
 */

__constant sampler_t imageSampler = CLK_NORMALIZED_COORDS_FALSE | CLK_ADDRESS_CLAMP | CLK_FILTER_LINEAR;

__kernel void sobel_filter(__read_only image2d_t inputImage, __write_only image2d_t outputImage)
{
	int2 coord = (int2)(get_global_id(0), get_global_id(1));

	float4 Gx = (float4)(0);
	float4 Gy = Gx;

	//if( coord.x >= 1 && coord.x < (get_global_size(0)-1) && coord.y >= 1 && coord.y < get_global_size(1) - 1)
	//{

		float4 i00 = convert_float4(read_imageui(inputImage, imageSampler, (int2)(coord.x - 1, coord.y + 1)));
		float4 i10 = convert_float4(read_imageui(inputImage, imageSampler, (int2)(coord.x - 0, coord.y + 1)));
		float4 i20 = convert_float4(read_imageui(inputImage, imageSampler, (int2)(coord.x + 1, coord.y + 1)));
		float4 i01 = convert_float4(read_imageui(inputImage, imageSampler, (int2)(coord.x - 1, coord.y + 0)));
		float4 i11 = convert_float4(read_imageui(inputImage, imageSampler, (int2)(coord.x - 0, coord.y + 0)));
		float4 i21 = convert_float4(read_imageui(inputImage, imageSampler, (int2)(coord.x + 1, coord.y + 0)));
		float4 i02 = convert_float4(read_imageui(inputImage, imageSampler, (int2)(coord.x - 1, coord.y - 1)));
		float4 i12 = convert_float4(read_imageui(inputImage, imageSampler, (int2)(coord.x - 0, coord.y - 1)));
		float4 i22 = convert_float4(read_imageui(inputImage, imageSampler, (int2)(coord.x + 1, coord.y - 1)));

		Gx =   i00 + (float4)(2) * i10 + i20 - i02  - (float4)(2) * i12 - i22;

		Gy =   i00 - i20  + (float4)(2)*i01 - (float4)(2)*i21 + i02  -  i22;

		Gx = native_divide(native_sqrt(Gx * Gx + Gy * Gy), (float4)(2));

		write_imageui(outputImage, coord, convert_uint4(Gx));
	//}


}

























// buildOptions=
// RUN: %occ-cli %s --cl-options="-I%cwd -I%S " %cfg_path --cl-device=%cl_device 2>&1
