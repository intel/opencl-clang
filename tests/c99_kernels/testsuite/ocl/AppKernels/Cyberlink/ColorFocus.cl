
// 2D version
__kernel void ColorFocus_Global(__global const uchar4* src, __global uchar4* dst, int width, int height,
int nFocusCenterX, int nFocusCenterY, int sqrFocusWidth, int sqrFocusHeight, unsigned char depth, unsigned char getAlphaType)
{
	//int index = get_global_id(0);

	//int y = index / width;
	//int x = index % width;
	int x = get_global_id(0);
	int y = get_global_id(1);
	int index = y*width+x;


	int newX, newY, sat;
	float t;
	unsigned int grayvalue;
	unsigned char Temp;

	newY = y - nFocusCenterY;
	newX = x - nFocusCenterX;
	t = (newX * newX)/(float)sqrFocusWidth + (newY * newY)/(float)sqrFocusHeight;

	if (t > depth)
	{
		grayvalue = (( 1053 * src[index].z + 2064 * src[index].y  + 401 * src[index].x +67584 ) >> 12);
		Temp = (unsigned char)grayvalue;

		dst[index].x = Temp;
		dst[index].y = Temp;
		dst[index].z = Temp;
	}
	else if (t >= 1)
	{
		sat = (int)( (1.0-(t-1)/(depth-1) ) * 4096.0);
		grayvalue = (( 1053 * src[index].z + 2064 * src[index].y  + 401 * src[index].x +67584 ) >> 12);
		Temp = (unsigned char)grayvalue;

		dst[index].z = Temp + ((sat * (int)(src[index].z - Temp)) >>12);
		dst[index].y = Temp + ((sat * (int)(src[index].y - Temp)) >>12);
		dst[index].x = Temp + ((sat * (int)(src[index].x - Temp)) >>12);
	}

	if(getAlphaType == 1)
		dst[index].w = src[index].w;
	else if(getAlphaType == 2)
		dst[index].w = 255;

}

#if 0
// 1D version
__kernel void ColorFocus_Global(__global const uchar4* src, __global uchar4* dst, int width, int height,
int nFocusCenterX, int nFocusCenterY, int sqrFocusWidth, int sqrFocusHeight, unsigned char depth, unsigned char getAlphaType)
{
	int index = get_global_id(0);

	int y = index / width;
	int x = index % width;

	int newX, newY, sat;
	float t;
	unsigned int grayvalue;
	unsigned char Temp;

	newY = y - nFocusCenterY;
	newX = x - nFocusCenterX;
	t = (newX * newX)/(float)sqrFocusWidth + (newY * newY)/(float)sqrFocusHeight;

	if (t > depth)
	{
		grayvalue = (( 1053 * src[index].z + 2064 * src[index].y  + 401 * src[index].x +67584 ) >> 12);
		Temp = (unsigned char)grayvalue;

		dst[index].x = Temp;
		dst[index].y = Temp;
		dst[index].z = Temp;
	}
	else if (t >= 1)
	{
		sat = (int)( (1.0-(t-1)/(depth-1) ) * 4096.0);
		grayvalue = (( 1053 * src[index].z + 2064 * src[index].y  + 401 * src[index].x +67584 ) >> 12);
		Temp = (unsigned char)grayvalue;

		dst[index].z = Temp + ((sat * (int)(src[index].z - Temp)) >>12);
		dst[index].y = Temp + ((sat * (int)(src[index].y - Temp)) >>12);
		dst[index].x = Temp + ((sat * (int)(src[index].x - Temp)) >>12);
	}

	if(getAlphaType == 1)
		dst[index].w = src[index].w;
	else if(getAlphaType == 2)
		dst[index].w = 255;

}
#endif


// buildOptions=
// RUN: %occ-cli %s --cl-options="-I%cwd -I%S " %cfg_path --cl-device=%cl_device 2>&1
