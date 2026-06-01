
__kernel void Focus_Global(__global const uchar4* src, __global uchar4* dst, int width, int height,
int nFocusCenterX, int nFocusCenterY, int sqrFocusWidth, int sqrFocusHeight, float adjustDepth, int bColor, unsigned char getAlphaType)
{
	int x = get_global_id(0);
	int y = get_global_id(1);
	int index = y * width + x;

	uchar4 tempSrc = src[index];
	uchar4 tempDst = tempSrc;

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
		tempDst.x = B;
 		tempDst.y = G;
 		tempDst.z = R;
	}
	else if (t >= 1)
	{
		sat = (t - 1) / (adjustDepth - 1);

		tempDst.x += sat * (B - tempSrc.x);
		tempDst.y += sat * (G - tempSrc.y);
		tempDst.z += sat * (R - tempSrc.z);
	}

	//tempDst.w = (getAlphaType == 1)? tempSrc.w : tempDst.w;
    tempDst.w = (getAlphaType == 2)? 255 : tempDst.w;

    dst[index] = tempDst;
}


// buildOptions=
// RUN: %occ-cli %s --cl-options="-I%cwd -I%S " %cfg_path --cl-device=%cl_device 2>&1
