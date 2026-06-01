
// RGB

__kernel void FilterColor_Kernel_RGB_Case1(__global const uchar4* src, __global uchar4* dst, int width, int height)
{
	int index = get_global_id(0);

	uchar4 tempSrc;
	uchar4 tempDst;

	tempSrc = src[index];

	int nCurrY = (1053 * (int)tempSrc.z + 2064 * (int)tempSrc.y +  401 * (int)tempSrc.x +  67584 ) >> 12;

	int nGray = (4768 * (nCurrY - 16) + 2048) >> 12;

	if(nGray > 255)
	{
		tempDst.x = 255;
		tempDst.y = 255;
		tempDst.z = 255;
		tempDst.w = tempSrc.w;
	}
	else if(nGray < 0)
	{
		tempDst.x = 0;
		tempDst.y = 0;
		tempDst.z = 0;
		tempDst.w = tempSrc.w;
	}
	else
	{
		tempDst.x = nGray;
		tempDst.y = nGray;
		tempDst.z = nGray;
		tempDst.w = tempSrc.w;
	}

	dst[index] = tempDst;

}

__kernel void FilterColor_Kernel_RGB_Case2(__global const uchar4* src, __global uchar4* dst, int width, int height, int tolerance, int arctan)
{
	int Threshold = 10;
	int index = get_global_id(0);

	uchar4 tempSrc;
	uchar4 tempDst;

	tempSrc = src[index];

	int Y  = ( 1053 * (int)tempSrc.z + 2064 * (int)tempSrc.y +  401 * (int)tempSrc.x +  67584 ) >> 12;		// 65536 -> 16 x 2^12
	int Cb = ( -606 * (int)tempSrc.z - 1192 * (int)tempSrc.y + 1798 * (int)tempSrc.x + 526336 ) >> 12;		// 524288 -> 128 x2^12
	int Cr = ( 1798 * (int)tempSrc.z - 1507 * (int)tempSrc.y -  291 * (int)tempSrc.x + 526336 ) >> 12;

	int ArctanCurr = (int)( atan2 ( (float)(Cb - 128), (float)(Cr - 128)) * 180.0 );
	int AngleDiff = abs ( ArctanCurr - arctan );

	if ( AngleDiff > 180 )
	{
		AngleDiff -= 180;
	}

	if ( AngleDiff > ( tolerance + Threshold ))
	{
		int Gray = (4768 * (Y - 16) + 2048) >> 12;

		if(Gray > 255)
		{
			tempDst.x = 255;
			tempDst.y = 255;
			tempDst.z = 255;
			tempDst.w = tempSrc.w;
		}
		else if(Gray < 0)
		{
			tempDst.x = 0;
			tempDst.y = 0;
			tempDst.z = 0;
			tempDst.w = tempSrc.w;
		}
		else
		{
			tempDst.x = Gray;
			tempDst.y = Gray;
			tempDst.z = Gray;
			tempDst.w = tempSrc.w;
		}
	}
	else if ( AngleDiff > tolerance )
	{
		Cb = 128 + ( Cb - 128 ) * ( Threshold - ( AngleDiff - tolerance )) / Threshold;
		Cr = 128 + ( Cr - 128 ) * ( Threshold - ( AngleDiff - tolerance )) / Threshold;

		int R = ( 4768 * (Y - 16) + 6537 * (Cr - 128) + 2048 ) >> 12;
		int G = ( 4768 * (Y - 16) - 1602 * (Cb - 128) - 3330 * (Cr - 128) + 2048 ) >> 12;
		int B = ( 4768 * (Y - 16) + 8266 * (Cb - 128) + 2048 ) >> 12;

		tempDst.x = max(min(B, 255), 0);
		tempDst.y = max(min(G, 255), 0);
		tempDst.z = max(min(R, 255), 0);
		tempDst.w = tempSrc.w;

	}
	else
	{
		tempDst = tempSrc;
	}

	dst[index] = tempDst;

}

__kernel void FilterColor_Kernel_YUV_Case1(__global const uchar4* src, __global uchar4* dst, int width, int height)
{
	int index = get_global_id(0);

	uchar4 tempSrc;
	uchar4 tempDst;

	tempSrc = src[index];

	tempDst.w = tempSrc.w;
	tempDst.z = tempSrc.z;
	tempDst.y = 128;
	tempDst.x = 128;

	dst[index] = tempDst;

}

__kernel void FilterColor_Kernel_YUV_Case2(__global const uchar4* src, __global uchar4* dst, int width, int height, int tolerance, int arctan)
{
	int Threshold = 10;
	int index = get_global_id(0);

	uchar4 tempSrc;
	uchar4 tempDst;

	tempSrc = src[index];

	int Y  = tempSrc.z;
	int Cb = tempSrc.y;
	int Cr = tempSrc.x;

	int ArctanCurr = (int)( atan2 ( (float)(Cb - 128), (float)(Cr - 128)) * 180.0 );
	int AngleDiff = abs ( ArctanCurr - arctan );

	if ( AngleDiff > 180 )
	{
		AngleDiff -= 180;
	}

	if ( AngleDiff > ( tolerance + Threshold ))
	{
		tempDst.x = 128;
		tempDst.y = 128;
		tempDst.z = tempSrc.z;
		tempDst.w = tempSrc.w;
	}
	else if ( AngleDiff > tolerance )
	{
		Cb = 128 + ( Cb - 128 ) * ( Threshold - ( AngleDiff - tolerance )) / Threshold;
		Cr = 128 + ( Cr - 128 ) * ( Threshold - ( AngleDiff - tolerance )) / Threshold;

		tempDst.x = Cr;
		tempDst.y = Cb;
		tempDst.z = tempSrc.z;
		tempDst.w = tempSrc.w;
	}
	else
	{
		tempDst = tempSrc;
	}

	dst[index] = tempDst;

}


// buildOptions=
// RUN: %occ-cli %s --cl-options="-I%cwd -I%S " %cfg_path --cl-device=%cl_device 2>&1
