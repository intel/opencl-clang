// 2D version
__kernel void Focus_Global(__global const uchar4* src, __global uchar4* dst, int width, int height,
int nFocusCenterX, int nFocusCenterY, int sqrFocusWidth, int sqrFocusHeight, float adjustDepth, int bColor, unsigned char getAlphaType)
{
//	int index = get_global_id(0);
//	int y = index / width;
//	int x = index % width;

	int x = get_global_id(0);
	int y = get_global_id(1);
	int index = y*width+x;


	unsigned char R = bColor & 0x000000ff;
	unsigned char G = (bColor & 0x0000ff00) >> 8;
	unsigned char B = (bColor & 0x00ff0000) >> 16;

	int newX, newY;
	float sat, t;

	newY = y - nFocusCenterY;
	newX = x - nFocusCenterX;
	t = (float)(newX * newX)/(float)(sqrFocusWidth) + (float)(newY * newY)/(float)(sqrFocusHeight);

	if (t > adjustDepth)
	{
		dst[index].x = B;
 		dst[index].y = G;
 		dst[index].z = R;
	}
	else if (t >= 1)
	{
		sat = (t - 1) / (adjustDepth - 1);

		dst[index].x += sat * (B - src[index].x);
		dst[index].y += sat * (G - src[index].y);
		dst[index].z += sat * (R - src[index].z);
	}

	if(getAlphaType == 1)
		dst[index].w = src[index].w;
	else if(getAlphaType == 2)
		dst[index].w = 255;

}

#if 0
__kernel void Focus_Global(__global const uchar4* src, __global uchar4* dst, int width, int height,
int nFocusCenterX, int nFocusCenterY, int sqrFocusWidth, int sqrFocusHeight, float adjustDepth, int bColor, unsigned char getAlphaType)
{
	int index = get_global_id(0);

	int y = index / width;
	int x = index % width;

	unsigned char R = bColor & 0x000000ff;
	unsigned char G = (bColor & 0x0000ff00) >> 8;
	unsigned char B = (bColor & 0x00ff0000) >> 16;

	int newX, newY;
	float sat, t;

	newY = y - nFocusCenterY;
	newX = x - nFocusCenterX;
	t = (float)(newX * newX)/(float)(sqrFocusWidth) + (float)(newY * newY)/(float)(sqrFocusHeight);

	if (t > adjustDepth)
	{
		dst[index].x = B;
 		dst[index].y = G;
 		dst[index].z = R;
	}
	else if (t >= 1)
	{
		sat = (t - 1) / (adjustDepth - 1);

		dst[index].x += sat * (B - src[index].x);
		dst[index].y += sat * (G - src[index].y);
		dst[index].z += sat * (R - src[index].z);
	}

	if(getAlphaType == 1)
		dst[index].w = src[index].w;
	else if(getAlphaType == 2)
		dst[index].w = 255;

}
#endif


// buildOptions=
// RUN: %occ-cli %s --cl-options="-I%cwd -I%S " %cfg_path --cl-device=%cl_device 2>&1
