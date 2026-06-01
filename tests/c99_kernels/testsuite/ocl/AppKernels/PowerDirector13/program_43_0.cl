
__kernel void Threshold_ARGB_Global(__global const uchar4* src, __global uchar4* dst, int width, int height, int nLevel, int bColor, unsigned char getAlphaType)
{
	int index = get_global_id(0);

	uchar4 tempSrc = src[index];
	uchar4 tempDst;

	unsigned char R = bColor & 0x000000ff;
	unsigned char G = (bColor & 0x0000ff00) >> 8;
	unsigned char B = (bColor & 0x00ff0000) >> 16;

	if (nLevel < 1 || nLevel > 255)
		tempDst = tempSrc;
	else
	{
		if( (tempSrc.x+tempSrc.y+tempSrc.z) >= nLevel*3 )
			tempDst = tempSrc;
		else
		{
			tempDst.x = B;
			tempDst.y = G;
			tempDst.z = R;
		}
	}

	tempDst.w = (getAlphaType == 1)? tempSrc.w : tempDst.w;
    tempDst.w = (getAlphaType == 2)? 255 : tempDst.w;

	dst[index] = tempDst;
}

__kernel void Threshold_AYUV_Global(__global const uchar4* src, __global uchar4* dst, int width, int height, int nLevel, int bColor, unsigned char getAlphaType)
{
	int index = get_global_id(0);

	uchar4 tempSrc = src[index];
	uchar4 tempDst;

	unsigned char R = bColor & 0x000000ff;
	unsigned char G = (bColor & 0x0000ff00) >> 8;
	unsigned char B = (bColor & 0x00ff0000) >> 16;

	if (nLevel < 1 || nLevel > 255)
		tempDst = tempSrc;
	else
	{
		if( tempSrc.z >= nLevel )
			tempDst = tempSrc;
		else
		{
			tempDst.x = B;
			tempDst.y = G;
			tempDst.z = R;
		}
	}

	tempDst.w = (getAlphaType == 1)? tempSrc.w : tempDst.w;
    tempDst.w = (getAlphaType == 2)? 255 : tempDst.w;

	dst[index] = tempDst;
}

// buildOptions=
// RUN: %occ-cli %s --cl-options="-I%cwd -I%S " %cfg_path --cl-device=%cl_device 2>&1
