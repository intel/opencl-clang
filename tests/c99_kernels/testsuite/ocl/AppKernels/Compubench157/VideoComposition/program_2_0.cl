__kernel void mixKernel(
	read_only image2d_t img1,
	read_only image2d_t img2,
	write_only image2d_t imgOut,
	const float ratio1)
{
	const sampler_t smp = CLK_ADDRESS_CLAMP;
	int x = get_global_id(0);
	int y = get_global_id(1);

	uint4 c1 = read_imageui(img1, smp, (int2)(x, y));
	uint4 c2 = read_imageui(img2, smp, (int2)(x, y));

	float ratio2 = 1.0f-ratio1;

	//write_imageui(imgOut, (int2)(x, y), c1*ratio1+c2*ratio2);
	write_imageui(imgOut, (int2)(x, y), (uint4)(
		(uint)c1.x*ratio1+c2.x*ratio2,
		(uint)c1.y*ratio1+c2.y*ratio2,
		(uint)c1.z*ratio1+c2.z*ratio2,
		(uint)c1.w*ratio1+c2.w*ratio2));
}


// buildOptions=-cl-fast-relaxed-math
// RUN: %occ-cli %s --cl-options="-I%cwd -I%S -cl-fast-relaxed-math" %cfg_path --cl-device=%cl_device 2>&1
