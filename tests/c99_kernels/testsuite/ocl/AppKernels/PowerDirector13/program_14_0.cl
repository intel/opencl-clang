
__kernel void ColorFocus_ARGB_Global(__global const uchar4* src, __global uchar4* dst, int width, int height,
int nFocusCenterX, int nFocusCenterY, int sqrFocusWidth, int sqrFocusHeight, unsigned char depth, unsigned char getAlphaType)
{
	int index = get_global_id(0);

	int y = index / width;
	int x = index - width * y;

	uchar4 tempSrc = src[index];
	uchar4 tempDst;

	int newX, newY, sat;
	float t;
	unsigned int grayvalue;
	unsigned char Temp;

	newY = y - nFocusCenterY;
	newX = x - nFocusCenterX;
	t = (newX * newX) / (float)sqrFocusWidth + (newY * newY) / (float)sqrFocusHeight;

	if (t > depth)
	{
		grayvalue = (( 1053 * tempSrc.z + 2064 * tempSrc.y  + 401 * tempSrc.x + 67584 ) >> 12);
		Temp = (unsigned char)grayvalue;

		tempDst.z = Temp;
		tempDst.y = Temp;
		tempDst.x = Temp;
	}
	else if (t >= 1)
	{
		sat = (int)( (1.0 - ( t - 1 ) / ( depth - 1 ) ) * 4096.0 );
		grayvalue = (( 1053 * tempSrc.z + 2064 * tempSrc.y  + 401 * tempSrc.x + 67584 ) >> 12);
		Temp = (unsigned char)grayvalue;

		tempDst.z = Temp + ((sat * (int)(tempSrc.z - Temp)) >> 12);
		tempDst.y = Temp + ((sat * (int)(tempSrc.y - Temp)) >> 12);
		tempDst.x = Temp + ((sat * (int)(tempSrc.x - Temp)) >> 12);
	}
	else
	{
		tempDst = tempSrc;
	}

	tempDst.w = (getAlphaType == 1)? tempSrc.w : tempDst.w;
    tempDst.w = (getAlphaType == 2)? 255 : tempDst.w;

	dst[index] = tempDst;
}

__kernel void ColorFocus_AYUV_Global(__global const uchar4* src, __global uchar4* dst, int width, int height,
int nFocusCenterX, int nFocusCenterY, int sqrFocusWidth, int sqrFocusHeight, unsigned char depth, unsigned char getAlphaType)
{
	int index = get_global_id(0);

	int y = index / width;
	int x = index - width * y;

	uchar4 tempSrc = src[index];
	uchar4 tempDst;

	int newX, newY, sat;
	float t;
	unsigned int grayvalue;
	unsigned char Temp;

	newY = y - nFocusCenterY;
	newX = x - nFocusCenterX;
	t = (newX * newX) / (float)sqrFocusWidth + (newY * newY) / (float)sqrFocusHeight;

	if (t > depth)
	{
		tempDst.x = 128;
		tempDst.y = 128;
		tempDst.z = tempSrc.z;
	}
	else if (t >= 1)
	{
		sat = (int)( (1.0 - ( t - 1 ) / ( depth - 1) ) * 4096.0 );

		tempDst.x = 128 + (( sat * (int)( tempSrc.x - 128 )) >> 12 );
		tempDst.y = 128 + (( sat * (int)( tempSrc.y - 128 )) >> 12 );
		tempDst.z = tempSrc.z;
	}
	else
	{
		tempDst = tempSrc;
	}

	tempDst.w = (getAlphaType == 1)? tempSrc.w : tempDst.w;
    tempDst.w = (getAlphaType == 2)? 255 : tempDst.w;

	dst[index] = tempDst;
}


// buildOptions=
// RUN: %occ-cli %s --cl-options="-I%cwd -I%S " %cfg_path --cl-device=%cl_device 2>&1
