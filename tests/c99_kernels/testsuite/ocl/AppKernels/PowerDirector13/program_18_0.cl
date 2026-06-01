#define M_PI		    3.1415926535897932384626433832795f

__constant sampler_t imageSampler = CLK_NORMALIZED_COORDS_FALSE | CLK_ADDRESS_CLAMP | CLK_FILTER_NEAREST;


__kernel void Drain_NoInverse(__read_only image2d_t input, __write_only image2d_t output, int width, int height, float curvature, float dMaxRSqaure, float dMaxR_fCurvatureR2, int CenterX, int CenterY, unsigned char getAlphaType)
{
	// convert to polar

	int2 coord = (int2)(get_global_id(0), get_global_id(1));

	int nIndex;
	uint4 Src_L, Src_R;
	int4 tempRGB1;
	int4 tempRGB2;

	int w = get_global_id(0);
	int h = get_global_id(1);

	float dR = (float)((w - CenterX) * (w - CenterX) + (h - CenterY) * (h - CenterY));

	int nXMapped;
	int nYMapped;
	float fAoffset;

	if (dR <= dMaxRSqaure )  // if we're inside R (i.e. inside the circle)
	{
		if(w == CenterX && h == CenterY)
		{
			nXMapped = CenterX * 65536;
			nYMapped = CenterY * 65536;
		}
		else
		{
			float atan_Y = (float)(h - CenterY);
			float atan_X = (float)(w - CenterX);
			float dA = atan2(atan_Y, atan_X);

			float sqrdR2 = sqrt(dR);

			if(curvature > 0.02f)
				fAoffset = dMaxR_fCurvatureR2 / sqrdR2 - curvature * 2.0f;
			else
				fAoffset = 0.0f;

			dA += fAoffset;

			// convert back to cartesian
			float oldX = sqrdR2 * cos(dA) + (float)CenterX;
			float oldY = sqrdR2 * sin(dA) + (float)CenterY;
			oldX = (oldX < 0)? 0 : ( (oldX >= width)? (width - 1) : oldX );
			oldY = (oldY < 0)? 0 : ( (oldY >= height)? (height - 1) : oldY );

			nXMapped = oldX * 65536;
			nYMapped = oldY * 65536;

		}


		int fraction_x = nXMapped & 0x0000ffff;
		int fraction_y = nYMapped & 0x0000ffff;

		nIndex = (nYMapped >> 16) * width + (nXMapped >> 16);

		coord = (int2)(nIndex % width, nIndex / width);
		Src_L = read_imageui(input, imageSampler, coord);

		if(((nXMapped >> 16) + 1) != width)
		{
			coord = (int2)((nIndex+1) % width, (nIndex+1) / width);
			Src_R = read_imageui(input, imageSampler, coord);
		}
		else
		{
			Src_R = Src_L;
		}

		tempRGB1.x = (((int)Src_L.x << 16) + ( (int)Src_R.x - (int)Src_L.x ) * fraction_x) >> 16;
		tempRGB1.y = (((int)Src_L.y << 16) + ( (int)Src_R.y - (int)Src_L.y ) * fraction_x) >> 16;
		tempRGB1.z = (((int)Src_L.z << 16) + ( (int)Src_R.z - (int)Src_L.z ) * fraction_x) >> 16;
		tempRGB1.w = (((int)Src_L.w << 16) + ( (int)Src_R.w - (int)Src_L.w ) * fraction_x) >> 16;

		if(((nXMapped >> 16) + 1) != width)
		{
			if(((nYMapped >> 16) + 1) != height)
			{
				coord = (int2)((nIndex+width) % width, (nIndex+width) / width);
				Src_L = read_imageui(input, imageSampler, coord);
				coord = (int2)((nIndex+width+1) % width, (nIndex+width+1) / width);
				Src_R = read_imageui(input, imageSampler, coord);

			}
			else
			{
				coord = (int2)((nIndex) % width, (nIndex) / width);
				Src_L = read_imageui(input, imageSampler, coord);
				coord = (int2)((nIndex+1) % width, (nIndex+1) / width);
				Src_R = read_imageui(input, imageSampler, coord);
			}
		}
		else
		{
			if(((nYMapped >> 16) + 1) != height)
			{
				coord = (int2)((nIndex+width) % width, (nIndex+width) / width);
				Src_L = read_imageui(input, imageSampler, coord);
				Src_R = Src_L;
			}
			else
			{
				coord = (int2)((nIndex) % width, (nIndex) / width);
				Src_L = read_imageui(input, imageSampler, coord);
				Src_R = Src_L;
			}
		}

		tempRGB2.x = (((int)Src_L.x << 16) + ( (int)Src_R.x - (int)Src_L.x ) * fraction_x) >> 16;
		tempRGB2.y = (((int)Src_L.y << 16) + ( (int)Src_R.y - (int)Src_L.y ) * fraction_x) >> 16;
		tempRGB2.z = (((int)Src_L.z << 16) + ( (int)Src_R.z - (int)Src_L.z ) * fraction_x) >> 16;
		tempRGB2.w = (((int)Src_L.w << 16) + ( (int)Src_R.w - (int)Src_L.w ) * fraction_x) >> 16;


		tempRGB1.x = ((tempRGB1.x << 16) + (tempRGB2.x - tempRGB1.x) * fraction_y) >> 16;
		tempRGB1.y = ((tempRGB1.y << 16) + (tempRGB2.y - tempRGB1.y) * fraction_y) >> 16;
		tempRGB1.z = ((tempRGB1.z << 16) + (tempRGB2.z - tempRGB1.z) * fraction_y) >> 16;
		tempRGB1.w = ((tempRGB1.w << 16) + (tempRGB2.w - tempRGB1.w) * fraction_y) >> 16;

		Src_L = convert_uint4(tempRGB1);
		coord = (int2)(get_global_id(0), get_global_id(1));
		write_imageui(output, coord, Src_L);
	}
	else
	{
		coord = (int2)(get_global_id(0), get_global_id(1));
		Src_L = read_imageui(input, imageSampler, coord);
		write_imageui(output, coord, Src_L);
	}

}

__kernel void Drain_Inverse(__read_only image2d_t input, __write_only image2d_t output, int width, int height, float curvature, float dMaxRSqaure, float dMaxR_fCurvatureR, int CenterX, int CenterY, unsigned char getAlphaType)
{
	// convert to polar

	int2 coord = (int2)(get_global_id(0), get_global_id(1));

	int nIndex;
	uint4 Src_L, Src_R;
	int4 tempRGB1;
	int4 tempRGB2;

	int w = get_global_id(0);
	int h = get_global_id(1);

	float dR = (float)((w - CenterX) * (w - CenterX) + (h - CenterY) * (h - CenterY));

	int nXMapped;
	int nYMapped;
	float fAoffset;

	if (dR <= dMaxRSqaure )  // if we're inside R (i.e. inside the circle)
	{
		if(w == CenterX && h == CenterY)
		{
			nXMapped = CenterX * 65536;
			nYMapped = CenterY * 65536;
		}
		else
		{
			float atan_Y = (float)(h - CenterY);
			float atan_X = (float)(w - CenterX);
			float dA = atan2(atan_Y, atan_X);

			float sqrdR2 = sqrt(dR);

			if(curvature > 0.02f)
				fAoffset = dMaxR_fCurvatureR / sqrdR2 - curvature;
			else
				fAoffset = 0.0f;

			dA -= fAoffset;

			// convert back to cartesian
			float oldX = sqrdR2 * cos(dA) + (float)CenterX;
			float oldY = sqrdR2 * sin(dA) + (float)CenterY;
			oldX = (oldX < 0)? 0 : ( (oldX >= width)? (width - 1) : oldX );
			oldY = (oldY < 0)? 0 : ( (oldY >= height)? (height - 1) : oldY );

			nXMapped = oldX * 65536;
			nYMapped = oldY * 65536;

		}


		int fraction_x = nXMapped & 0x0000ffff;
		int fraction_y = nYMapped & 0x0000ffff;

		nIndex = (nYMapped >> 16) * width + (nXMapped >> 16);

		coord = (int2)(nIndex % width, nIndex / width);
		Src_L = read_imageui(input, imageSampler, coord);

		if(((nXMapped >> 16) + 1) != width)
		{
			coord = (int2)((nIndex+1) % width, (nIndex+1) / width);
			Src_R = read_imageui(input, imageSampler, coord);
		}
		else
		{
			Src_R = Src_L;
		}

		tempRGB1.x = (((int)Src_L.x << 16) + ( (int)Src_R.x - (int)Src_L.x ) * fraction_x) >> 16;
		tempRGB1.y = (((int)Src_L.y << 16) + ( (int)Src_R.y - (int)Src_L.y ) * fraction_x) >> 16;
		tempRGB1.z = (((int)Src_L.z << 16) + ( (int)Src_R.z - (int)Src_L.z ) * fraction_x) >> 16;
		tempRGB1.w = (((int)Src_L.w << 16) + ( (int)Src_R.w - (int)Src_L.w ) * fraction_x) >> 16;

		if(((nXMapped >> 16) + 1) != width)
		{
			if(((nYMapped >> 16) + 1) != height)
			{
				coord = (int2)((nIndex+width) % width, (nIndex+width) / width);
				Src_L = read_imageui(input, imageSampler, coord);
				coord = (int2)((nIndex+width+1) % width, (nIndex+width+1) / width);
				Src_R = read_imageui(input, imageSampler, coord);

			}
			else
			{
				coord = (int2)((nIndex) % width, (nIndex) / width);
				Src_L = read_imageui(input, imageSampler, coord);
				coord = (int2)((nIndex+1) % width, (nIndex+1) / width);
				Src_R = read_imageui(input, imageSampler, coord);
			}
		}
		else
		{
			if(((nYMapped >> 16) + 1) != height)
			{
				coord = (int2)((nIndex+width) % width, (nIndex+width) / width);
				Src_L = read_imageui(input, imageSampler, coord);
				Src_R = Src_L;
			}
			else
			{
				coord = (int2)((nIndex) % width, (nIndex) / width);
				Src_L = read_imageui(input, imageSampler, coord);
				Src_R = Src_L;
			}
		}

		tempRGB2.x = (((int)Src_L.x << 16) + ( (int)Src_R.x - (int)Src_L.x ) * fraction_x) >> 16;
		tempRGB2.y = (((int)Src_L.y << 16) + ( (int)Src_R.y - (int)Src_L.y ) * fraction_x) >> 16;
		tempRGB2.z = (((int)Src_L.z << 16) + ( (int)Src_R.z - (int)Src_L.z ) * fraction_x) >> 16;
		tempRGB2.w = (((int)Src_L.w << 16) + ( (int)Src_R.w - (int)Src_L.w ) * fraction_x) >> 16;


		tempRGB1.x = ((tempRGB1.x << 16) + (tempRGB2.x - tempRGB1.x) * fraction_y) >> 16;
		tempRGB1.y = ((tempRGB1.y << 16) + (tempRGB2.y - tempRGB1.y) * fraction_y) >> 16;
		tempRGB1.z = ((tempRGB1.z << 16) + (tempRGB2.z - tempRGB1.z) * fraction_y) >> 16;
		tempRGB1.w = ((tempRGB1.w << 16) + (tempRGB2.w - tempRGB1.w) * fraction_y) >> 16;

		Src_L = convert_uint4(tempRGB1);
		coord = (int2)(get_global_id(0), get_global_id(1));
		write_imageui(output, coord, Src_L);
	}
	else
	{
		coord = (int2)(get_global_id(0), get_global_id(1));
		Src_L = read_imageui(input, imageSampler, coord);
		write_imageui(output, coord, Src_L);
	}

}

// buildOptions=
// RUN: %occ-cli %s --cl-options="-I%cwd -I%S " %cfg_path --cl-device=%cl_device 2>&1
