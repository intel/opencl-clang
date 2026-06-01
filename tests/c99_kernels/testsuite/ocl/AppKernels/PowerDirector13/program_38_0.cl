// Floating point version - probably slightly different values
__kernel void Sepia_Global(__global const uchar4* src, __global uchar4* dst, int width, int height,
unsigned char byColorAlpha, unsigned int crFilm, unsigned char getAlphaType)
{
	int index = get_global_id(0);

	uchar4 tempSrc = src[index];
	uchar4 tempDst;

	if(byColorAlpha > 0)
	{
		float4	ftempSrc = convert_float4( tempSrc );

		float	fColorAlpha = (float)byColorAlpha * (1.0f / 256.0f);

		float R = (float)( as_uchar4( crFilm ).x );
		float G = (float)( as_uchar4( crFilm ).y );
		float B = (float)( as_uchar4( crFilm ).z );

		//int nIntensity = ( tempSrc.z * 1053 + tempSrc.y * 2064 + tempSrc.x * 401 + 67584 ) >> 12;
		float nIntensity =  mad(ftempSrc.z, (1053.0f/4096.0f), mad( ftempSrc.y, (2064.0f/4096.0f), mad(ftempSrc.x, (401.0f/4096.0f), (67584.0f/4096.0f))) );// >> 12;

		float r = (R + nIntensity) * 0.5f;
		float g = (G + nIntensity) * 0.5f;
		float b = (B + nIntensity) * 0.5f;

		tempDst.x = convert_uchar_sat( ftempSrc.x + ( ( (b - ftempSrc.x) * fColorAlpha) ) );
		tempDst.y = convert_uchar_sat( ftempSrc.y + ( ( (g - ftempSrc.y) * fColorAlpha) ) );
		tempDst.z = convert_uchar_sat( ftempSrc.z + ( ( (r - ftempSrc.z) * fColorAlpha) ) );
	}
	else
	{
		tempDst.x = tempSrc.x;
		tempDst.y = tempSrc.y;
		tempDst.z = tempSrc.z;
	}

	tempDst.w = (getAlphaType == 1)? tempSrc.w : 255;
	dst[index] = tempDst;
}

//Original
/*
__kernel void Sepia_Global(__global const uchar4* src, __global uchar4* dst, int width, int height,
unsigned char byColorAlpha, unsigned int crFilm, unsigned char getAlphaType)
{
	int index = get_global_id(0);

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

	tempDst.w = (getAlphaType == 1)? tempSrc.w : tempDst.w;
    tempDst.w = (getAlphaType == 2)? 255 : tempDst.w;

	dst[index] = tempDst;
}
*/

__kernel void Sepia_YUV_Global(__global const uchar4* src, __global uchar4* dst, int width, int height,
unsigned char byColorAlpha, unsigned int crFilm, unsigned char getAlphaType)
{
	int index = get_global_id(0);

	uchar4 tempSrc = src[index];
	uchar4 tempDst;

	if(byColorAlpha > 0)
	{
		unsigned char R = ( crFilm & 0x000000ff );
		unsigned char G = ( crFilm & 0x0000ff00 ) >> 8;
		unsigned char B = ( crFilm & 0x00ff0000 ) >> 16;

		int nIntensity = (int)tempSrc.z;

		int r = ((int)R + nIntensity) / 2;
		int g = ((int)G + nIntensity) / 2;
		int b = ((int)B + nIntensity) / 2;

		int Y  = ( 1053 * r + 2064 * g +  401 * b +  67584 ) >> 12;		// 65536 -> 16 x 2^12
		int Cb = ( -606 * r - 1192 * g + 1798 * b + 526336 ) >> 12;		// 524288 -> 128 x2^12
		int Cr = ( 1798 * r - 1507 * g -  291 * b + 526336 ) >> 12;

		tempDst.x = ((int)tempSrc.x * (256 - (int)byColorAlpha) + (int)byColorAlpha * Cr) >> 8;
		tempDst.y = ((int)tempSrc.y * (256 - (int)byColorAlpha) + (int)byColorAlpha * Cb) >> 8;
		tempDst.z = ((int)tempSrc.z * (256 - (int)byColorAlpha) + (int)byColorAlpha * Y) >> 8;

	}
	else
	{
		tempDst.x = tempSrc.x;
		tempDst.y = tempSrc.y;
		tempDst.z = tempSrc.z;
	}

	tempDst.w = (getAlphaType == 1)? tempSrc.w : tempDst.w;
    tempDst.w = (getAlphaType == 2)? 255 : tempDst.w;

	dst[index] = tempDst;
}

// buildOptions=
// RUN: %occ-cli %s --cl-options="-I%cwd -I%S " %cfg_path --cl-device=%cl_device 2>&1
