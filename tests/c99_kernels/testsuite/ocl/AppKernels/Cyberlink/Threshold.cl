// 2D iteration
__kernel void Threshold_Global(__global const uchar4* src, __global uchar4* dst, int width, int height, int nLevel, int bColor, unsigned char getAlphaType)
{
	int i = get_global_id(0);
	int j = get_global_id(1);
	int index = j*width+i;

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

	if(getAlphaType == 1)
		tempDst.w = tempSrc.w;
	else if(getAlphaType == 2)
		tempDst.w = 255;

	dst[index] = tempDst;

}//kernel end

#if 0
// 1D iteration
__kernel void Threshold_Global(__global const uchar4* src, __global uchar4* dst, int width, int height, int nLevel, int bColor, unsigned char getAlphaType)
{
	int index = get_global_id(0);

	int j = index / width;
	int i = index % width;

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

	if(getAlphaType == 1)
		tempDst.w = tempSrc.w;
	else if(getAlphaType == 2)
		tempDst.w = 255;

	dst[index] = tempDst;

}//kernel end
#endif


// buildOptions=
// RUN: %occ-cli %s --cl-options="-I%cwd -I%S " %cfg_path --cl-device=%cl_device 2>&1
