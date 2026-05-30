#define LIGHT_LEVEL 250
#define MEDIUM_LEVEL 170
#define DARK_LEVEL  120
#define DIFF_BRUSH_LENGTH 4


__constant sampler_t imageSampler = CLK_NORMALIZED_COORDS_FALSE | CLK_ADDRESS_CLAMP | CLK_FILTER_NEAREST;
__constant sampler_t imageSamplerRemainder = CLK_NORMALIZED_COORDS_FALSE | CLK_ADDRESS_CLAMP | CLK_FILTER_NEAREST;


__kernel void PencilSketch2_AdjustContrast(__read_only image2d_t src, __write_only image2d_t dst, int fxContrast)
{
	int2 coord = (int2)(get_global_id(0), get_global_id(1));

	uint4 tempSrc;
	uint4 tempDst;

	tempSrc = read_imageui(src, imageSampler, coord);

	int4 tempOne = convert_int4(tempSrc);
	int4 tempTwo;

	tempTwo.x = 128 + ((fxContrast * (tempOne.x - 128) + 2048) >> 12);
	tempTwo.y = 128 + ((fxContrast * (tempOne.y - 128) + 2048) >> 12);
	tempTwo.z = 128 + ((fxContrast * (tempOne.z - 128) + 2048) >> 12);

	if (tempTwo.x > 255)
		tempTwo.x = 255;
	if (tempTwo.x < 0)
		tempTwo.x = 0;

	if (tempTwo.y > 255)
		tempTwo.y = 255;
	if (tempTwo.y < 0)
		tempTwo.y = 0;

	if (tempTwo.z > 255)
		tempTwo.z = 255;
	if (tempTwo.z < 0)
		tempTwo.z = 0;

	tempDst = convert_uint4(tempTwo);

	write_imageui(dst, coord, tempDst);
}

__kernel void PencilSketch2_AdjustBrightness(__read_only image2d_t src, __write_only image2d_t dst, int pixelOffset)
{
	int2 coord = (int2)(get_global_id(0), get_global_id(1));

	uint4 tempSrc;
	uint4 tempDst;

	tempSrc = read_imageui(src, imageSampler, coord);

	if(pixelOffset > 0)
	{
		int tempValue = tempSrc.x + pixelOffset;
		tempDst.x = (tempValue > 255) ? 255 : tempValue;

		tempValue = tempSrc.y + pixelOffset;
		tempDst.y = (tempValue > 255) ? 255 : tempValue;

		tempValue = tempSrc.z + pixelOffset;
		tempDst.z = (tempValue > 255) ? 255 : tempValue;
	}
	else if(pixelOffset < 0)
	{
		int tempValue = tempSrc.x + pixelOffset;
		tempDst.x = (tempValue < 0) ? 0 : tempValue;

		tempValue = tempSrc.y + pixelOffset;
		tempDst.y = (tempValue > 255) ? 255 : tempValue;

		tempValue = tempSrc.z + pixelOffset;
		tempDst.z = (tempValue > 255) ? 255 : tempValue;
	}
	else
		tempDst = tempSrc;

	write_imageui(dst, coord, tempDst);
}


__kernel void PencilSketch2_RGBtoGray(__read_only image2d_t src, __write_only image2d_t dst)
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


__kernel void PencilSketch2_GetLayerEdge(__read_only image2d_t src, __write_only image2d_t dst, int width, int height, int edgeThreshold, int pixelValue)
{
	int2 coord = (int2)(get_global_id(0), get_global_id(1));

	uint4 tempSrc;
	uint4 tempDst;

	tempSrc = read_imageui(src, imageSampler, coord);

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
		{
			tempDst.x = pixelValue;
			tempDst.y = pixelValue;
			tempDst.z = pixelValue;
		}
		else
		{
			tempDst.x = 0;
			tempDst.y = 0;
			tempDst.z = 0;
		}
	}
	else
	{
		tempDst.x = 0;
		tempDst.y = 0;
		tempDst.z = 0;
	}

	write_imageui(dst, coord, tempDst);
}

__kernel void PencilSketch2_SubstractLayer(__read_only image2d_t src, __read_only image2d_t Remainder, __write_only image2d_t dst)
{
	int2 coord = (int2)(get_global_id(0), get_global_id(1));

	uint4 tempSrc;
	uint4 tempRemainder;
	uint4 tempDst;

	tempSrc = read_imageui(src, imageSampler, coord);
	tempRemainder = read_imageui(Remainder, imageSamplerRemainder, coord);

	int tempValue = tempSrc.x - tempRemainder.x;
	tempDst.x = (tempValue < 0) ? 0 : tempValue;

	tempValue = tempSrc.y - tempRemainder.y;
	tempDst.y = (tempValue < 0) ? 0 : tempValue;

	tempValue = tempSrc.z - tempRemainder.z;
	tempDst.z = (tempValue < 0) ? 0 : tempValue;

	write_imageui(dst, coord, tempDst);
}

__kernel void PencilSketch2_Level1_Part1(__read_only image2d_t TempBuffer, __global int * RandomTable, __global int * RandomShift, int width, int height)
{
	if((get_global_id(0) >= width) || (get_global_id(1) >= height))
		return;

	int2 coord = (int2)(get_global_id(0), get_global_id(1));
	int nIndex = get_global_id(0) + get_global_id(1) * width;

	uint4 TempValue;
	TempValue = read_imageui(TempBuffer, imageSampler, coord);
	int iIntensity = (int)TempValue.x;

	int nRandomShift = RandomShift[nIndex];

	if(nRandomShift == 256)
	{}
	else
	{
		iIntensity += nRandomShift;

		if(iIntensity > LIGHT_LEVEL)
		{}
		else
		{
			if(iIntensity < 0)
				iIntensity = 0;
			else if(iIntensity > 255)
				iIntensity = 255;

			RandomTable[nIndex] = iIntensity;
		}
	}
}

__kernel void PencilSketch2_Level1_Part2(__read_only image2d_t OriDst, __read_only image2d_t TempBuffer, __write_only image2d_t WriteDst,
					 __read_only image2d_t RandomTableImg2D, int width, int height,
					int nLightBrushLength)
{
	int2 coord = (int2)(get_global_id(0), get_global_id(1));
	int2 TempCoord;
	int nIndex = get_global_id(0) + get_global_id(1) * width;
	int w = get_global_id(0);
	int h = get_global_id(1);

	uint4 TempValue;
	TempValue = read_imageui(OriDst, imageSampler, coord);

	int nFinalValue = (int)TempValue.x;

	int nHalf = nLightBrushLength / 2;
	for(int i = 0; i < nLightBrushLength; i++)
	{
//		int newX = w - OffsetLongLength[i];
//		int newY = h - OffsetLongLength[i];
		int newX = w - (i - nHalf);
		int newY = h - (i - nHalf);

		if( (newX < 0) || (newY < 0) || (newX >= width) || (newY >= height) )
		{}
		else
		{
			TempCoord = (int2)(newX, newY);
			TempValue = read_imageui(TempBuffer, imageSampler, TempCoord);
			int iOriIntensity = (int)TempValue.x;
			if(iOriIntensity <= LIGHT_LEVEL)
			{


				TempValue = read_imageui(RandomTableImg2D, imageSampler, TempCoord);
				int nIntensityValue = (int)TempValue.x;

				if(nIntensityValue == (-1))
				{

				}
				else if(nIntensityValue < nFinalValue)
				{
					nFinalValue = nIntensityValue;
				}
			}
		}

	}

	TempValue.x = (uint)nFinalValue;
	TempValue.y = (uint)nFinalValue;
	TempValue.z = (uint)nFinalValue;
	TempValue.w = 255;

	write_imageui(WriteDst, coord, TempValue);
}

__kernel void PencilSketch2_Level2_Part1(__read_only image2d_t TempBuffer, __global int * RandomTable, __global int * RandomShift, int width, int height)
{
	if((get_global_id(0) >= width) || (get_global_id(1) >= height))
		return;

	int2 coord = (int2)(get_global_id(0), get_global_id(1));
	int nIndex = get_global_id(0) + get_global_id(1) * width;

	uint4 TempValue;
	TempValue = read_imageui(TempBuffer, imageSampler, coord);
	int iIntensity = (int)TempValue.x;

	int nRandomShift = RandomShift[nIndex];

	if(nRandomShift == 256)
	{}
	else
	{
		iIntensity += nRandomShift;

		if(iIntensity < 0)
			iIntensity = 0;
		else if(iIntensity > 255)
			iIntensity = 255;

		if(iIntensity > LIGHT_LEVEL)
		{}
		else if(iIntensity <= MEDIUM_LEVEL)
		{
			RandomTable[nIndex] = iIntensity;
		}

	}
}

__kernel void PencilSketch2_Level2_Part2(__read_only image2d_t OriDst, __read_only image2d_t TempBuffer, __write_only image2d_t WriteDst,
					 __read_only image2d_t RandomTableImg2D, int width, int height,
					int nDarkBrushLength)
{
	int2 coord = (int2)(get_global_id(0), get_global_id(1));
	int2 TempCoord;
	int nIndex = get_global_id(0) + get_global_id(1) * width;
	int w = get_global_id(0);
	int h = get_global_id(1);

	uint4 TempValue;
	TempValue = read_imageui(OriDst, imageSampler, coord);

	int nFinalValue = (int)TempValue.x;

	int nHalf = nDarkBrushLength / 2;
	for(int i = 0; i < nDarkBrushLength; i++)
	{
	//	int newX = w - OffsetShortLength[i];
	//	int newY = h + OffsetShortLength[i];
		int newX = w - (i - nHalf);
		int newY = h + (i - nHalf);

		if( (newX < 0) || (newY < 0) || (newX >= width) || (newY >= height) )
		{}
		else
		{
			TempCoord = (int2)(newX, newY);
			TempValue = read_imageui(TempBuffer, imageSampler, TempCoord);
			int iOriIntensity = (int)TempValue.x;
			if(iOriIntensity <= MEDIUM_LEVEL)
			{


				TempValue = read_imageui(RandomTableImg2D, imageSampler, TempCoord);
				int nIntensityValue = (int)TempValue.x;
				if(nIntensityValue == (-1))
				{

				}
				else if(nIntensityValue < nFinalValue)
				{
					nFinalValue = nIntensityValue;
				}
			}
		}

	}

	TempValue.x = (uint)nFinalValue;
	TempValue.y = (uint)nFinalValue;
	TempValue.z = (uint)nFinalValue;
	TempValue.w = 255;

	write_imageui(WriteDst, coord, TempValue);
}

__kernel void PencilSketch2_Level3_Part1(__read_only image2d_t TempBuffer, __global int * RandomTable, __global int * RandomShift, int width, int height)
{
	if((get_global_id(0) >= width) || (get_global_id(1) >= height))
		return;

	int2 coord = (int2)(get_global_id(0), get_global_id(1));
	int nIndex = get_global_id(0) + get_global_id(1) * width;

	uint4 TempValue;
	TempValue = read_imageui(TempBuffer, imageSampler, coord);
	int iIntensity = (int)TempValue.x;

	int nRandomShift = RandomShift[nIndex];

	if(nRandomShift == 256)
	{}
	else
	{
		iIntensity += nRandomShift;

		if(iIntensity < 0)
			iIntensity = 0;
		else if(iIntensity > 255)
			iIntensity = 255;

		if(iIntensity > MEDIUM_LEVEL)
		{}
		else if(iIntensity <= DARK_LEVEL)
		{
			RandomTable[nIndex] = iIntensity;
		}

	}
}

__kernel void PencilSketch2_Level3_Part2(__read_only image2d_t OriDst, __read_only image2d_t TempBuffer, __write_only image2d_t WriteDst,
					 __read_only image2d_t RandomTableImg2D, int width, int height,
					int nDarkBrushLength)
{
	int2 coord = (int2)(get_global_id(0), get_global_id(1));
	int2 TempCoord;
	int nIndex = get_global_id(0) + get_global_id(1) * width;
	int w = get_global_id(0);
	int h = get_global_id(1);

	uint4 TempValue;
	TempValue = read_imageui(OriDst, imageSampler, coord);

	int nFinalValue = (int)TempValue.x;

	int nHalf = nDarkBrushLength / 2;
	for(int i = 0; i < nDarkBrushLength; i++)
	{
	//	int newX = w - OffsetShortLength[i];
	//	int newY = h + OffsetShortLength[i];
		int newX = w - (i - nHalf);
		int newY = h + (i - nHalf);

		if( (newX < 0) || (newY < 0) || (newX >= width) || (newY >= height) )
		{}
		else
		{
			TempCoord = (int2)(newX, newY);
			TempValue = read_imageui(TempBuffer, imageSampler, TempCoord);
			int iOriIntensity = (int)TempValue.x;
			if(iOriIntensity <= MEDIUM_LEVEL)
			{


				TempValue = read_imageui(RandomTableImg2D, imageSampler, TempCoord);
				int nIntensityValue = (int)TempValue.x;
				if(nIntensityValue == (-1))
				{

				}
				else if(nIntensityValue < nFinalValue)
				{
					nFinalValue = nIntensityValue;
				}
			}
		}

	}

	TempValue.x = (uint)nFinalValue;
	TempValue.y = (uint)nFinalValue;
	TempValue.z = (uint)nFinalValue;
	TempValue.w = 255;

	write_imageui(WriteDst, coord, TempValue);
}

__kernel void PencilSketch2_Level1(__read_only image2d_t src, __read_only image2d_t Remainder, __write_only image2d_t dst, __global int * RandomTable,
														__global int * OffsetLongLength, int width, int height, int nLightBrushLength)
{
	int2 coord = (int2)(get_global_id(0), get_global_id(1));

	if( coord.x%2 != 0 || coord.y%2 != 0 )
		return;

 	int index = ( (coord.y/2 * width/2) + coord.x/2 ) * 4;

	int curX = RandomTable[index];
	index ++;
	int curY = RandomTable[index];
	index ++;

	int2 coordForRemainder = (int2)(curX, curY);

	uint4 tempRemainder;
	tempRemainder = read_imageui(Remainder, imageSamplerRemainder, coordForRemainder);
	int iIntensity = tempRemainder.x;

	if( iIntensity > LIGHT_LEVEL )
		return;

	int iIntensityShift = RandomTable[index];
	index++;

	iIntensity = (RandomTable[index]) ? (iIntensity + iIntensityShift) : (iIntensity - iIntensityShift);
	//index++;

	if(iIntensity < 0)
		iIntensity = 0;
	else if(iIntensity > 255)
		iIntensity = 255;

	int i = 0;
	// draw the stroke pixel by pixel
	for( i = 0 ; i < nLightBrushLength ; i++ )
	{
			// Draw -45 degree stroke for lighter intensity
			int newX = curX + OffsetLongLength[i];
			int newY = curY + OffsetLongLength[i];

			if( (newX < 0) || (newY < 0) || (newX >= width) || (newY >= height) )
				continue;

			coordForRemainder = (int2)(newX, newY);
			tempRemainder = read_imageui(Remainder, imageSamplerRemainder, coordForRemainder);
			int iOriIntensity = tempRemainder.x;

			if( iOriIntensity <= LIGHT_LEVEL )
			{
					uint4 tempSrc;
					uint4 tempDst;
					tempSrc = read_imageui(src, imageSampler, coordForRemainder);
					iOriIntensity = tempSrc.x;

					if(iIntensity < iOriIntensity)
					{
						tempDst.x = iIntensity;
						tempDst.y = iIntensity;
						tempDst.z = iIntensity;
						tempDst.w = 255;
						write_imageui(dst, coordForRemainder, tempDst);
					}
			}
	}
}

__kernel void PencilSketch2_Level2(__read_only image2d_t src, __read_only image2d_t Remainder, __write_only image2d_t dst, __global int * RandomTable,
														__global int * OffsetShortLength, int width, int height, int nDarkBrushLength, int Level1Number)
{
	int2 coord = (int2)(get_global_id(0), get_global_id(1));

	if( coord.x%2 != 0 || coord.y%2 != 0 )
		return;

 	int index = ( (coord.y/2 * width/2) + coord.x/2 ) * 4;

	int curX = RandomTable[index];
	index ++;
	int curY = RandomTable[index];
	index ++;

	int2 coordForRemainder = (int2)(curX, curY);

	uint4 tempRemainder;
	tempRemainder = read_imageui(Remainder, imageSamplerRemainder, coordForRemainder);
	int iIntensity = tempRemainder.x;

	int iIntensityShift = RandomTable[index];
	index++;

	int iSign = RandomTable[index];
	//index++;

	if(!iSign)
		iIntensityShift = 0 - iIntensityShift;

	iIntensity = iIntensity + iIntensityShift;

	if(iIntensity < 0)
		iIntensity = 0;
	else if(iIntensity > 255)
		iIntensity = 255;

	if( iIntensity > LIGHT_LEVEL )
		return;
	else if( iIntensity <= MEDIUM_LEVEL )
	{
			int i = 0;
			for( i = 0 ; i < nDarkBrushLength ; i++ )
			{
					// Draw 45 degree stroke for darker intensity
					int newX = curX + OffsetShortLength[i];
					int newY = curY - OffsetShortLength[i];

					if( (newX < 0) || (newY < 0) || (newX >= width) || (newY >= height) )
					{
					}
					else
					{
							coordForRemainder = (int2)(newX, newY);
							tempRemainder = read_imageui(Remainder, imageSamplerRemainder, coordForRemainder);
							int iOriIntensity = tempRemainder.x;

							if( iOriIntensity <= MEDIUM_LEVEL )
							{
									uint4 tempSrc;
									uint4 tempDst;
									tempSrc = read_imageui(src, imageSampler, coordForRemainder);
									iOriIntensity = tempSrc.x;

									if(iIntensity < iOriIntensity)
									{
										tempDst.x = iIntensity;
										tempDst.y = iIntensity;
										tempDst.z = iIntensity;
										tempDst.w = 255;
										write_imageui(dst, coordForRemainder, tempDst);
									}
							}
					}
			}
	}
}

__kernel void PencilSketch2_Level3(__read_only image2d_t src, __read_only image2d_t Remainder, __write_only image2d_t dst, __global int * RandomTable,
														__global int * OffsetShortLength, int width, int height, int nDarkBrushLength, int Level1and2Number)
{
	int2 coord = (int2)(get_global_id(0), get_global_id(1));

	if( coord.x%4 != 0 || coord.y%4 != 0 )
		return;

	int index = ( (coord.y/4 * width/4) + coord.x/4) * 4;

	int curX = RandomTable[index];
	index ++;
	int curY = RandomTable[index];
	index ++;

	int2 coordForRemainder = (int2)(curX, curY);

	uint4 tempRemainder;
	tempRemainder = read_imageui(Remainder, imageSamplerRemainder, coordForRemainder);
	int iIntensity = tempRemainder.x;

	int iIntensityShift = RandomTable[index];
	index++;

	int iSign = RandomTable[index];
	//index++;

	if(!iSign)
		iIntensityShift = 0 - iIntensityShift;

	iIntensity = iIntensity + iIntensityShift;

	if(iIntensity < 0)
		iIntensity = 0;
	else if(iIntensity > 255)
		iIntensity = 255;

	if( iIntensity > MEDIUM_LEVEL )
		return;
	else if( iIntensity <= DARK_LEVEL )
	{
			int i = nDarkBrushLength;
			int newX = curX + OffsetShortLength[i];
			int newY = curY - OffsetShortLength[i];	// Draw 45 degree stroke for darker intensity

			if( (newX < 0) || (newY < 0) || (newX >= width) || (newY >= height) )
			{
			}
			else
			{
					coordForRemainder = (int2)(newX, newY);
					tempRemainder = read_imageui(Remainder, imageSamplerRemainder, coordForRemainder);
					int iOriIntensity = tempRemainder.x;

					if( iOriIntensity <= MEDIUM_LEVEL )
					{
							uint4 tempSrc;
							uint4 tempDst;
							tempSrc = read_imageui(src, imageSampler, coordForRemainder);
							iOriIntensity = tempSrc.x;

							if(iIntensity < iOriIntensity)
							{
								tempDst.x = iIntensity;
								tempDst.y = iIntensity;
								tempDst.z = iIntensity;
								tempDst.w = 255;
								write_imageui(dst, coordForRemainder, tempDst);
							}
					}
			}
	}
}

__kernel void PencilSketch2_Blend(__read_only image2d_t src, __read_only image2d_t Remainder, __write_only image2d_t dst)
{
	int2 coord = (int2)(get_global_id(0), get_global_id(1));

	uint4 tempSrc;
	uint4 tempRemainder;
	uint4 tempDst;

	tempSrc = read_imageui(src, imageSampler, coord);
	tempRemainder = read_imageui(Remainder, imageSamplerRemainder, coord);

	tempDst.x = (tempSrc.x < tempRemainder.x) ? (tempSrc.x) : (tempRemainder.x);
	tempDst.y = (tempSrc.y < tempRemainder.y) ? (tempSrc.y) : (tempRemainder.y);
	tempDst.z = (tempSrc.z < tempRemainder.z) ? (tempSrc.z) : (tempRemainder.z);
	tempDst.w = 255;

	write_imageui(dst, coord, tempDst);
}



// buildOptions=
// RUN: %occ-cli %s --cl-options="-I%cwd -I%S " %cfg_path --cl-device=%cl_device 2>&1
