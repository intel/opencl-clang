
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


__kernel void FilterColor_Kernel_RGB_Case2(__global const uint4 * src, __global uint4 * dst, int width, int height, int tolerance, float arctan)
{
	int index = get_global_id(0);

	uint4 tempSrc;
	uint4 tempDst;

	float4 Threshold = 10.0f;

	tempSrc = src[index];

	float4	blue  = convert_float4(   (tempSrc        & (uint4)0x0ff) );
	float4	green = convert_float4( ( (tempSrc >>  8) & (uint4)0x0ff) );
	float4	red   = convert_float4( ( (tempSrc >> 16) & (uint4)0x0ff) );
	uint4	alpha = tempSrc & (uint4)0xff000000;

	// floor is needed to minimize errors, round down to nearest integer
	float4	Y = floor((1053.0f / 4096.0f) * red + (2064.0f / 4096.0f) * green + (401.0f / 4096.0f) * blue + (67584.0f / 4096.0f  - 16.0f));
	float4	Cb = floor((-606.0f / 4096.0f) * red - (1192.0f / 4096.0f) * green + (1798.0f / 4096.0f) * blue + (526336.0f / 4096.0f - 128.0f));
	float4	Cr = floor((1798 / 4096.0f) * red - (1507.0f / 4096.0f) * green - (291.0f / 4096.0f) * blue + (526336.0f / 4096.0f - 128.0f));

	// rolled into calculation above...
	//Y -= 16.0f;
	//Cr -= 128.0f;		// avoid un-needed subtracts later
	//Cb -= 128.0f;

	//float4	ArctanCurr	= floor(  180.0f * atan2( (Cb - 128.0f), (Cr - 128.0f) ) );
	float4	ArctanCurr	= floor(  180.0f * atan2( (Cb), (Cr ) ) );		// already subtracted out 128

	// atan2 is very expensive - if atan works, use it instead!!!  NO - BAD RESULTS
	//Cr = select( Cr, 0.0000001, Cr == 0.0f );
	//float4	ArctanCurr	= floor(  180.0f * atan( (Cb )/ (Cr) ) );
	float4	AngleDiff = fabs( (ArctanCurr - floor(arctan)) );

	AngleDiff = select( AngleDiff,  (AngleDiff - 180.0f), (AngleDiff > 180.0f ) );

	uint4 Gray;
	Gray.x = clamp( convert_int( ( (4768.0f / 4096.0f)*(Y.x)  + 0.5f) ), 0, 255 );
	Gray.y = clamp( convert_int( ( (4768.0f / 4096.0f)*(Y.y)  + 0.5f) ), 0, 255 );
	Gray.z = clamp( convert_int( ( (4768.0f / 4096.0f)*(Y.z)  + 0.5f) ), 0, 255 );
	Gray.w = clamp( convert_int( ( (4768.0f / 4096.0f)*(Y.w)  + 0.5f) ), 0, 255 );

	Gray = Gray | Gray << 8 | Gray << 16 | alpha;

	uint4 uired4;
	uint4 uigreen4;
	uint4 uiblue4;

	if( any( AngleDiff <= ((float4)tolerance + Threshold) ) )
	{
		Cb =  (Cb) * ( Threshold -  ( AngleDiff - (float4)tolerance)) / Threshold;
		Cr =  (Cr) * ( Threshold -  ( AngleDiff - (float4)tolerance)) / Threshold;

		uired4.x =  clamp( convert_int( ( (4768.0f / 4096.0f) * (Y.x) + (6537.0f / 4096.0f) * (Cr.x) + 0.5f ) ), 0, 255 );
		uired4.y =  clamp( convert_int( ( (4768.0f / 4096.0f) * (Y.y) + (6537.0f / 4096.0f) * (Cr.y) + 0.5f ) ), 0, 255 );
		uired4.z =  clamp( convert_int( ( (4768.0f / 4096.0f) * (Y.z) + (6537.0f / 4096.0f) * (Cr.z) + 0.5f ) ), 0, 255 );
		uired4.w =  clamp( convert_int( ( (4768.0f / 4096.0f) * (Y.w) + (6537.0f / 4096.0f) * (Cr.w) + 0.5f ) ), 0, 255 );

		uigreen4.x = clamp(convert_int( ( (4768.0f / 4096.0f) * (Y.x) - (1602.0f / 4096.0f) * (Cb.x) - (3330.0f / 4096.0f) * (Cr.x) + 0.5f ) ), 0, 255);
		uigreen4.y = clamp(convert_int( ( (4768.0f / 4096.0f) * (Y.y) - (1602.0f / 4096.0f) * (Cb.y) - (3330.0f / 4096.0f) * (Cr.y) + 0.5f ) ), 0, 255);
		uigreen4.z = clamp(convert_int( ( (4768.0f / 4096.0f) * (Y.z) - (1602.0f / 4096.0f) * (Cb.z) - (3330.0f / 4096.0f) * (Cr.z) + 0.5f ) ), 0, 255);
		uigreen4.w = clamp(convert_int( ( (4768.0f / 4096.0f) * (Y.w) - (1602.0f / 4096.0f) * (Cb.w) - (3330.0f / 4096.0f) * (Cr.w) + 0.5f ) ), 0, 255);

		uiblue4.x =  clamp(convert_int( ( (4768.0f / 4096.0f) * (Y.x) + (8266.0f / 4096.0f) * (Cb.x) + 0.5f ) ), 0, 255);
		uiblue4.y =  clamp(convert_int( ( (4768.0f / 4096.0f) * (Y.y) + (8266.0f / 4096.0f) * (Cb.y) + 0.5f ) ), 0, 255);
		uiblue4.z =  clamp(convert_int( ( (4768.0f / 4096.0f) * (Y.z) + (8266.0f / 4096.0f) * (Cb.z) + 0.5f ) ), 0, 255);
		uiblue4.w =  clamp(convert_int( ( (4768.0f / 4096.0f) * (Y.w) + (8266.0f / 4096.0f) * (Cb.w) + 0.5f ) ), 0, 255);

		tempDst = uiblue4 | uigreen4 << 8 | uired4 << 16 | alpha;
		tempDst = select( tempSrc, tempDst, ( AngleDiff > (float4)tolerance ) );
		tempDst = select( tempDst, Gray, (AngleDiff > ( (float4)tolerance + Threshold )) );
	}
	else
		tempDst = Gray;

	dst[index] = tempDst;
}

/*
__kernel void FilterColor_Kernel_RGB_Case2_Original(__global const uchar4* src, __global uchar4* dst, int width, int height, int tolerance, int arctan)
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
*/


// YUV
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
