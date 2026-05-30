#define M_PI		    3.1415926535897932384626433832795f

__constant sampler_t imageSampler = CLK_NORMALIZED_COORDS_FALSE | CLK_ADDRESS_CLAMP | CLK_FILTER_NEAREST;


__kernel void Kaleidoscope_Global(__read_only image2d_t input, __write_only image2d_t output, int width, int height, float angle2, int segmentNum, int xOffset, int yOffset, unsigned char getAlphaType)
{
	int2 coord = (int2)(get_global_id(0), get_global_id(1));

	int h = get_global_id(1);
	int w = get_global_id(0);

	int nIndex = h * width + w;

	float arcWidth = M_PI / (float)segmentNum;

	int dx = w - width / 2;
	int dy = h - height / 2;

	float fXMapped;
	float fYMapped;

	int nXMapped;
	int nYMapped;

	if (dx == 0 && dy == 0)
	{
		fXMapped = (float)xOffset;
		fYMapped = (float)yOffset;
	}
	else
	{
		float r =  sqrt((float)(dx*dx+dy*dy));

		float ang = atan2((float)dy,(float)dx) - angle2;

		while (ang <= 0.0f)	// fixed one blank line bug (starting from image center to image right)
			ang = ang + 2 * (float)M_PI;

		float mult = ceil(ang / arcWidth) - 1;

		if (((int)mult) % 2 == 1)
		{
			ang = (1 + mult) * arcWidth - ang;
		}
		else
		{
			ang = ang - mult * arcWidth;
		}

		fXMapped = r * cos(ang) + xOffset;
		fYMapped = r * sin(ang) + yOffset;

	}

	nXMapped = (int)(fXMapped * 65536);
	nYMapped = (int)(fYMapped * 65536);

	// do wrap
	while (nXMapped < 0)  { nXMapped += (width << 16); }
	while (nXMapped >= (width << 16)) { nXMapped -= (width << 16); }
	while (nYMapped < 0)  { nYMapped += (height << 16); }
	while (nYMapped >= (height << 16)) { nYMapped -= (height << 16); }


	int fraction_x = nXMapped & 0x0000ffff;
	int fraction_y = nYMapped & 0x0000ffff;

	uint4 Src_L, Src_R;

	int4 tempRGB1;
	int4 tempRGB2;

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

	tempRGB1.x = ((tempRGB1.x << 16) + (tempRGB2.x - tempRGB1.x) * fraction_y) >> 16;
	tempRGB1.y = ((tempRGB1.y << 16) + (tempRGB2.y - tempRGB1.y) * fraction_y) >> 16;
	tempRGB1.z = ((tempRGB1.z << 16) + (tempRGB2.z - tempRGB1.z) * fraction_y) >> 16;

	Src_L = convert_uint4(tempRGB1);



	if(getAlphaType == 1)
	{
		coord = (int2)(get_global_id(0), get_global_id(1));
		Src_R = read_imageui(input, imageSampler, coord);
		Src_L.w = Src_R.w;
	}
	else if(getAlphaType == 2)
	{
		Src_L.w = 255;
	}

	coord = (int2)(get_global_id(0), get_global_id(1));
	write_imageui(output, coord, Src_L);

}

// buildOptions=
// RUN: %occ-cli %s --cl-options="-I%cwd -I%S " %cfg_path --cl-device=%cl_device 2>&1
