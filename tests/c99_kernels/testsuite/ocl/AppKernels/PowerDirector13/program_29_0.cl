#define HLSMAX 65532	// H,L, and S vary over 0-HLSMAX.
#define RGBMAX 255	// R,G, and B vary over 0-RGBMAX. HLSMAX BEST if DIVISIBLE BY 6. RGBMAX, HLSMAX must each fit in a byte.
#define HLSMAX_DIV2 32766
#define HLSMAX_DIV3 21844
#define HLSMAX_DIV6 10922
#define HLSMAX_DIV12 5461
#define HLSMAX_DIV3_MUL2 43688
#define RGBMAX_MUL2 510

//__constant sampler_t imageSampler = CLK_NORMALIZED_COORDS_FALSE | CLK_ADDRESS_CLAMP | CLK_FILTER_NEAREST;
__constant sampler_t imageSampler = CLK_NORMALIZED_COORDS_FALSE  | CLK_FILTER_NEAREST;
__constant sampler_t imageSampler2 = CLK_NORMALIZED_COORDS_FALSE | CLK_ADDRESS_CLAMP | CLK_FILTER_NEAREST;

int HueToRGB(int n1, int n2, int h)
{
	// Range check: note values passed add/subtract thirds of range.
	h += HLSMAX;
	while( h > HLSMAX )	h -= HLSMAX;

	// Return r, g, or b value from this tridrant.
	int	diff = n2 - n1;
	int	retval = (h < HLSMAX_DIV6)?	(n1 + (((diff) * h + HLSMAX_DIV12) / HLSMAX_DIV6)) :
									(h < HLSMAX_DIV2)?	n2 :
														(h < HLSMAX_DIV3_MUL2)? (n1 + (((diff) * (HLSMAX_DIV3_MUL2 - h) + HLSMAX_DIV12) / HLSMAX_DIV6)) : n1;

	return retval;
}

__kernel void Lomo_ColorConvert_AdjustLight(__read_only image2d_t src, __global uchar4 * dst, __constant int* ContrastTable, int width, int height,
                                       int CenterBrightness, int Brightness, int Radius, int Saturation)
{
	int	 x = get_global_id(0);
	int  y = get_global_id(1);

	// constrain to actual frame buffer - sampler not clamping...
	x = min( x, width -1 );
	y = min( y, height -1 );
	int	index = x + y * width;
	int2 coord = (int2)(x, y);

	uint4 tempSrc;
	uint4 tempDst;
	int4 tempColor;
	int4 tempDstColor;


	//Calculate Ellipse Pos Table

	int nEllipsePosTable = 0;
	int nHeightRadius = (height * Radius) >> 13;
	int nWidthRadius = (width * Radius) >> 13;
    	// if the width or height is 1, the nHeightRadius and nWidthRadius will be 0.
	nWidthRadius = max(nWidthRadius, 1);
	nHeightRadius = max(nHeightRadius, 1);

	int SquareHeightRadius = nHeightRadius * nHeightRadius;
	int SquareWidthRadius = nWidthRadius * nWidthRadius;
	int nCenterX = width >> 1; // center coordinate of image
	int nCenterY = height >> 1;

	int nDistanceX = (x - nCenterX);
	int nDistanceY = (y - nCenterY);
	int SquareDistanceX = nDistanceX * nDistanceX;
	int SquareDistanceY = nDistanceY * nDistanceY;

	int nPositionFlag = (int)(4096.0f * (float)SquareDistanceX / (float)SquareWidthRadius)
							+ (int)(4096.0f * (float)SquareDistanceY / (float)SquareHeightRadius);

	nEllipsePosTable = nPositionFlag;

	//Color convert from RGB to YUV
	tempSrc = read_imageui(src, imageSampler, coord);

///////////////////////////////////
// TRC_CHG - Going to float provides a bit of perf boost, didn't SEEM to hurt output here
// BUT if output differences are seen, this is the most likely source.
///////////////////////////////////
	//tempColor.z = ( 1053 * (int)tempSrc.z + 2064 * (int)tempSrc.y +  401 * (int)tempSrc.x +  67584 ) >> 12;		// 65536 -> 16 x 2^12
	//tempColor.y = ( -606 * (int)tempSrc.z - 1192 * (int)tempSrc.y + 1798 * (int)tempSrc.x + 526336 ) >> 12;		// 524288 -> 128 x2^12
	//tempColor.x = ( 1798 * (int)tempSrc.z - 1507 * (int)tempSrc.y -  291 * (int)tempSrc.x + 526336 ) >> 12;
	tempColor.z = (int)( mad((1053.0f / 4096.0f), (float)tempSrc.z, mad((2064.0f / 4096.0f), (float)tempSrc.y, mad((401.0f / 4096.0f), (float)tempSrc.x,  (67584.0f / 4096.0f) ) )));		// 65536 -> 16 x 2^12
	tempColor.y = (int)( mad((-606.0f / 4096.0f), (float)tempSrc.z, mad((-1192.0f / 4096.0f), (float)tempSrc.y, mad((1798.0f / 4096.0f), (float)tempSrc.x, (526336.0f / 4096.0f) ) )));		// 524288 -> 128 x2^12
	tempColor.x = (int)( mad((1798.0f / 4096.0f), (float)tempSrc.z, mad((-1507.0f / 4096.0f), (float)tempSrc.y,  mad((-291.0f / 4096.0f), (float)tempSrc.x, (526336.0f / 4096.0f) ) ))) ;

	//Adjust Light

	int nColor = (int)(CenterBrightness * tempColor.z) >> 12;
	nColor = nColor - ((nColor * nEllipsePosTable) >> 12);
	nColor = min(max(nColor, 0), 255);

	// Adjust brightness of whole picture
	nColor += Brightness;
	nColor = min(max(nColor, 0), 255);

	//Color convert from YUV to RGB

	tempColor.z = nColor - 16;
	tempColor.y = (int)tempColor.y - 128;
	tempColor.x = (int)tempColor.x - 128;

	tempDstColor.z = ( 4768 * tempColor.z						+ 6537 * tempColor.x + 2048 ) >> 12;
	tempDstColor.y = ( 4768 * tempColor.z - 1602 * tempColor.y	- 3330 * tempColor.x + 2048 ) >> 12;
	tempDstColor.x = ( 4768 * tempColor.z + 8266 * tempColor.y						 + 2048 ) >> 12;

	tempDstColor.x = clamp( tempDstColor.x, 0, 255 );
	tempDstColor.y = clamp( tempDstColor.y, 0, 255 );
	tempDstColor.z = clamp( tempDstColor.z, 0, 255 );


	//RGB to HSL

	int H, L, S;
	int cMax, cMin;	// Max and min RGB values.

	// Calculate lightness.
	cMax = max( max( tempDstColor.x, tempDstColor.y ), tempDstColor.z );
	cMin = min( min( tempDstColor.x, tempDstColor.y ), tempDstColor.z );

	int diff = cMax - cMin;
	int	cSum = cMax + cMin;
	int	cMid = tempDstColor.x + tempDstColor.y + tempDstColor.z - cSum;


	L = (((cMax + cMin) * HLSMAX) + RGBMAX) / RGBMAX_MUL2;

	if (cMax == cMin)	// r = g = b --> achromatic case.
	{
		S = 0;	// Saturation.
		H = HLSMAX_DIV3_MUL2;	// Hue.
	}
	else	// Chromatic case.
	{
		// Saturation.
		if (L <= HLSMAX_DIV2)
			S = (diff * HLSMAX + ((cSum) >> 1)) / (cSum);
		else
			S = (diff * HLSMAX + ((RGBMAX_MUL2 - cSum) >> 1)) / (RGBMAX_MUL2 - cSum);


#if 1
		H =  ( tempDstColor.z == cMax )?	( tempDstColor.y - tempDstColor.x) :
											(tempDstColor.y == cMax )?	( tempDstColor.x - tempDstColor.z) : ( tempDstColor.z - tempDstColor.y);
		H = ( (H * HLSMAX_DIV6) + (diff >> 1)) / diff;
		H +=  ( tempDstColor.z == cMax )? 0 : ( tempDstColor.y == cMax )? HLSMAX_DIV3 : HLSMAX_DIV3_MUL2;

		H += HLSMAX;
		while( H > HLSMAX )	H -= HLSMAX;
#else
		if (tempDstColor.z == cMax)
			H = (( tempDstColor.y - tempDstColor.x) * HLSMAX_DIV6 + (diff >> 1)) / diff;
		else if (tempDstColor.y == cMax)
			H = HLSMAX_DIV3 + (( tempDstColor.x - tempDstColor.z) * HLSMAX_DIV6 + (diff >> 1) ) / diff;
		else	// B == cMax.
			H = HLSMAX_DIV3_MUL2 + (( tempDstColor.z - tempDstColor.y) * HLSMAX_DIV6 + (diff >> 1)) / diff;

		if (H < 0)
			H += HLSMAX;
		if (H > HLSMAX)
			H -= HLSMAX;
#endif
	}

//	tempDstColor.x = H >> 8;//H
	tempDstColor.y = S >> 8;	//S
//	tempDstColor.z = L >> 8;	//L

	tempDstColor.y = (tempDstColor.y * Saturation) >> 12;
	tempDstColor.y = clamp(tempDstColor.y, 0, 255);

	H = H & ~0x0FF;		//((H >> 8) << 8);
	L = L & ~0x0FF;		//((L >> 8) << 8);
	S = tempDstColor.y << 8;

	int Magic1, Magic2;	// Calculated magic numbers (really!).

	if (S == 0)	// Achromatic case.
	{
		tempDstColor.x = L * RGBMAX / HLSMAX;
		tempDstColor.y = tempDstColor.x;
		tempDstColor.z = tempDstColor.x;
	}
	else	// Chromatic case.
	{
		// Set up magic numbers.
		if (L <= HLSMAX_DIV2)
			Magic2 = (L * (HLSMAX + S) + HLSMAX_DIV2) / HLSMAX;
		else
			Magic2 = L + S - ((L * S) + HLSMAX_DIV2) / HLSMAX;

		Magic1 = 2 * L - Magic2;

#if 1
		Magic1 += HLSMAX;
		while( Magic1 > HLSMAX )	Magic1 -= HLSMAX;

		Magic2 += HLSMAX;
		while( Magic2 > HLSMAX )	Magic2 -= HLSMAX;
#else
		if (Magic1 < 0)
			Magic1 += HLSMAX;
		else if (Magic1 > HLSMAX)
			Magic1 -= HLSMAX;

		if (Magic2 < 0)
			Magic2 += HLSMAX;
		else if (Magic2 > HLSMAX)
			Magic2 -= HLSMAX;
#endif

		// Get RGB, change units from HLSMAX to RGBMAX.
		tempDstColor.z = ((HueToRGB(Magic1, Magic2, H + HLSMAX_DIV3) * RGBMAX + HLSMAX_DIV2) / HLSMAX);
		tempDstColor.y = ((HueToRGB(Magic1, Magic2, H) * RGBMAX + HLSMAX_DIV2) / HLSMAX);
		tempDstColor.x = ((HueToRGB(Magic1, Magic2, H - HLSMAX_DIV3) * RGBMAX + HLSMAX_DIV2) / HLSMAX);
	}

	tempDst.x = ContrastTable[tempDstColor.x];

	tempDstColor.y = min(tempDstColor.y + 20, 255);
	tempDst.y = ContrastTable[tempDstColor.y];
	tempDst.z = ContrastTable[tempDstColor.z];

	tempDst.w = 255;

	dst[index] =  convert_uchar4_sat( tempDst );
}

__kernel void Lomo_AdjustContrast(__read_only image2d_t src, __write_only image2d_t dst, float tangent, __global float* Mean)
{
	int2 coord = (int2)(get_global_id(0), get_global_id(1));

	uint4 tempSrc;
	uint4 tempDst;
	float fMean = Mean[0];

	tempSrc = read_imageui(src, imageSampler, coord);

	float offset = (float)tempSrc.x - fMean;
	float newValue = min(max(fMean + offset * tangent, 0.0f), 255.0f);

	tempDst.x = (uint)newValue;

	offset = (float)tempSrc.y - fMean;
	newValue = min(max(fMean + offset * tangent, 0.0f), 255.0f);

	tempDst.y = (uint)newValue;

	offset = (float)tempSrc.z - fMean;
	newValue = min(max(fMean + offset * tangent, 0.0f), 255.0f);

	tempDst.z = (uint)newValue;

	coord = (int2)(get_global_id(0), get_global_id(1));
	write_imageui(dst, coord, tempDst);
}

__kernel void Lomo_AverageRGBPixel(__read_only image2d_t src,  __global int* MaximumTable, int width, int height, int block_size )//,     int tableWidth )
{
	int2 coord;// = (int2)(get_global_id(0), get_global_id(1));
	int w = get_global_id(0);
	int h = get_global_id(1);

	if( w < width )	// height is limited with the "min" below, nStartY always < height
	{
		uint4 tempValue = {0, 0, 0, 0};

		//int nStartX = w * block_size;
		//int nEndX = min((w + 1) * block_size - 1, width - 1);
		int nStartY = h * block_size;
		int nEndY = min((h + 1) * block_size - 1, height - 1);

		unsigned int nTotal1 = 0, nTotal2 = 0, nTotal3 = 0;

		//for(int x = nStartX; x <= nEndX; x++)
		int	x = w;
		{
			for(int y = nStartY; y <= nEndY; y++)
			{
				coord = (int2)(x, y);
				tempValue = read_imageui(src, imageSampler, coord);

				nTotal1 += tempValue.x;
				nTotal2 += tempValue.y;
				nTotal3 += tempValue.z;
			}
		}

		MaximumTable[w + h * width] = nTotal1 + nTotal2 + nTotal3;
	}
}

__kernel void Lomo_SumKernel(__global int4* MaximumTable, int TableSize, __global float* Mean, int TotalSize)
{
	__global int	* pTable = (__global int *)MaximumTable;

	int4 nTotal4 = 0;
	int	nTotal = 0;
	int	size4 = TableSize >> 2;

	for(uint i = 0; i < size4; i++)
	{
		nTotal4 += MaximumTable[i];
	}

	int	extraStart = size4 * 4;
	for( uint i = extraStart; i < TableSize; i++)
	{
		nTotal += pTable[i];
	}

	nTotal += nTotal4.s0 + nTotal4.s1 + nTotal4.s2 + nTotal4.s3;

	float fMean = (float)nTotal / (float)(TotalSize);
	Mean[0] = fMean;
}

/////////////////////////////////////////////////////////////////////////////////////
// original
/////////////////////////////////////////////////////////////////////////////////////

int HueToRGB_ori(int n1, int n2, int h)
{
	// Range check: note values passed add/subtract thirds of range.
	if (h < 0)
		h += HLSMAX;
	if (h > HLSMAX)
		h -= HLSMAX;

	// Return r, g, or b value from this tridrant.
	if (h < HLSMAX_DIV6)
		return (n1 + (((n2 - n1) * h + HLSMAX_DIV12) / HLSMAX_DIV6));
	if (h < HLSMAX_DIV2)
		return n2;
	if (h < HLSMAX_DIV3_MUL2)
		return (n1 + (((n2 - n1) * (HLSMAX_DIV3_MUL2 - h) + HLSMAX_DIV12) / HLSMAX_DIV6));
	else
		return n1;
}

__kernel void Lomo_ColorConvert_AdjustLight_ori(__read_only image2d_t src, __write_only image2d_t dst, __constant int* ContrastTable, int width, int height,
                                       int CenterBrightness, int Brightness, int Radius, int Saturation)
{
	int2 coord = (int2)(get_global_id(0), get_global_id(1));

	uint4 tempSrc;
	uint4 tempDst;
	int4 tempColor;
	int4 tempDstColor;


	//Calculate Ellipse Pos Table

	int nEllipsePosTable = 0;
	int nHeightRadius = (height * Radius) >> 13;
	int nWidthRadius = (width * Radius) >> 13;
    	// if the width or height is 1, the nHeightRadius and nWidthRadius will be 0.
	nWidthRadius = max(nWidthRadius, 1);
	nHeightRadius = max(nHeightRadius, 1);

	int SquareHeightRadius = nHeightRadius * nHeightRadius;
	int SquareWidthRadius = nWidthRadius * nWidthRadius;
	int nCenterX = width / 2; // center coordinate of image
	int nCenterY = height / 2;

	int nDistanceX = (get_global_id(0) - nCenterX);
	int nDistanceY = (get_global_id(1) - nCenterY);
	int SquareDistanceX = nDistanceX * nDistanceX;
	int SquareDistanceY = nDistanceY * nDistanceY;

	int nPositionFlag = (int)(4096.0f * (float)SquareDistanceX / (float)SquareWidthRadius)
	+ (int)(4096.0f * (float)SquareDistanceY / (float)SquareHeightRadius);

	nEllipsePosTable = nPositionFlag;

	//Color convert from RGB to YUV
	tempSrc = read_imageui(src, imageSampler, coord);

	tempColor.z = ( 1053 * (int)tempSrc.z + 2064 * (int)tempSrc.y +  401 * (int)tempSrc.x +  67584 ) >> 12;		// 65536 -> 16 x 2^12
	tempColor.y = ( -606 * (int)tempSrc.z - 1192 * (int)tempSrc.y + 1798 * (int)tempSrc.x + 526336 ) >> 12;		// 524288 -> 128 x2^12
	tempColor.x = ( 1798 * (int)tempSrc.z - 1507 * (int)tempSrc.y -  291 * (int)tempSrc.x + 526336 ) >> 12;

	//Adjust Light

	int nColor = (int)(CenterBrightness * tempColor.z) >> 12;
	nColor = nColor - ((nColor * nEllipsePosTable) >> 12);
	nColor = min(max(nColor, 0), 255);

	// Adjust brightness of whole picture
	nColor += Brightness;
	nColor = min(max(nColor, 0), 255);

	//Color convert from YUV to RGB

	tempColor.z = nColor - 16;
	tempColor.y = (int)tempColor.y - 128;
	tempColor.x = (int)tempColor.x - 128;

	tempDstColor.z = ( 4768 * tempColor.z						+ 6537 * tempColor.x + 2048 ) >> 12;
	tempDstColor.y = ( 4768 * tempColor.z - 1602 * tempColor.y - 3330 * tempColor.x + 2048 ) >> 12;
	tempDstColor.x = ( 4768 * tempColor.z + 8266 * tempColor.y             + 2048 ) >> 12;

	tempDstColor.x = max(min(tempDstColor.x, 255), 0);
	tempDstColor.y = max(min(tempDstColor.y, 255), 0);
	tempDstColor.z = max(min(tempDstColor.z, 255), 0);


	//RGB to HSL

	int H, L, S;
	int cMax, cMin;	// Max and min RGB values.

	// Calculate lightness.
	if ( tempDstColor.z > tempDstColor.y )
	{
		cMax = (tempDstColor.z > tempDstColor.x) ? tempDstColor.z : tempDstColor.x;
		cMin = (tempDstColor.y < tempDstColor.x) ? tempDstColor.y : tempDstColor.x;
	}
	else
	{
		cMax = (tempDstColor.y > tempDstColor.x) ? tempDstColor.y : tempDstColor.x;
		cMin = (tempDstColor.z < tempDstColor.x) ? tempDstColor.z : tempDstColor.x;
	}
	int diff = cMax - cMin;

	L = (((cMax + cMin) * HLSMAX) + RGBMAX) / RGBMAX_MUL2;

	if (cMax == cMin)	// r = g = b --> achromatic case.
	{
		S = 0;	// Saturation.
		H = HLSMAX_DIV3_MUL2;	// Hue.
	}
	else	// Chromatic case.
	{
		// Saturation.
		if (L <= HLSMAX_DIV2)
			S = (diff * HLSMAX + ((cMax + cMin) >> 1)) / (cMax + cMin);
		else
			S = (diff * HLSMAX + ((RGBMAX_MUL2 - cMax - cMin) >> 1)) / (RGBMAX_MUL2 - cMax - cMin);

		// Hue.
		if (tempDstColor.z == cMax)
			H = (( tempDstColor.y - tempDstColor.x) * HLSMAX_DIV6 + (diff >> 1)) / diff;
		else if (tempDstColor.y == cMax)
			H = HLSMAX_DIV3 + (( tempDstColor.x - tempDstColor.z) * HLSMAX_DIV6 + (diff >> 1) ) / diff;
		else	// B == cMax.
			H = HLSMAX_DIV3_MUL2 + (( tempDstColor.z - tempDstColor.y) * HLSMAX_DIV6 + (diff >> 1)) / diff;

		if (H < 0)
			H += HLSMAX;
		if (H > HLSMAX)
			H -= HLSMAX;

	}

//	tempDstColor.x = H >> 8;	//H
	tempDstColor.y = S >> 8;	//S
//	tempDstColor.z = L >> 8;	//L

	tempDstColor.y = (tempDstColor.y * Saturation) >> 12;
	tempDstColor.y = max(min(tempDstColor.y, 255), 0);

	H = ((H >> 8) << 8);
	L = ((L >> 8) << 8);
	S = tempDstColor.y << 8;

	int Magic1, Magic2;	// Calculated magic numbers (really!).

	if (S == 0)	// Achromatic case.
	{
		tempDstColor.x = L * RGBMAX / HLSMAX;
		tempDstColor.y = tempDstColor.x;
		tempDstColor.z = tempDstColor.x;
	}
	else	// Chromatic case.
	{
		// Set up magic numbers.
		if (L <= HLSMAX_DIV2)
			Magic2 = (L * (HLSMAX + S) + HLSMAX_DIV2) / HLSMAX;
		else
			Magic2 = L + S - ((L * S) + HLSMAX_DIV2) / HLSMAX;

		Magic1 = 2 * L - Magic2;

		if (Magic1 < 0)
			Magic1 += HLSMAX;
		else if (Magic1 > HLSMAX)
			Magic1 -= HLSMAX;

		if (Magic2 < 0)
			Magic2 += HLSMAX;
		else if (Magic2 > HLSMAX)
			Magic2 -= HLSMAX;

		// Get RGB, change units from HLSMAX to RGBMAX.
		tempDstColor.z = ((HueToRGB_ori(Magic1, Magic2, H + HLSMAX_DIV3) * RGBMAX + HLSMAX_DIV2) / HLSMAX);
		tempDstColor.y = ((HueToRGB_ori(Magic1, Magic2, H) * RGBMAX + HLSMAX_DIV2) / HLSMAX);
		tempDstColor.x = ((HueToRGB_ori(Magic1, Magic2, H - HLSMAX_DIV3) * RGBMAX + HLSMAX_DIV2) / HLSMAX);
	}

	tempDst.x = ContrastTable[tempDstColor.x];

	tempDstColor.y = min(tempDstColor.y + 20, 255);
	tempDst.y = ContrastTable[tempDstColor.y];
	tempDst.z = ContrastTable[tempDstColor.z];

	tempDst.w = tempSrc.w;

	write_imageui(dst, coord, tempDst);
}

__kernel void Lomo_AdjustContrast_ori(__read_only image2d_t src, __write_only image2d_t dst, float tangent, __global float* Mean)
{
	int2 coord = (int2)(get_global_id(0), get_global_id(1));

	uint4 tempSrc;
	uint4 tempDst;
	float fMean = Mean[0];

	tempSrc = read_imageui(src, imageSampler, coord);

	float offset = (float)tempSrc.x - fMean;
	float newValue = min(max(fMean + offset * tangent, 0.0f), 255.0f);

	tempDst.x = (uint)newValue;

	offset = (float)tempSrc.y - fMean;
	newValue = min(max(fMean + offset * tangent, 0.0f), 255.0f);

	tempDst.y = (uint)newValue;

	offset = (float)tempSrc.z - fMean;
	newValue = min(max(fMean + offset * tangent, 0.0f), 255.0f);

	tempDst.z = (uint)newValue;

	tempDst.w = tempSrc.w;

	coord = (int2)(get_global_id(0), get_global_id(1));
	write_imageui(dst, coord, tempDst);
}

__kernel void Lomo_AverageRGBPixel_ori(__read_only image2d_t src,  __global int* MaximumTable, int width, int height, int block_size,
			      int tableWidth )
{
	int2 coord;// = (int2)(get_global_id(0), get_global_id(1));
	int w = get_global_id(0);
	int h = get_global_id(1);


	uint4 tempValue = {0, 0, 0, 0};

	int nStartX = w * block_size;
	int nEndX = min((w + 1) * block_size - 1, width - 1);
	int nStartY = h * block_size;
	int nEndY = min((h + 1) * block_size - 1, height - 1);

	if( nStartX < width && nStartY < height )
	{

	unsigned int nTotal = 0;

	for(int x = nStartX; x <= nEndX; x++)
	{
		for(int y = nStartY; y <= nEndY; y++)
		{
			coord = (int2)(x, y);
			tempValue = read_imageui(src, imageSampler, coord);

			nTotal += tempValue.x;
			nTotal += tempValue.y;
			nTotal += tempValue.z;
		}
	}

	MaximumTable[w + h * tableWidth] = nTotal;
	}
}

__kernel void Lomo_SumKernel_ori(__global int* MaximumTable, int TableSize, __global float* Mean, int TotalSize)
{
	int nMaximumValue = 0;
	for(int i = 0; i < TableSize; i++)
	{
		nMaximumValue += MaximumTable[i];
	}

	float fMean = (float)nMaximumValue / (float)(TotalSize);
	Mean[0] = fMean;
}

// buildOptions=
// RUN: %occ-cli %s --cl-options="-I%cwd -I%S " %cfg_path --cl-device=%cl_device 2>&1
