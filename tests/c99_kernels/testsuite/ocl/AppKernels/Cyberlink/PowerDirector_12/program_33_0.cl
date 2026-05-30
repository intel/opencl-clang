#define HLSMAX 65532	// H,L, and S vary over 0-HLSMAX.
#define RGBMAX 255	// R,G, and B vary over 0-RGBMAX. HLSMAX BEST if DIVISIBLE BY 6. RGBMAX, HLSMAX must each fit in a byte.

#define HLSMAX_DIV2 32766
#define HLSMAX_DIV3 21844
#define HLSMAX_DIV6 10922
#define HLSMAX_DIV12 5461
#define HLSMAX_DIV3_MUL2 43688
#define RGBMAX_MUL2 510

__constant sampler_t imageSampler = CLK_NORMALIZED_COORDS_FALSE | CLK_ADDRESS_CLAMP | CLK_FILTER_NEAREST;
__constant sampler_t imageSamplerRemainder = CLK_NORMALIZED_COORDS_FALSE | CLK_ADDRESS_CLAMP | CLK_FILTER_NEAREST;


__kernel void PencilSketch_Global(__global const uchar4* src, __global uchar4* dst, int width, int height,
unsigned char byBlurDegree, unsigned char byEdgeDegree, unsigned char byEdgeIntensity, int bColor, int bboxRegionTop, int bboxRegionBottom, int bboxRegionRight, int bboxRegionLeft, __global const int4* clRandomTable, unsigned char getAlphaType)
{
	int index = get_global_id(0);

	int j = index / width;
	int i = index % width;

	uchar4 tempSrc = src[index];
	uchar4 tempDst;

	tempDst.x = 0;
	tempDst.y = 255;
	tempDst.z = 255;

	dst[index] = tempDst;
}


#if 0	// ORIGINAL

__kernel void PencilSketch_GetLayerHSL(__read_only image2d_t src, __write_only image2d_t dst)
{
	int2 coord = (int2)(get_global_id(0), get_global_id(1));

	uint4 tempSrc;
	uint4 tempDst;
	int4 tempHSL;

	//tempHSL.z = H
	//tempHSL.y = S
	//tempHSL.x = L

	tempSrc = read_imageui(src, imageSampler, coord);

	int R = tempSrc.z;
	int G = tempSrc.y;
	int B = tempSrc.x;

	int H, S, L;

	// Max and min RGB values.
	int cMax, cMin;

	// Calculate lightness.
	if ( R > G )
	{
		cMax = (R > B) ? R : B;
		cMin = (G < B) ? G : B;
	}
	else
	{
		cMax = (G > B) ? G : B;
		cMin = (R < B) ? R : B;
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
		if (R == cMax)
			H = (( G - B) * HLSMAX_DIV6 + (diff >> 1)) / diff;
		else if (G == cMax)
			H = HLSMAX_DIV3 + (( B - R) * HLSMAX_DIV6 + (diff >> 1) ) / diff;
		else	// B == cMax.
			H = HLSMAX_DIV3_MUL2 + (( R - G) * HLSMAX_DIV6 + (diff >> 1)) / diff;

		if (H < 0)
			H += HLSMAX;
		if (H > HLSMAX)
			H -= HLSMAX;
	}

	tempHSL.z = (H >> 8);
	tempHSL.y = (S >> 8);
	tempHSL.x = (L >> 8);

	tempDst = convert_uint4(tempHSL);

	write_imageui(dst, coord, tempDst);
}

__kernel void PencilSketch_LofHSL_Invert(__read_only image2d_t src, __write_only image2d_t dst)
{
	int2 coord = (int2)(get_global_id(0), get_global_id(1));

	uint4 tempSrc;

	tempSrc = read_imageui(src, imageSampler, coord);

	tempSrc.x = 255 - tempSrc.x;

	write_imageui(dst, coord, tempSrc);
}

#else

__kernel void PencilSketch_GetLayerHSL(__read_only image2d_t src, __write_only image2d_t dst, __write_only image2d_t dstL)
{
	int2 coord = (int2)(get_global_id(0), get_global_id(1));

	uint4 tempSrc;
	uint4 tempDst;
	int4 tempHSL;

	//tempHSL.z = H
	//tempHSL.y = S
	//tempHSL.x = L

	tempSrc = read_imageui(src, imageSampler, coord);

	int R = tempSrc.z;
	int G = tempSrc.y;
	int B = tempSrc.x;

	int H, S, L;

	// Max and min RGB values.
	int cMax, cMin;

	cMax = max( R, max( G, B ));
	cMin = min( R, min( G, B ));

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
		if (R == cMax)
			H = (( G - B) * HLSMAX_DIV6 + (diff >> 1)) / diff;
		else if (G == cMax)
			H = HLSMAX_DIV3 + (( B - R) * HLSMAX_DIV6 + (diff >> 1) ) / diff;
		else	// B == cMax.
			H = HLSMAX_DIV3_MUL2 + (( R - G) * HLSMAX_DIV6 + (diff >> 1)) / diff;

		if (H < 0)
			H += HLSMAX;
		if (H > HLSMAX)
			H -= HLSMAX;
	}

	tempHSL.z = (H >> 8);
	tempHSL.y = (S >> 8);
	tempHSL.x = (L >> 8);

	tempDst = convert_uint4(tempHSL);

	// write out HSL
	write_imageui(dst, coord, tempDst);


//__kernel void PencilSketch_LofHSL_Invert(__read_only image2d_t src, __write_only image2d_t dst)


	tempDst.x = 255 - tempDst.x;

	// write out inverted lightness
	write_imageui(dstL, coord, tempDst);
}


#endif



#if 0		// ORIGINAL

__kernel void PencilSketch_FillChannel_HSofHSL(__read_only image2d_t src, __read_only image2d_t Remainder, __write_only image2d_t dst)
{
	int2 coord = (int2)(get_global_id(0), get_global_id(1));

	uint4 tempSrc;
	uint4 tempRemainder;
	uint4 tempDst;

	tempSrc = read_imageui(src, imageSampler, coord);
	tempRemainder = read_imageui(Remainder, imageSamplerRemainder, coord);

	tempDst.z = tempSrc.z;
	tempDst.y = tempSrc.y;
	tempDst.x = tempRemainder.x;
	tempDst.w = tempSrc.w;

	write_imageui(dst, coord, tempDst);
}

__kernel void PencilSketch_BlendLayerDodge(__read_only image2d_t src, __read_only image2d_t Remainder, __write_only image2d_t dst)
{
	int2 coord = (int2)(get_global_id(0), get_global_id(1));

	uint4 tempSrc;
	uint4 tempRemainder;
	uint4 tempDst;

	tempSrc = read_imageui(src, imageSampler, coord);
	tempRemainder = read_imageui(Remainder, imageSamplerRemainder, coord);

	uint a = tempSrc.x;
	uint b = tempRemainder.x;

	if(b == 255)
		a = 255;
	else
	{
		uint c = (a << 8) / (255 - b);
		if(c > 255)
			a = 255;
		else
			a = c;
	}

	tempDst.x = a;
	tempDst.y = tempRemainder.y;
	tempDst.z = tempRemainder.z;

	write_imageui(dst, coord, tempDst);
}


__kernel void PencilSketch_AdjustBrightness(__read_only image2d_t src, __write_only image2d_t dst, int pixelOffset)
{
	int2 coord = (int2)(get_global_id(0), get_global_id(1));

	uint4 tempSrc;
	uint4 tempDst;

	tempSrc = read_imageui(src, imageSampler, coord);

	if(pixelOffset > 0)
	{
		int tempValue = tempSrc.x + pixelOffset;
		tempDst.x = (tempValue > 255) ? 255 : tempValue;
	}
	else if(pixelOffset < 0)
	{
		int tempValue = tempSrc.x + pixelOffset;
		tempDst.x = (tempValue < 0) ? 0 : tempValue;
	}
	else
		tempDst.x = tempSrc.x;

	tempDst.z = tempSrc.z;
	tempDst.y = tempSrc.y;

	write_imageui(dst, coord, tempDst);
}

#else


__kernel void PencilSketch_FillChannel_HSofHSL(__read_only image2d_t src, __read_only image2d_t Remainder,
													__read_only image2d_t srcHSL, __write_only image2d_t dst, int pixelOffset)
{
	int2 coord = (int2)(get_global_id(0), get_global_id(1));


	// MAYBE SHOULD DO A RANGE CHECK HERE - would need to get image width and height and test...


	uint4 tempSrc;
	uint4 tempRemainder;
	uint4 tempDst;

	tempSrc = read_imageui(src, imageSampler, coord);
	tempRemainder = read_imageui(Remainder, imageSamplerRemainder, coord);

	tempDst.z = tempSrc.z;
	tempDst.y = tempSrc.y;
	tempDst.x = tempRemainder.x;
	tempDst.w = tempSrc.w;



//__kernel void PencilSketch_BlendLayerDodge(__read_only image2d_t src, __read_only image2d_t Remainder, __write_only image2d_t dst)

	// note: HSL was src in orig kernel, "remainder" output from previous kernel
	tempSrc = read_imageui(srcHSL, imageSamplerRemainder, coord);
	tempRemainder = tempDst;	//read_imageui(src, imageSampler, coord);

	uint a = tempSrc.x;
	uint b = tempRemainder.x;

	if(b == 255)
		a = 255;
	else
	{
		uint c = (a << 8) / (255 - b);

		a = min( (uint)255, c );
	}

	tempDst.x = a;




//__kernel void PencilSketch_AdjustBrightness(__read_only image2d_t src, __write_only image2d_t dst, int pixelOffset)

	tempSrc = tempDst;	//read_imageui(src, imageSampler, coord);

	int	tempValue = tempSrc.x + pixelOffset;
	tempDst.x = clamp( tempValue, (int)0, (int)255 );


	// rest of tempDst unmodified
	//tempDst.z = tempSrc.z;
	//tempDst.y = tempSrc.y;

	write_imageui(dst, coord, tempDst);
}

#endif


#if 0		// ORIGINAL

__kernel void PencilSketch_BlendLayerPencilSketch(__read_only image2d_t src, __read_only image2d_t Remainder, __write_only image2d_t dst, int lightnessThreshold)
{
	int2 coord = (int2)(get_global_id(0), get_global_id(1));

	uint4 tempSrc;
	uint4 tempRemainder;
	uint4 tempDst;

	tempSrc = read_imageui(src, imageSampler, coord);
	tempRemainder = read_imageui(Remainder, imageSamplerRemainder, coord);

	int value = tempSrc.x;
	int refValue = tempRemainder.x;

	if(refValue <= lightnessThreshold)
		tempDst.x = ((refValue * (lightnessThreshold - refValue) + value * refValue) / lightnessThreshold);
	else
		tempDst.x = tempSrc.x;

	tempDst.z = tempSrc.z;
	tempDst.y = tempSrc.y;

	write_imageui(dst, coord, tempDst);
}

__kernel void PencilSketch_GetLayerEdge(__read_only image2d_t src, __write_only image2d_t dst, int width, int height, int edgeThreshold, int pixelValue)
{
	int2 coord = (int2)(get_global_id(0), get_global_id(1));

	uint4 tempSrc;
	uint4 tempDst;

	tempSrc = read_imageui(src, imageSampler, coord);

	int X = get_global_id(0);
	int Y = get_global_id(1);
	int2 coordTemp = (int2)(X, Y);

	if(coord.x > 0 && coord.x < (width-1) && coord.y > 0 && coord.y < (height-1))
	{
		uint4 LeftUp, Up, RightUp, Right, RightDown, Down, LeftDown, Left;

		X = get_global_id(0) - 1;
		Y = get_global_id(1) - 1;
		coordTemp = (int2)(X, Y);
		LeftUp = read_imageui(src, imageSampler, coordTemp);

		X = get_global_id(0);
		Y = get_global_id(1) - 1;
		coordTemp = (int2)(X, Y);
		Up = read_imageui(src, imageSampler, coordTemp);

		X = get_global_id(0) + 1;
		Y = get_global_id(1) - 1;
		coordTemp = (int2)(X, Y);
		RightUp = read_imageui(src, imageSampler, coordTemp);

		X = get_global_id(0) + 1;
		Y = get_global_id(1);
		coordTemp = (int2)(X, Y);
		Right = read_imageui(src, imageSampler, coordTemp);

		X = get_global_id(0) + 1;
		Y = get_global_id(1) + 1;
		coordTemp = (int2)(X, Y);
		RightDown = read_imageui(src, imageSampler, coordTemp);

		X = get_global_id(0);
		Y = get_global_id(1) + 1;
		coordTemp = (int2)(X, Y);
		Down = read_imageui(src, imageSampler, coordTemp);

		X = get_global_id(0) - 1;
		Y = get_global_id(1) + 1;
		coordTemp = (int2)(X, Y);
		LeftDown = read_imageui(src, imageSampler, coordTemp);

		X = get_global_id(0) - 1;
		Y = get_global_id(1);
		coordTemp = (int2)(X, Y);
		Left = read_imageui(src, imageSampler, coordTemp);

		int temp1 = LeftUp.x + Up.x + RightUp.x - RightDown.x - Down.x - LeftDown.x;
		int temp2 = LeftUp.x + Left.x + LeftDown.x - RightUp.x - Right.x - RightDown.x;

		if (temp1 * temp1 + temp2 * temp2 > edgeThreshold * 100)
			tempDst.x = pixelValue;
		else
			tempDst.x = 0;

		tempDst.z = tempSrc.z;
		tempDst.y = tempSrc.y;
	}
	else
	{
		tempDst.x = 0;
		tempDst.y = 0;
		tempDst.z = 0;
	}

	write_imageui(dst, coord, tempDst);
}

__kernel void PencilSketch_SubstractLayer(__read_only image2d_t src, __read_only image2d_t Remainder, __write_only image2d_t dst)
{
	int2 coord = (int2)(get_global_id(0), get_global_id(1));

	uint4 tempSrc;
	uint4 tempRemainder;
	uint4 tempDst;

	tempSrc = read_imageui(src, imageSampler, coord);
	tempRemainder = read_imageui(Remainder, imageSamplerRemainder, coord);

	int tempValue = tempSrc.x - tempRemainder.x;
	tempDst.x = (tempValue < 0) ? 0 : tempValue;

	tempDst.z = tempSrc.z;
	tempDst.y = tempSrc.y;

	write_imageui(dst, coord, tempDst);
}

__kernel void PencilSketch_AdjustContrast(__read_only image2d_t src, __write_only image2d_t dst, int fxContrast)
{
	int2 coord = (int2)(get_global_id(0), get_global_id(1));

	uint4 tempSrc;
	uint4 tempDst;

	tempSrc = read_imageui(src, imageSampler, coord);

	int tempOne = tempSrc.x;

	int tempTwo = 128 + ((fxContrast * (tempOne - 128) + 2048) >> 12);

	if (tempTwo > 255)
		tempTwo = 255;
	else if (tempTwo < 0)
		tempTwo = 0;

	tempDst.x = tempTwo;

	tempDst.z = tempSrc.z;
	tempDst.y = tempSrc.y;

	write_imageui(dst, coord, tempDst);
}

__kernel void PencilSketch_AddRandomTextureValue(__read_only image2d_t src, __write_only image2d_t dst, __constant unsigned char* RandomTable, int width, int height)
{
	int2 coord = (int2)(get_global_id(0), get_global_id(1));

	uint4 tempSrc;
	uint4 tempDst;

	tempSrc = read_imageui(src, imageSampler, coord);

	int position = coord.x + coord.y;
	int nIntensity = tempSrc.x + RandomTable[position];

	int position2 = coord.y - coord.x + width;
	nIntensity = nIntensity + RandomTable[position2];

	if ( nIntensity > 255 )
		nIntensity = 255;

	tempDst.x = nIntensity;

	tempDst.y = tempSrc.y;
	tempDst.z = tempSrc.z;

 	write_imageui(dst, coord, tempDst);
}

__kernel void PencilSketch_LoadLayerHSL(__read_only image2d_t src, __write_only image2d_t dst)
{
	int2 coord = (int2)(get_global_id(0), get_global_id(1));

	uint4 tempSrc;
	uint4 tempDst;

	tempSrc = read_imageui(src, imageSampler, coord);

	uint L = tempSrc.x << 8;
	uint S = tempSrc.y << 8;
	uint H = tempSrc.z << 8;
	uint R, G, B;

	int Magic1, Magic2;	// Calculated magic numbers (really!).

	if(S == 0)	// Achromatic case.
	{
		R = G = B = (L * RGBMAX / HLSMAX);
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
		int n1, n2, h, returnValue;

		// R part
		n1 = Magic1;
		n2 = Magic2;
		h = H + HLSMAX_DIV3;

		if (h < 0)
			h += HLSMAX;
		else if (h > HLSMAX)
			h -= HLSMAX;

		if (h < HLSMAX_DIV6)
			returnValue = (n1 + (((n2 - n1) * h + HLSMAX_DIV12) / HLSMAX_DIV6));
		else if (h < HLSMAX_DIV2)
			returnValue = n2;
		else if (h < HLSMAX_DIV3_MUL2)
			returnValue = (n1 + (((n2 - n1) * (HLSMAX_DIV3_MUL2 - h) + HLSMAX_DIV12) / HLSMAX_DIV6));
		else
			returnValue = n1;

		R = (returnValue * RGBMAX + HLSMAX_DIV2) / HLSMAX;


		// G part
		n1 = Magic1;
		n2 = Magic2;
		h = H;

		if (h < 0)
			h += HLSMAX;
		else if (h > HLSMAX)
			h -= HLSMAX;

		if (h < HLSMAX_DIV6)
			returnValue = (n1 + (((n2 - n1) * h + HLSMAX_DIV12) / HLSMAX_DIV6));
		else if (h < HLSMAX_DIV2)
			returnValue = n2;
		else if (h < HLSMAX_DIV3_MUL2)
			returnValue = (n1 + (((n2 - n1) * (HLSMAX_DIV3_MUL2 - h) + HLSMAX_DIV12) / HLSMAX_DIV6));
		else
			returnValue = n1;

		G = (returnValue * RGBMAX + HLSMAX_DIV2) / HLSMAX;


		// B part
		n1 = Magic1;
		n2 = Magic2;
		h = H - HLSMAX_DIV3;

		if (h < 0)
			h += HLSMAX;
		else if (h > HLSMAX)
			h -= HLSMAX;

		if (h < HLSMAX_DIV6)
			returnValue = (n1 + (((n2 - n1) * h + HLSMAX_DIV12) / HLSMAX_DIV6));
		else if (h < HLSMAX_DIV2)
			returnValue = n2;
		else if (h < HLSMAX_DIV3_MUL2)
			returnValue = (n1 + (((n2 - n1) * (HLSMAX_DIV3_MUL2 - h) + HLSMAX_DIV12) / HLSMAX_DIV6));
		else
			returnValue = n1;

		B = (returnValue * RGBMAX + HLSMAX_DIV2) / HLSMAX;
	}

	tempDst.z = R;
	tempDst.y = G;
	tempDst.x = B;

	write_imageui(dst, coord, tempDst);
}

__kernel void PencilSketch_BlendLayerPencilSketch4Channels(__read_only image2d_t src, __read_only image2d_t Remainder, __write_only image2d_t dst, int lightnessThreshold)
{
	int2 coord = (int2)(get_global_id(0), get_global_id(1));

	uint4 tempSrc;
	uint4 tempRemainder;
	uint4 tempDst;

	tempSrc = read_imageui(src, imageSampler, coord);
	tempRemainder = read_imageui(Remainder, imageSamplerRemainder, coord);

	int value;
	int refValue = tempRemainder.x;

	if(refValue <= lightnessThreshold)
	{
		value = tempSrc.z;
		tempDst.z = ((refValue * (lightnessThreshold - refValue) + value * refValue) / lightnessThreshold);

		value = tempSrc.y;
		tempDst.y = ((refValue * (lightnessThreshold - refValue) + value * refValue) / lightnessThreshold);

		value = tempSrc.x;
		tempDst.x = ((refValue * (lightnessThreshold - refValue) + value * refValue) / lightnessThreshold);
	}
	else
	{
		tempDst = tempSrc;
	}

	write_imageui(dst, coord, tempDst);
}


#else

__kernel void PencilSketch_BlendLayerPencilSketch(__read_only image2d_t src, __read_only image2d_t srcHSL, __write_only image2d_t dst, int lightnessThreshold)
{
	int2 coord = (int2)(get_global_id(0), get_global_id(1));

	uint4 tempSrc;
	uint4 tempRemainder;
	uint4 tempDst;

	tempDst = read_imageui(src, imageSampler, coord);
	tempRemainder = read_imageui(srcHSL, imageSamplerRemainder, coord);

	int value = tempDst.x;
	int refValue = tempRemainder.x;

	tempDst.x = (refValue <= lightnessThreshold) ? ((refValue * (lightnessThreshold - refValue + value)) / lightnessThreshold) : tempDst.x;

	// for safety, clamp tempDst to char range
	tempDst.x = clamp( tempDst.x, (uint)0, (uint)255 );

	write_imageui(dst, coord, tempDst);
}


__kernel void PencilSketch_GetLayerEdge(__read_only image2d_t src, __read_only image2d_t srcHSL,
													__constant unsigned char* RandomTable, __write_only image2d_t dst,
													int width, int height, int edgeThreshold, int pixelValue,
													int fxContrast, int lightnessThreshold)
{
	int2 coord = (int2)(get_global_id(0), get_global_id(1));

if( get_global_id(0) < width && get_global_id(1) < height )
{

//__kernel void PencilSketch_GetLayerEdge(__read_only image2d_t src,  __read_only image2d_t srcHSL,

	uint4 tempSrc;
	uint4 tempRemainder;
	uint4 tempDst;

	int refValue;

	tempSrc = read_imageui(src, imageSampler, coord);
	tempDst = tempSrc;

	int X;	// = get_global_id(0);
	int Y;	// = get_global_id(1);
	int2 coordTemp;	// = (int2)(X, Y);

	if(coord.x > 0 && coord.x < (width-1) && coord.y > 0 && coord.y < (height-1))
	{
		uint4 LeftUp, Up, RightUp, Right, RightDown, Down, LeftDown, Left;

		X = get_global_id(0) - 1;
		Y = get_global_id(1) - 1;
		coordTemp = (int2)(X, Y);
		LeftUp = read_imageui(src, imageSampler, coordTemp);

		X = get_global_id(0);
//		Y = get_global_id(1) - 1;
		coordTemp = (int2)(X, Y);
		Up = read_imageui(src, imageSampler, coordTemp);

		X = get_global_id(0) + 1;
//		Y = get_global_id(1) - 1;
		coordTemp = (int2)(X, Y);
		RightUp = read_imageui(src, imageSampler, coordTemp);

//		X = get_global_id(0) + 1;
		Y = get_global_id(1);
		coordTemp = (int2)(X, Y);
		Right = read_imageui(src, imageSampler, coordTemp);

//		X = get_global_id(0) + 1;
		Y = get_global_id(1) + 1;
		coordTemp = (int2)(X, Y);
		RightDown = read_imageui(src, imageSampler, coordTemp);

		X = get_global_id(0);
//		Y = get_global_id(1) + 1;
		coordTemp = (int2)(X, Y);
		Down = read_imageui(src, imageSampler, coordTemp);

		X = get_global_id(0) - 1;
//		Y = get_global_id(1) + 1;
		coordTemp = (int2)(X, Y);
		LeftDown = read_imageui(src, imageSampler, coordTemp);

//		X = get_global_id(0) - 1;
		Y = get_global_id(1);
		coordTemp = (int2)(X, Y);
		Left = read_imageui(src, imageSampler, coordTemp);

		int temp1 = -LeftUp.x - Up.x - RightUp.x + RightDown.x + Down.x + LeftDown.x;
		int temp2 = -LeftUp.x - Left.x - LeftDown.x + RightUp.x + Right.x + RightDown.x;

		if (temp1 * temp1 + temp2 * temp2 > edgeThreshold * 100)
			tempDst.x = pixelValue;
		else
			tempDst.x = 0;

		//tempDst.z = tempSrc.z;
		//tempDst.y = tempSrc.y;
	}
	else
	{
		tempDst.x = 0;
		tempDst.y = 0;
		tempDst.z = 0;
	}


//__kernel void PencilSketch_SubstractLayer(__read_only image2d_t src, __read_only image2d_t Remainder, __read_only image2d_t srcHSL, __constant unsigned char* RandomTable, __write_only image2d_t dst, int fxContrast, int width, int height, int lightnessThreshold)

	int tempValue = tempSrc.x - tempDst.x;

	tempDst.x = max( tempValue, 0 );

	//tempDst.z = tempSrc.z;
	//tempDst.y = tempSrc.y;


//__kernel void PencilSketch_AdjustContrast(__read_only image2d_t src, __read_only image2d_t srcHSL, __constant unsigned char* RandomTable, __write_only image2d_t dst, int fxContrast, int width, int height, int lightnessThreshold)

	int tempOne = tempDst.x;

	int tempTwo = 128 + ((fxContrast * (tempOne - 128) + 2048) >> 12);

	tempDst.x = clamp( tempTwo, 0, 255 );


//__kernel void PencilSketch_AddRandomTextureValue(__read_only image2d_t src, __write_only image2d_t dst, __constant unsigned char* RandomTable, int width, int height)

	int position = coord.x + coord.y;
	int nIntensity;
	nIntensity = ( position < width ) ? tempDst.x + RandomTable[position] : tempDst.x + RandomTable[position+1];

	int position2 = width + height + coord.x - coord.y;
	int position3 = 2*width + height + coord.y - coord.x;
	nIntensity = ( coord.x - coord.y >= 0 ) ? nIntensity + RandomTable[position2] : nIntensity + RandomTable[position3];

	if ( nIntensity > 255 )
		nIntensity = 255;

	tempDst.x = nIntensity;


//__kernel void PencilSketch_LoadLayerHSL(__read_only image2d_t src, __write_only image2d_t dst)

	tempSrc = tempDst;		//read_imageui(src, imageSampler, coord);

	uint L = tempSrc.x << 8;
	uint S = tempSrc.y << 8;
	uint H = tempSrc.z << 8;
	uint R, G, B;

	int Magic1, Magic2;	// Calculated magic numbers (really!).

	if(S == 0)	// Achromatic case.
	{
		R = G = B = (L * RGBMAX / HLSMAX);
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
		int n1, n2, h, returnValue;

		// R part
		n1 = Magic1;
		n2 = Magic2;
		h = H + HLSMAX_DIV3;

		if (h < 0)
			h += HLSMAX;
		else if (h > HLSMAX)
			h -= HLSMAX;

		if (h < HLSMAX_DIV6)
			returnValue = (n1 + (((n2 - n1) * h + HLSMAX_DIV12) / HLSMAX_DIV6));
		else if (h < HLSMAX_DIV2)
			returnValue = n2;
		else if (h < HLSMAX_DIV3_MUL2)
			returnValue = (n1 + (((n2 - n1) * (HLSMAX_DIV3_MUL2 - h) + HLSMAX_DIV12) / HLSMAX_DIV6));
		else
			returnValue = n1;

		R = (returnValue * RGBMAX + HLSMAX_DIV2) / HLSMAX;


		// G part
		n1 = Magic1;
		n2 = Magic2;
		h = H;

		if (h < 0)
			h += HLSMAX;
		else if (h > HLSMAX)
			h -= HLSMAX;

		if (h < HLSMAX_DIV6)
			returnValue = (n1 + (((n2 - n1) * h + HLSMAX_DIV12) / HLSMAX_DIV6));
		else if (h < HLSMAX_DIV2)
			returnValue = n2;
		else if (h < HLSMAX_DIV3_MUL2)
			returnValue = (n1 + (((n2 - n1) * (HLSMAX_DIV3_MUL2 - h) + HLSMAX_DIV12) / HLSMAX_DIV6));
		else
			returnValue = n1;

		G = (returnValue * RGBMAX + HLSMAX_DIV2) / HLSMAX;


		// B part
		n1 = Magic1;
		n2 = Magic2;
		h = H - HLSMAX_DIV3;

		if (h < 0)
			h += HLSMAX;
		else if (h > HLSMAX)
			h -= HLSMAX;

		if (h < HLSMAX_DIV6)
			returnValue = (n1 + (((n2 - n1) * h + HLSMAX_DIV12) / HLSMAX_DIV6));
		else if (h < HLSMAX_DIV2)
			returnValue = n2;
		else if (h < HLSMAX_DIV3_MUL2)
			returnValue = (n1 + (((n2 - n1) * (HLSMAX_DIV3_MUL2 - h) + HLSMAX_DIV12) / HLSMAX_DIV6));
		else
			returnValue = n1;

		B = (returnValue * RGBMAX + HLSMAX_DIV2) / HLSMAX;
	}

	tempDst.z = R;
	tempDst.y = G;
	tempDst.x = B;

	tempDst = clamp( tempDst, (uint4)0, (uint4)255 );


//__kernel void PencilSketch_BlendLayerPencilSketch4Channels(__read_only image2d_t src, __read_only image2d_t Remainder, __write_only image2d_t dst, int lightnessThreshold)


	tempSrc = tempDst;	//read_imageui(src, imageSampler, coord);
	tempRemainder = read_imageui(srcHSL, imageSamplerRemainder, coord);

	int value;
	refValue = tempRemainder.x;

	if(refValue <= lightnessThreshold)
	{
		value = tempSrc.z;
		tempDst.z = ((refValue * (lightnessThreshold - refValue) + value * refValue) / lightnessThreshold);

		value = tempSrc.y;
		tempDst.y = ((refValue * (lightnessThreshold - refValue) + value * refValue) / lightnessThreshold);

		value = tempSrc.x;
		tempDst.x = ((refValue * (lightnessThreshold - refValue) + value * refValue) / lightnessThreshold);
	}
	else
	{
		tempDst = tempSrc;
	}

	write_imageui(dst, coord, tempDst);

}
}


#endif

__kernel void PencilSketch_RGBtoGray(__read_only image2d_t src, __write_only image2d_t dst)
{
	int2 coord = (int2)(get_global_id(0), get_global_id(1));

	uint4 tempSrc;
	uint4 tempDst;

	tempSrc = read_imageui(src, imageSampler, coord);

	uint graylevel = (( 1053 * tempSrc.z + 2064 * tempSrc.y +  401 * tempSrc.x +  67584 ) >> 12);

	tempDst.x = tempDst.y = tempDst.z = graylevel;
	tempDst.w = 255;

	write_imageui(dst, coord, tempDst);
}

// buildOptions=
// RUN: %occ-cli %s --cl-options="-I%cwd -I%S " %cfg_path --cl-device=%cl_device 2>&1
