#define HLSMAX 65532	// H,L, and S vary over 0-HLSMAX.
#define RGBMAX 255	// R,G, and B vary over 0-RGBMAX. HLSMAX BEST if DIVISIBLE BY 6. RGBMAX, HLSMAX must each fit in a byte.
#define HLSMAX_DIV2 32766
#define HLSMAX_DIV3 21844
#define HLSMAX_DIV6 10922
#define HLSMAX_DIV12 5461
#define HLSMAX_DIV3_MUL2 43688
#define RGBMAX_MUL2 510

__constant sampler_t imageSampler = CLK_NORMALIZED_COORDS_FALSE | CLK_ADDRESS_CLAMP | CLK_FILTER_NEAREST;
__constant sampler_t imageSampler2 = CLK_NORMALIZED_COORDS_FALSE | CLK_ADDRESS_CLAMP | CLK_FILTER_NEAREST;


int HueToRGB(int n1, int n2, int h)
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

__kernel void ColorConvert_AdjustLight(__read_only image2d_t src, __write_only image2d_t dst, __constant int* ContrastTable, int width, int height,
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
		tempDstColor.z = ((HueToRGB(Magic1, Magic2, H + HLSMAX_DIV3) * RGBMAX + HLSMAX_DIV2) / HLSMAX);
		tempDstColor.y = ((HueToRGB(Magic1, Magic2, H) * RGBMAX + HLSMAX_DIV2) / HLSMAX);
		tempDstColor.x = ((HueToRGB(Magic1, Magic2, H - HLSMAX_DIV3) * RGBMAX + HLSMAX_DIV2) / HLSMAX);
	}

	tempDst.x = ContrastTable[tempDstColor.x];

	tempDstColor.y = min(tempDstColor.y + 20, 255);
	tempDst.y = ContrastTable[tempDstColor.y];
	tempDst.z = ContrastTable[tempDstColor.z];

	tempDst.w = 255;

	write_imageui(dst, coord, tempDst);

}

__kernel void AdjustContrast(__read_only image2d_t src, __write_only image2d_t dst, float tangent, __global float* Mean)
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

__kernel void AverageRGBPixel(__read_only image2d_t src,  __global int* MaximumTable, int width, int height, int block_size,
			      int tableWidth )
{
	int2 coord = (int2)(get_global_id(0), get_global_id(1));
	int w = get_global_id(0);
	int h = get_global_id(1);

	uint4 tempValue = {0, 0, 0, 0};

	int nStartX = w * block_size;
	int nEndX = min((w + 1) * block_size - 1, width - 1);
	int nStartY = h * block_size;
	int nEndY = min((h + 1) * block_size - 1, height - 1);

	int nTotal = 0;

	for(int x = nStartX; x <= nEndX; x++)
	{
		for(int y = nStartY; y <= nEndY; y++)
		{
			coord = (int2)(x, y);
			tempValue = read_imageui(src, imageSampler, coord);

			nTotal += (int)tempValue.x;
			nTotal += (int)tempValue.y;
			nTotal += (int)tempValue.z;

		}
	}

	MaximumTable[w + h * tableWidth] = nTotal;

}

__kernel void SumKernel(__global int* MaximumTable, int TableSize, __global float* Mean, int TotalSize)
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
