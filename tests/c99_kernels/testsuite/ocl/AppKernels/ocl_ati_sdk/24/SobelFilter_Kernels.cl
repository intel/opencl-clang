/*
 * For a description of the algorithm and the terms used, please see the
 * documentation for this sample.
 *
 * Each thread calculates a pixel component(rgba), by applying a filter
 * on group of 8 neighbouring pixels in both x and y directions.
 * Both filters are summed (vector sum) to form the final result.
 */


__kernel void sobel_filter(__global uchar4* inputImage, __global uchar4* outputImage)
{
	uint x = get_global_id(0);
    uint y = get_global_id(1);

	uint width = get_global_size(0);
	uint height = get_global_size(1);

	float4 Gx = (float4)(0);
	float4 Gy = Gx;

	int c = x + y * width;


	/* Read each texel component and calculate the filtered value using neighbouring texel components */
	if( x >= 1 && x < (width-1) && y >= 1 && y < height - 1)
	{
		float4 i00 = convert_float4(inputImage[c - 1 - width]);
		float4 i10 = convert_float4(inputImage[c - width]);
		float4 i20 = convert_float4(inputImage[c + 1 - width]);
		float4 i01 = convert_float4(inputImage[c - 1]);
		float4 i11 = convert_float4(inputImage[c]);
		float4 i21 = convert_float4(inputImage[c + 1]);
		float4 i02 = convert_float4(inputImage[c - 1 + width]);
		float4 i12 = convert_float4(inputImage[c + width]);
		float4 i22 = convert_float4(inputImage[c + 1 + width]);

		Gx =   i00 + (float4)(2) * i10 + i20 - i02  - (float4)(2) * i12 - i22;

		Gy =   i00 - i20  + (float4)(2)*i01 - (float4)(2)*i21 + i02  -  i22;

		/* taking root of sums of squares of Gx and Gy */
		outputImage[c] = convert_uchar4(hypot(Gx, Gy)/(float4)(2));

	}

}

























// buildOptions=
// RUN: %occ-cli %s --cl-options="-I%cwd -I%S " %cfg_path --cl-device=%cl_device 2>&1
