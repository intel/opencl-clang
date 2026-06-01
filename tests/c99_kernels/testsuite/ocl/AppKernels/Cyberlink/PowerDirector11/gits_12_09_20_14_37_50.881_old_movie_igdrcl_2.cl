
__kernel void OldMovie_ChangeColor_Global(__global uchar4* src, __global uchar4* dst, int width, int height,
int crFilm, unsigned char byColorAlpha, unsigned char getAlphaType)
{
	int index = get_global_id(0);

	uchar4 tempSrc = src[index];
	uchar4 tempDst;

	unsigned char R = crFilm & 0x000000ff;
	unsigned char G = (crFilm & 0x0000ff00) >> 8;
	unsigned char B = (crFilm & 0x00ff0000) >> 16;

	if(byColorAlpha > 0)
	{
		int nIntensity = ( tempSrc.z * 1053 + tempSrc.y * 2064 + tempSrc.x * 401 + 67584 ) >> 12;
		tempDst.x = nIntensity + ( ( (B - nIntensity) * byColorAlpha) >> 8);
		tempDst.y = nIntensity + ( ( (G - nIntensity) * byColorAlpha) >> 8);
		tempDst.z = nIntensity + ( ( (R - nIntensity) * byColorAlpha) >> 8);
	}
	else
		tempDst = tempSrc;

	tempDst.w = (getAlphaType == 1)? tempSrc.w : tempDst.w;
    tempDst.w = (getAlphaType == 2)? 255 : tempDst.w;

	dst[index] = tempDst;
}

__kernel void OldMovie_AddScratches_Global(__global uchar4* src, __global uchar4* dst, int width, int height,
												int nTemp, int nOffset, unsigned char getAlphaType)
{
	int x = nTemp;					//get_global_id(0);
	int y = get_global_id(0);	//get_global_id(1);
	int index = y * width + x;

	//if( x == nTemp )
	{
		uchar4 tempSrc = src[index];
		uchar4 tempDst;

		tempDst.x =  ( (tempSrc.x + nOffset) > 255) ? 255 : (tempSrc.x + nOffset);
		tempDst.y =  ( (tempSrc.y + nOffset) > 255) ? 255 : (tempSrc.y + nOffset);
		tempDst.z =  ( (tempSrc.z + nOffset) > 255) ? 255 : (tempSrc.z + nOffset);

		dst[index] = tempDst;
	}
}

__kernel void OldMovie_AddGrain_Global(__global uchar4* src, __global uchar4* dst, int width, int height,
int nTemp, int nOffset, unsigned char getAlphaType)
{
	int index = get_global_id(0);

	uchar4 tempSrc = src[index];
	uchar4 tempDst;

	nTemp = (int)tempSrc.x + nOffset;
	nTemp = (nTemp > 255)? 255 : nTemp;
	nTemp = (nTemp < 0)? 0 : nTemp;
	tempDst.x = (unsigned char)nTemp;

	nTemp = (int)tempSrc.y + nOffset;
	nTemp = (nTemp > 255)? 255 : nTemp;
	nTemp = (nTemp < 0)? 0 : nTemp;
	tempDst.y = (unsigned char)nTemp;

	nTemp = (int)tempSrc.z + nOffset;
	nTemp = (nTemp > 255)? 255 : nTemp;
	nTemp = (nTemp < 0)? 0 : nTemp;
	tempDst.z = (unsigned char)nTemp;

	tempDst.w = (getAlphaType == 1)? tempSrc.w : tempDst.w;
	tempDst.w = (getAlphaType == 2)? 255 : tempDst.w;

	dst[index] = tempDst;
}

__kernel void OldMovie_AddFlicker_Global(__global uchar4* src, __global uchar4* dst, int width, int height,
int nTemp, unsigned char getAlphaType)
{
	int index = get_global_id(0);

	uchar4 tempSrc = src[index];
	uchar4 tempDst;

	tempDst.x = ( (tempSrc.x + nTemp) > 255) ? 255 : (tempSrc.x + nTemp);
	tempDst.y = ( (tempSrc.y + nTemp) > 255) ? 255 : (tempSrc.y + nTemp);
	tempDst.z = ( (tempSrc.z + nTemp) > 255) ? 255 : (tempSrc.z + nTemp);

	tempDst.w = (getAlphaType == 1)? tempSrc.w : tempDst.w;
	tempDst.w = (getAlphaType == 2)? 255 : tempDst.w;

	dst[index] = tempDst;
}

/*
__kernel void OldMovie_ChangeColor_Global(__global const uchar4* src, __global uchar4* dst, int width, int height,
int nHairNum, int crFilm, unsigned char byColorAlpha, int nScratchNum, unsigned char byGrainNum, int nJitterNum,
int crBack, int nFlickerNum, __global int* RandomTable, unsigned char getAlphaType)
*/


// buildOptions=
// RUN: %occ-cli %s --cl-options="-I%cwd -I%S " %cfg_path --cl-device=%cl_device 2>&1
