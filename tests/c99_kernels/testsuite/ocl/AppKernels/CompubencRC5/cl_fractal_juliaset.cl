__constant int MAXITER = 100;
__constant int PALETTENUM = 7;
__constant float colorPalette[7 * 4] =
{
	0.0f, 0.0f, 0.0f, 1.0f,		// black
	1.0f, 0.0f, 0.0f, 1.0f,		// red
	1.0f, 1.0f, 0.0f, 1.0f,		// yellow
	1.0f, 1.0f, 1.0f, 1.0f,		// white
	1.0f, 1.0f, 0.0f, 1.0f,		// yellow
	1.0f, 0.0f, 0.0f, 1.0f,		// red
	0.0f, 0.0f, 0.0f, 1.0f		// black
};

__kernel
void fractal
(
	__write_only image2d_t output,
	const float currIter,
	const float iterCount
)
{
	const uint idX = get_global_id(0);
	const uint idY = get_global_id(1);

	const float sizeX_inv = 1.0f / get_global_size(0);
	const float sizeY_inv = 1.0f / get_global_size(1);

	const float real0 = -0.63f;
	const float imag0 = -0.407f;

	const float real1 = -0.835f;
	const float imag1 = 0.2321f;

	const float x0 = real0 + currIter * ((real1 - real0) / (iterCount));
	const float y0 = imag0 + currIter * ((imag1 - imag0) / (iterCount));

	float4 fractalFloat4 = (float4)(0.0f, 0.0f, 0.0f, 0.0f);

	for (int j = 0; j < 2; ++j)
	{
		for (int i = 0; i < 2; ++i)
		{
			float xOffset = i / 2.0f;
			float yOffset = j / 2.0f;

			float x = ((idX + xOffset) * sizeX_inv) * 4.0f - 2.0f;
			float y = ((idY + yOffset) * sizeY_inv) * 4.0f - 2.0f;

			bool isInside = true;

			int iter;
			for (iter = 0; iter < MAXITER; ++iter)
			{
				float xtemp = x*x - y*y + x0;
				float ytemp = 2.0f*x*y + y0;

				if ((x*x + y*y) > 4.0f)
				{
					isInside = false;
					break;
				}

				x = xtemp;
				y = ytemp;
			}

			if (!isInside)
			{
				float colorSelectorF = (iter / 1.05f) / PALETTENUM;

				int colorSelectorIL = colorSelectorF;
				colorSelectorF -= colorSelectorIL;

				colorSelectorIL = min(colorSelectorIL, PALETTENUM - 1);
				int colorSelectorIU = min(colorSelectorIL + 1, PALETTENUM - 1);

				fractalFloat4 += (float4)(colorPalette[4 * colorSelectorIL + 0], colorPalette[4 * colorSelectorIL + 1], colorPalette[4 * colorSelectorIL + 2], colorPalette[4 * colorSelectorIL + 3]) * (1.0f - colorSelectorF) +
					(float4)(colorPalette[4 * colorSelectorIU + 0], colorPalette[4 * colorSelectorIU + 1], colorPalette[4 * colorSelectorIU + 2], colorPalette[4 * colorSelectorIU + 3]) * (colorSelectorF);
			}
		}
	}

	fractalFloat4 *= 0.25f;

	write_imagef(output, (int2)(idX, idY), fractalFloat4);
}


// buildOptions=-cl-fast-relaxed-math
// RUN: %occ-cli %s --cl-options="-I%cwd -I%S -cl-fast-relaxed-math" %cfg_path --cl-device=%cl_device 2>&1
