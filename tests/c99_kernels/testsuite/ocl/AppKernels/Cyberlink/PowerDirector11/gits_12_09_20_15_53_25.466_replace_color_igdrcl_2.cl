
// RGB

kernel void ReplaceColor_Kernel_RGB_Case1(__global const uchar4* src, __global uchar4* dst, int width, int height, int tolerance, int OriY, int OriCb, int OriCr, int RepY, int RepCb, int RepCr, unsigned char getAlphaType)
{
	int index = get_global_id(0);
	int CurY;
	int CurCb;
	int CurCr;
	int CurR;
	int CurG;
	int CurB;
	uchar4 tempSrc;
	uchar4 tempDst;

	tempSrc = src[index];

	CurB = tempSrc.x;
	CurG = tempSrc.y;
	CurR = tempSrc.z;

	CurY = ( 1053 * CurR + 2064 * CurG +  401 * CurB +  67584 ) >> 12;
	CurCb = ( -606 * CurR - 1192 * CurG + 1798 * CurB + 526336 ) >> 12;
	CurCr = ( 1798 * CurR - 1507 * CurG -  291 * CurB + 526336 ) >> 12;

	if ((( abs ( CurY  - OriY  )) <= tolerance ) &&
		(( abs ( CurCb - OriCb )) <= tolerance ) &&
		(( abs ( CurCr - OriCr )) <= tolerance ) &&
		tolerance > 0 )
	{
		CurCb = RepCb + ( CurCb - RepCb ) *  ( abs ( CurCb - OriCb )) / tolerance;
		int temp = ( CurCr - RepCr ) * ( abs ( CurCr - OriCr ));
		CurCr = RepCr + temp / tolerance;

		CurR = ( 4768 * (CurY - 16) + 6537 * (CurCr - 128) + 2048 ) >> 12;
		CurG = ( 4768 * (CurY - 16) - 1602 * (CurCb - 128) - 3330 * (CurCr - 128) + 2048 ) >> 12;
		CurB = ( 4768 * (CurY - 16) + 8266 * (CurCb - 128) + 2048 ) >> 12;

		if ( CurR < 0 )
			CurR = 0;
		else if ( CurR > 255 )
			CurR = 255;

		if ( CurG < 0 )
			CurG = 0;
		else if ( CurG > 255 )
			CurG = 255;

		if ( CurB < 0 )
			CurB = 0;
		else if ( CurB > 255 )
			CurB = 255;
	}

	tempDst.w = tempSrc.w;
	tempDst.x = CurB;
	tempDst.y = CurG;
	tempDst.z = CurR;

	if(getAlphaType == 1)
		tempDst.w = src[index].w;
	else if(getAlphaType == 2)
		tempDst.w = 255;

	dst[index] = tempDst;

}

kernel void ReplaceColor_Kernel_RGB_Case2(__global const uchar4* src, __global uchar4* dst, int width, int height, float Arctan, float Length, float AngleTolerance, int OriY, int OriCb, int OriCr, int RepY, int RepCb, int RepCr, unsigned char getAlphaType)
{
	int index = get_global_id(0);
	int CurY;
	int CurCb;
	int CurCr;
	int CurR;
	int CurG;
	int CurB;
	uchar4 tempSrc;
	uchar4 tempDst;
	float tempCb;
	float tempCr;
	float ArctanCur;
	float LengthCur;
	float AngleDiff;

	tempSrc = src[index];

	CurB = tempSrc.x;
	CurG = tempSrc.y;
	CurR = tempSrc.z;

	CurY = ( 1053 * CurR + 2064 * CurG +  401 * CurB +  67584 ) >> 12;
	CurCb = ( -606 * CurR - 1192 * CurG + 1798 * CurB + 526336 ) >> 12;
	CurCr = ( 1798 * CurR - 1507 * CurG -  291 * CurB + 526336 ) >> 12;

	tempCb = CurCb - 128;
	tempCr = CurCr - 128;

//	ArctanCur = atan2(tempCb, tempCr);

	ArctanCur = acos(tempCb / sqrt(tempCb * tempCb + tempCr * tempCr));

	if(tempCb < 0)
		ArctanCur *= -1.0f;


	tempCb = (CurCb - 128) * (CurCb - 128);
	tempCr = (CurCr - 128) * (CurCr - 128);

	LengthCur = sqrt(tempCb + tempCr);

	AngleDiff = fabs(ArctanCur - Arctan);

	if ( AngleDiff > 3.1415926535897932384626433832795f )
		AngleDiff -= 3.1415926535897932384626433832795f;

	if ( AngleDiff <= AngleTolerance )
	{
		CurCb = RepCb;
		CurCr = RepCr;

		CurR = ( 4768 * (CurY - 16) + 6537 * (CurCr - 128) + 2048 ) >> 12;
		CurG = ( 4768 * (CurY - 16) - 1602 * (CurCb - 128) - 3330 * (CurCr - 128) + 2048 ) >> 12;
		CurB = ( 4768 * (CurY - 16) + 8266 * (CurCb - 128) + 2048 ) >> 12;

		if ( CurR < 0 )
			CurR = 0;
		else if ( CurR > 255 )
			CurR = 255;

		if ( CurG < 0 )
			CurG = 0;
		else if ( CurG > 255 )
			CurG = 255;

		if ( CurB < 0 )
			CurB = 0;
		else if ( CurB > 255 )
			CurB = 255;
	}

	tempDst.x = (int)CurB;
	tempDst.y = CurG;
	tempDst.z = CurR;

	if(getAlphaType == 1)
		tempDst.w = src[index].w;
	else if(getAlphaType == 2)
		tempDst.w = 255;

	dst[index] = tempDst;

}

kernel void ReplaceColor_Kernel_RGB_Case3(__global const uchar4* src, __global uchar4* dst, int width, int height, float Arctan, float Length, float AngleTolerance, float ArctanRep, float LengthRep, int OriY, int OriCb, int OriCr, int RepY, int RepCb, int RepCr, unsigned char getAlphaType)
{
	int index = get_global_id(0);
	int CurY;
	int CurCb;
	int CurCr;
	int CurR;
	int CurG;
	int CurB;
	uchar4 tempSrc;
	uchar4 tempDst;
	float tempCb;
	float tempCr;
	float ArctanCur;
	float LengthCur;
	float AngleDiff;

	tempSrc = src[index];

	CurB = tempSrc.x;
	CurG = tempSrc.y;
	CurR = tempSrc.z;

	CurY = ( 1053 * CurR + 2064 * CurG +  401 * CurB +  67584 ) >> 12;
	CurCb = ( -606 * CurR - 1192 * CurG + 1798 * CurB + 526336 ) >> 12;
	CurCr = ( 1798 * CurR - 1507 * CurG -  291 * CurB + 526336 ) >> 12;

	tempCb = CurCb - 128;
	tempCr = CurCr - 128;

//	ArctanCur = atan2(tempCb, tempCr);

	ArctanCur = acos(tempCr / sqrt(tempCb * tempCb + tempCr * tempCr));

	if(tempCb < 0)
		ArctanCur *= -1.0f;


	tempCb = (CurCb - 128) * (CurCb - 128);
	tempCr = (CurCr - 128) * (CurCr - 128);

	LengthCur = sqrt(tempCb + tempCr);

	AngleDiff = fabs(ArctanCur - Arctan);

	if ( AngleDiff > 3.1415926535897932384626433832795f )
	AngleDiff -= 3.1415926535897932384626433832795f;

	if ( AngleDiff <= AngleTolerance )
	{
		LengthCur = LengthRep * LengthCur / Length;

		CurCb = 128 + LengthCur * sin ( ArctanRep );
		CurCr = 128 + LengthCur * cos ( ArctanRep );

		CurR = ( 4768 * (CurY - 16) + 6537 * (CurCr - 128) + 2048 ) >> 12;
		CurG = ( 4768 * (CurY - 16) - 1602 * (CurCb - 128) - 3330 * (CurCr - 128) + 2048 ) >> 12;
		CurB = ( 4768 * (CurY - 16) + 8266 * (CurCb - 128) + 2048 ) >> 12;

		if ( CurR < 0 )
			CurR = 0;
		else if ( CurR > 255 )
			CurR = 255;

		if ( CurG < 0 )
			CurG = 0;
		else if ( CurG > 255 )
			CurG = 255;

		if ( CurB < 0 )
			CurB = 0;
		else if ( CurB > 255 )
			CurB = 255;
	}

	tempDst.x = CurB;
	tempDst.y = CurG;
	tempDst.z = CurR;

	if(getAlphaType == 1)
		tempDst.w = src[index].w;
	else if(getAlphaType == 2)
		tempDst.w = 255;

	dst[index] = tempDst;

}

//YUV

kernel void ReplaceColor_Kernel_YUV_Case1(__global const uchar4* src, __global uchar4* dst, int width, int height, int tolerance, int OriY, int OriCb, int OriCr, int RepY, int RepCb, int RepCr, unsigned char getAlphaType)
{
	int index = get_global_id(0);
	int CurY;
	int CurCb;
	int CurCr;
	uchar4 tempSrc;
	uchar4 tempDst;

	tempSrc = src[index];

	CurCr = tempSrc.x;
	CurCb = tempSrc.y;
	CurY = tempSrc.z;

	if ((( abs ( CurY  - OriY  )) <= tolerance ) &&
		(( abs ( CurCb - OriCb )) <= tolerance ) &&
		(( abs ( CurCr - OriCr )) <= tolerance ) &&
		tolerance > 0 )
	{
		CurCb = RepCb + ( CurCb - RepCb ) *  ( abs ( CurCb - OriCb )) / tolerance;
		CurCr = RepCr + ( CurCr - RepCr ) *  ( abs ( CurCr - OriCr )) / tolerance;

		if ( CurCr < 0 )
			CurCr = 0;
		else if ( CurCr > 255 )
			CurCr = 255;

		if ( CurCb < 0 )
			CurCb = 0;
		else if ( CurCb > 255 )
			CurCb = 255;

	}

	tempDst.x = CurCr;
	tempDst.y = CurCb;
	tempDst.z = CurY;

	if(getAlphaType == 1)
		tempDst.w = src[index].w;
	else if(getAlphaType == 2)
		tempDst.w = 255;

	dst[index] = tempDst;

}

kernel void ReplaceColor_Kernel_YUV_Case2(__global const uchar4* src, __global uchar4* dst, int width, int height, float Arctan, float Length, float AngleTolerance, int OriY, int OriCb, int OriCr, int RepY, int RepCb, int RepCr, unsigned char getAlphaType)
{
	int index = get_global_id(0);
	int CurY;
	int CurCb;
	int CurCr;
	uchar4 tempSrc;
	uchar4 tempDst;
	float tempCb;
	float tempCr;
	float ArctanCur;
	float LengthCur;
	float AngleDiff;

	tempSrc = src[index];

	CurCr = tempSrc.x;
	CurCb = tempSrc.y;
	CurY = tempSrc.z;

	tempCb = CurCb - 128;
	tempCr = CurCr - 128;

//	ArctanCur = atan2(tempCb, tempCr);

	ArctanCur = acos(tempCr / sqrt(tempCb * tempCb + tempCr * tempCr));

	if(tempCb < 0)
		ArctanCur *= -1.0f;


	tempCb = (CurCb - 128) * (CurCb - 128);
	tempCr = (CurCr - 128) * (CurCr - 128);

	LengthCur = sqrt(tempCb + tempCr);

	AngleDiff = fabs(ArctanCur - Arctan);

	if ( AngleDiff > 3.1415926535897932384626433832795f )
	AngleDiff -= 3.1415926535897932384626433832795f;

	if ( AngleDiff <= AngleTolerance )
	{
		CurCb = RepCb;
		CurCr = RepCr;

		if ( CurCr < 0 )
			CurCr = 0;
		else if ( CurCr > 255 )
			CurCr = 255;

		if ( CurCb < 0 )
			CurCb = 0;
		else if ( CurCb > 255 )
			CurCb = 255;

	}

	tempDst.x = CurCr;
	tempDst.y = CurCb;
	tempDst.z = CurY;

	if(getAlphaType == 1)
		tempDst.w = src[index].w;
	else if(getAlphaType == 2)
		tempDst.w = 255;

	dst[index] = tempDst;

}

kernel void ReplaceColor_Kernel_YUV_Case3(__global const uchar4* src, __global uchar4* dst, int width, int height, float Arctan, float Length, float AngleTolerance, float ArctanRep, float LengthRep, int OriY, int OriCb, int OriCr, int RepY, int RepCb, int RepCr, unsigned char getAlphaType)
{
	int index = get_global_id(0);
	int CurY;
	int CurCb;
	int CurCr;
	uchar4 tempSrc;
	uchar4 tempDst;
	float tempCb;
	float tempCr;
	float ArctanCur;
	float LengthCur;
	float AngleDiff;

	tempSrc = src[index];

	CurCr = tempSrc.x;
	CurCb = tempSrc.y;
	CurY = tempSrc.z;

	tempCb = CurCb - 128;
	tempCr = CurCr - 128;

//	ArctanCur = atan2(tempCb, tempCr);

	ArctanCur = acos(tempCr / sqrt(tempCb * tempCb + tempCr * tempCr));

	if(tempCb < 0)
		ArctanCur *= -1.0f;


	tempCb = (CurCb - 128) * (CurCb - 128);
	tempCr = (CurCr - 128) * (CurCr - 128);

	LengthCur = sqrt(tempCb + tempCr);

	AngleDiff = fabs(ArctanCur - Arctan);

	if ( AngleDiff > 3.1415926535897932384626433832795f )
	AngleDiff -= 3.1415926535897932384626433832795f;

	if ( AngleDiff <= AngleTolerance )
	{
		LengthCur = LengthRep * LengthCur / Length;

		CurCb = 128 + LengthCur * sin ( ArctanRep );
		CurCr = 128 + LengthCur * cos ( ArctanRep );

		if ( CurCr < 0 )
			CurCr = 0;
		else if ( CurCr > 255 )
			CurCr = 255;

		if ( CurCb < 0 )
			CurCb = 0;
		else if ( CurCb > 255 )
			CurCb = 255;

	}

	tempDst.x = CurCr;
	tempDst.y = CurCb;
	tempDst.z = CurY;

	if(getAlphaType == 1)
		tempDst.w = src[index].w;
	else if(getAlphaType == 2)
		tempDst.w = 255;

	dst[index] = tempDst;

}


// buildOptions=
// RUN: %occ-cli %s --cl-options="-I%cwd -I%S " %cfg_path --cl-device=%cl_device 2>&1
