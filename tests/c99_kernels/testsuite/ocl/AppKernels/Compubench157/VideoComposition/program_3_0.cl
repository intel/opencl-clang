__kernel void maskKernel(
	read_only image2d_t img,
	read_only image2d_t imgMask,
	write_only image2d_t imgOut)
{
	//const sampler_t smp = CLK_ADDRESS_CLAMP;

	const sampler_t smp = CLK_NORMALIZED_COORDS_FALSE | CLK_FILTER_NEAREST | CLK_ADDRESS_CLAMP;
	int x = get_global_id(0);
	int y = get_global_id(1);

	uint4 c = read_imageui(img, smp, (int2)(x, y));
	float4 val = convert_float4(read_imageui(imgMask, smp, (int2)(x, y))) / 255.0f;

	write_imageui(imgOut, (int2)(x, y), (uint4)(
		(uint)(c.x * val.x),
		(uint)(c.y * val.y),
		(uint)(c.z * val.z),
		(uint)(c.w * val.w)));


	//write_imageui(imgOut, (int2)(x, y), (uint4)(200, 30, 50, 255));
}


// buildOptions=-cl-fast-relaxed-math
// RUN: %occ-cli %s --cl-options="-I%cwd -I%S -cl-fast-relaxed-math" %cfg_path --cl-device=%cl_device 2>&1
