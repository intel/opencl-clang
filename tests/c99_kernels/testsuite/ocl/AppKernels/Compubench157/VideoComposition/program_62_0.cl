__kernel void targetMatching(read_only image2d_t imgIn, read_only image2d_t imgTarget, read_only image2d_t imgCurr, write_only image2d_t imgOut)
{
	const sampler_t smp = CLK_ADDRESS_CLAMP;
	int x = get_global_id(0);
	int y = get_global_id(1);

	uint4 inputColor = read_imageui(imgIn, smp, (int2)(x, y));
	uint4 targetColor = read_imageui(imgTarget, smp, (int2)(x, y));
	uint4 currColor = read_imageui(imgCurr, smp, (int2)(x, y));
	uint4 c = currColor;

	float inputDiff = fabs( ((targetColor.x-inputColor.x) / 255.0f) * ((targetColor.y-inputColor.y) / 255.0f) * ((targetColor.z-inputColor.z) / 255.0f) );
	float currDiff = fabs( ((targetColor.x-currColor.x) / 255.0f) * ((targetColor.y-currColor.y) / 255.0f) * ((targetColor.z-currColor.z) / 255.0f) );

	//if (!(inputDiff < currDiff && inputDiff < 0.5))
	//if (currDiff < 1 && inputDiff > currDiff)
	//if (currColor.x == targetColor.x && currColor.y == targetColor.y && currColor.z == targetColor.z)
	//if (currDiff < 0.1)
	//int threshold = 150;
	/*
	if (abs(targetColor.x-currColor.x) < threshold && abs(targetColor.y-currColor.y) < threshold && abs(targetColor.z-currColor.z) < threshold)
		return;*/
	if (abs(targetColor.x-inputColor.x) < abs(targetColor.x-currColor.x))
		c.x = inputColor.x;
	if (abs(targetColor.y-inputColor.y) < abs(targetColor.y-currColor.y))
		c.y = inputColor.y;
	if (abs(targetColor.z-inputColor.z) < abs(targetColor.z-currColor.z))
		c.z = inputColor.z;

	write_imageui(imgOut, (int2)(x, y), c);
}


/*
	float inputIntensity = inputColor.x/255.0 * inputColor.y/255.0 * inputColor.z/255.0;
	float targetIntensity = targetColor.x/255.0 * targetColor.y/255.0 * targetColor.z/255.0;
	float currIntensity = currColor.x/255.0 * currColor.y/255.0 * currColor.z/255.0;

	float inputDiff = fabs(targetIntensity - inputIntensity);
	float currDiff = fabs(currIntensity - inputIntensity);
	*/


// buildOptions=-cl-fast-relaxed-math
// RUN: %occ-cli %s --cl-options="-I%cwd -I%S -cl-fast-relaxed-math" %cfg_path --cl-device=%cl_device 2>&1
