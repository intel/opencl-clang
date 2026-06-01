
#define M_PI		    3.1415926535897932384626433832795f

__kernel void Kaleidoscope_Global(__global const uchar4* src, __global uchar4* dst, int width, int height, float angle2, int segmentNum, int xOffset, int yOffset, unsigned char getAlphaType)
{
	int index = get_global_id(0);

	int h = index / width;
	int w = index % width;

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

	int nIndex;
	uchar4 Src_L, Src_R;

	int4 tempRGB1;
	int4 tempRGB2;

	nIndex = (nYMapped >> 16) * width + (nXMapped >> 16);

	Src_L = src[nIndex];

	if(((nXMapped >> 16) + 1) != width)
	{
		Src_R = src[nIndex + 1];
	}
	else
	{
		Src_R = Src_L;
	}

	tempRGB1.x = ((Src_L.x << 16) + ( Src_R.x - Src_L.x ) * fraction_x) >> 16;
	tempRGB1.y = ((Src_L.y << 16) + ( Src_R.y - Src_L.y ) * fraction_x) >> 16;
	tempRGB1.z = ((Src_L.z << 16) + ( Src_R.z - Src_L.z ) * fraction_x) >> 16;


	if(((nXMapped >> 16) + 1) != width)
	{
		if(((nYMapped >> 16) + 1) != height)
		{
			Src_L = src[nIndex + width];
			Src_R = src[nIndex + width + 1];
		}
		else
		{
			Src_L = src[nIndex];
			Src_R = src[nIndex + 1];
		}
	}
	else
	{
		if(((nYMapped >> 16) + 1) != height)
		{
			Src_L = src[nIndex + width];
			Src_R = src[nIndex + width];
		}
		else
		{
			Src_L = src[nIndex];
			Src_R = src[nIndex];
		}
	}

	tempRGB2.x = ((Src_L.x << 16) + ( Src_R.x - Src_L.x ) * fraction_x) >> 16;
	tempRGB2.y = ((Src_L.y << 16) + ( Src_R.y - Src_L.y ) * fraction_x) >> 16;
	tempRGB2.z = ((Src_L.z << 16) + ( Src_R.z - Src_L.z ) * fraction_x) >> 16;

	tempRGB1.x = ((tempRGB1.x << 16) + (tempRGB2.x - tempRGB1.x) * fraction_y) >> 16;
	tempRGB1.y = ((tempRGB1.y << 16) + (tempRGB2.y - tempRGB1.y) * fraction_y) >> 16;
	tempRGB1.z = ((tempRGB1.z << 16) + (tempRGB2.z - tempRGB1.z) * fraction_y) >> 16;

	if(getAlphaType == 1)
		tempRGB1.w = src[index].w;
	else if(getAlphaType == 2)
		tempRGB1.w = 255;

	dst[index] = convert_uchar4(tempRGB1);

}


// buildOptions=
// RUN: %occ-cli %s --cl-options="-I%cwd -I%S " %cfg_path --cl-device=%cl_device 2>&1
