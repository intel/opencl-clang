// 2D iteration
__kernel void Sepia_Global(__global const uchar4* src, __global uchar4* dst, int width, int height,
unsigned char byColorAlpha, unsigned int crFilm, unsigned char getAlphaType)
{
	int i = get_global_id(0);
	int j = get_global_id(1);
	int index = j*width+i;

	uchar4 tempSrc = src[index];
	uchar4 tempDst;

	if(byColorAlpha > 0)
	{
		unsigned char R = ( crFilm & 0x000000ff );
		unsigned char G = ( crFilm & 0x0000ff00 ) >> 8;
		unsigned char B = ( crFilm & 0x00ff0000 ) >> 16;

		int nIntensity = ( tempSrc.z * 1053 + tempSrc.y * 2064 + tempSrc.x * 401 + 67584 ) >> 12;

		unsigned char r = (R + nIntensity) /2;
		unsigned char g = (G + nIntensity) /2;
		unsigned char b = (B + nIntensity) /2;

		tempDst.x = b;
		tempDst.y = g;
		tempDst.z = r;

		tempDst.x = tempSrc.x + ( ( (b - tempSrc.x) * byColorAlpha) >> 8);
		tempDst.y = tempSrc.y + ( ( (g - tempSrc.y) * byColorAlpha) >> 8);
		tempDst.z = tempSrc.z + ( ( (r - tempSrc.z) * byColorAlpha) >> 8);
	}
	else
	{
		tempDst.x = tempSrc.x;
		tempDst.y = tempSrc.y;
		tempDst.z = tempSrc.z;
	}

	if(getAlphaType == 1)
		tempDst.w = tempSrc.w;
	else if(getAlphaType == 2)
		tempDst.w = 255;

	dst[index] = tempDst;
}

#if 0
// 1D iteration
__kernel void Sepia_Global(__global const uchar4* src, __global uchar4* dst, int width, int height,
unsigned char byColorAlpha, unsigned int crFilm, unsigned char getAlphaType)
{
	int index = get_global_id(0);

	int j = index / width;
	int i = index % width;

	uchar4 tempSrc = src[index];
	uchar4 tempDst;

	if(byColorAlpha > 0)
	{
		unsigned char R = ( crFilm & 0x000000ff );
		unsigned char G = ( crFilm & 0x0000ff00 ) >> 8;
		unsigned char B = ( crFilm & 0x00ff0000 ) >> 16;

		int nIntensity = ( tempSrc.z * 1053 + tempSrc.y * 2064 + tempSrc.x * 401 + 67584 ) >> 12;

		unsigned char r = (R + nIntensity) /2;
		unsigned char g = (G + nIntensity) /2;
		unsigned char b = (B + nIntensity) /2;

		tempDst.x = b;
		tempDst.y = g;
		tempDst.z = r;

		tempDst.x = tempSrc.x + ( ( (b - tempSrc.x) * byColorAlpha) >> 8);
		tempDst.y = tempSrc.y + ( ( (g - tempSrc.y) * byColorAlpha) >> 8);
		tempDst.z = tempSrc.z + ( ( (r - tempSrc.z) * byColorAlpha) >> 8);
	}
	else
	{
		tempDst.x = tempSrc.x;
		tempDst.y = tempSrc.y;
		tempDst.z = tempSrc.z;
	}

	if(getAlphaType == 1)
		tempDst.w = tempSrc.w;
	else if(getAlphaType == 2)
		tempDst.w = 255;

	dst[index] = tempDst;
}
#endif


// buildOptions=
// RUN: %occ-cli %s --cl-options="-I%cwd -I%S " %cfg_path --cl-device=%cl_device 2>&1
