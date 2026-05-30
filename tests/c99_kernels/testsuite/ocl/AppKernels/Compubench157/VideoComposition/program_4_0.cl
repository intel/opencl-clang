__kernel void invertColor(read_only image2d_t imgIn, write_only image2d_t imgOut)
{
	const sampler_t smp = CLK_ADDRESS_CLAMP;
	int x = get_global_id(0);
	int y = get_global_id(1);

	uint4 c = read_imageui(imgIn, smp, (int2)(x, y));
	write_imageui(imgOut, (int2)(x, y), (uint4)(255-c.x, 255-c.y, 255-c.z, c.w));
}


// buildOptions=-cl-fast-relaxed-math
// RUN: %occ-cli %s --cl-options="-I%cwd -I%S -cl-fast-relaxed-math" %cfg_path --cl-device=%cl_device 2>&1
