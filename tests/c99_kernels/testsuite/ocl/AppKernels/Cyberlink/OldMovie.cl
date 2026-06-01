// 2D iteration


__kernel void OldMovie_AddScratches_Global(__global uchar4* src, __global uchar4* dst, int width, int height,
int nTemp, int nOffset, unsigned char getAlphaType)
{
	int x = get_global_id(0);
	int y = get_global_id(1);
	int index = y*width+x;

	if( x == nTemp )
	{
		uchar4 tempSrc = src[index];
		uchar4 tempDst;

		tempDst.x = ( (tempSrc.x + nOffset) > 255) ? 255 : (tempSrc.x + nOffset);
		tempDst.y = ( (tempSrc.y + nOffset) > 255) ? 255 : (tempSrc.y + nOffset);
		tempDst.z = ( (tempSrc.z + nOffset) > 255) ? 255 : (tempSrc.z + nOffset);

		dst[index] = tempDst;
	}
}// kernel end



#if 0
__kernel void OldMovie_AddScratches_Global(__global uchar4* src, __global uchar4* dst, int width, int height,
int nTemp, int nOffset, unsigned char getAlphaType)
{
	int index = get_global_id(0);

	int y = index / width;
	int x = index % width;

	if( x == nTemp )
	{
		uchar4 tempSrc = src[index];
		uchar4 tempDst;

		tempDst.x = ( (tempSrc.x + nOffset) > 255) ? 255 : (tempSrc.x + nOffset);
		tempDst.y = ( (tempSrc.y + nOffset) > 255) ? 255 : (tempSrc.y + nOffset);
		tempDst.z = ( (tempSrc.z + nOffset) > 255) ? 255 : (tempSrc.z + nOffset);

		dst[index] = tempDst;
	}
}// kernel end
#endif

__kernel void OldMovie_ChangeColor_Global(__global uchar4* src, __global uchar4* dst, int width, int height,
int crFilm, unsigned char byColorAlpha, unsigned char getAlphaType)
{
	int index = get_global_id(0);

	//int y = index / width;
	//int x = index % width;

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

	dst[index] = tempDst;
}// kernel end

__kernel void OldMovie_AddGrain_Global(__global uchar4* src, __global uchar4* dst, int width, int height,
int nTemp, int nOffset, unsigned char getAlphaType)
{
	int index = get_global_id(0);

	//int y = index / width;
	//int x = index % width;

	uchar4 tempSrc = src[index];
	uchar4 tempDst;

	nTemp = (int)tempSrc.x + nOffset;
	if (nTemp > 255)
		nTemp = 255;
	else if (nTemp < 0)
		nTemp = 0;
	tempDst.x = (unsigned char)nTemp;

	nTemp = (int)tempSrc.y + nOffset;
	if (nTemp > 255)
		nTemp = 255;
	else if (nTemp < 0)
		nTemp = 0;
	tempDst.y = (unsigned char)nTemp;

	nTemp = (int)tempSrc.z + nOffset;
	if (nTemp > 255)
		nTemp = 255;
	else if (nTemp < 0)
		nTemp = 0;
	tempDst.z = (unsigned char)nTemp;

	dst[index] = tempDst;
}// kernel end


__kernel void OldMovie_AddFlicker_Global(__global uchar4* src, __global uchar4* dst, int width, int height,
int nTemp, unsigned char getAlphaType)
{
	int index = get_global_id(0);

// 	int j = index / width;
// 	int i = index % width;

	uchar4 tempSrc = src[index];
	uchar4 tempDst;

	tempDst.x = ( (tempSrc.x + nTemp) > 255) ? 255 : (tempSrc.x + nTemp);
	tempDst.y = ( (tempSrc.y + nTemp) > 255) ? 255 : (tempSrc.y + nTemp);
	tempDst.z = ( (tempSrc.z + nTemp) > 255) ? 255 : (tempSrc.z + nTemp);

	dst[index] = tempDst;
}// kernel end



/*
__kernel void OldMovie_ChangeColor_Global(__global const uchar4* src, __global uchar4* dst, int width, int height,
int nHairNum, int crFilm, unsigned char byColorAlpha, int nScratchNum, unsigned char byGrainNum, int nJitterNum,
int crBack, int nFlickerNum, __global int* RandomTable, unsigned char getAlphaType)
*/


// buildOptions=
// RUN: %occ-cli %s --cl-options="-I%cwd -I%S " %cfg_path --cl-device=%cl_device 2>&1
