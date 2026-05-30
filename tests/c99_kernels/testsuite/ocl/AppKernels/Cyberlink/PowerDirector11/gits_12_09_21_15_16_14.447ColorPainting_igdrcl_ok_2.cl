__constant sampler_t imageSampler = CLK_NORMALIZED_COORDS_FALSE | CLK_ADDRESS_CLAMP | CLK_FILTER_NEAREST;
__constant sampler_t imageSampler2 = CLK_NORMALIZED_COORDS_FALSE | CLK_ADDRESS_CLAMP | CLK_FILTER_NEAREST;


__kernel void ColorPainting_AdjustLevel_Blend(__read_only image2d_t src1, __read_only image2d_t src2, __write_only image2d_t dst, int outputBlack)
{
	int2 coord = (int2)(get_global_id(0), get_global_id(1));

	float inputBlack = 0.0f;
	float inputWhite = 255.0f;
	float outputWhite = 255.0f;
	float	fOBlack = (float)outputBlack;

	uint4 tempSrc;
	uint4 tempDst;
	int4 tempResult;

	tempSrc = read_imageui(src1, imageSampler, coord);
	tempDst = read_imageui(src2, imageSampler2, coord);

	//float4	fDst = convert_float4(tempDst);
	float4	fSrc = convert_float4(tempSrc);

	int4 lookupTable = {0, 0, 0, 0};

	lookupTable.x = ( outputBlack + ( (255 - outputBlack) * (tempDst.x ) / 255 ) );
	lookupTable.y = ( outputBlack + ( (255 - outputBlack) * (tempDst.y ) / 255 ) );
	lookupTable.z = ( outputBlack + ( (255 - outputBlack) * (tempDst.z ) / 255 ) );

	tempDst.x = convert_uint( select(  255.0f - (((255.0f - lookupTable.x) * (255.0f - fSrc.x)) / 128.0f), ((lookupTable.x * fSrc.x) / 128.0f), lookupTable.x <= 128.0f ));
	tempDst.y = convert_uint( select(  255.0f - (((255.0f - lookupTable.y) * (255.0f - fSrc.y)) / 128.0f), ((lookupTable.y * fSrc.y) / 128.0f), lookupTable.y <= 128.0f ));
	tempDst.z = convert_uint( select(  255.0f - (((255.0f - lookupTable.z) * (255.0f - fSrc.z)) / 128.0f), ((lookupTable.z * fSrc.z) / 128.0f), lookupTable.z <= 128.0f ));

	tempDst.w = 255;

	write_imageui(dst, coord, tempDst);
}

__kernel void ColorPainting_Sub_Invert(__read_only image2d_t src1, __read_only image2d_t src2, __write_only image2d_t dst)
{
	int2 coord = (int2)(get_global_id(0), get_global_id(1));

	uint4 tempSrc;
	uint4 tempDst;
	int4 tempResult;

	tempSrc = read_imageui(src1, imageSampler, coord);
	tempDst = read_imageui(src2, imageSampler2, coord);

	tempResult.x = (int)tempSrc.x - (int)tempDst.x;

	if(tempResult.x < 0)
	{
		tempDst.x = 255;
	}
	else
	{
		tempDst.x = 255 - tempResult.x;
	}

	write_imageui(dst, coord, tempDst);
}

__kernel void ColorPainting_RGBtoGray(__read_only image2d_t src, __write_only image2d_t dst)
{
	int2 coord = (int2)(get_global_id(0), get_global_id(1));

	uint4 tempSrc;
	uint4 tempDst;

	tempSrc = read_imageui(src, imageSampler, coord);

	tempDst.x = (( 1053 * (int)tempSrc.z + 2064 * (int)tempSrc.y +  401 * (int)tempSrc.x +  67584 ) >> 12);

	write_imageui(dst, coord, tempDst);
}

__kernel void ColorPainting_AdjustContrast(__read_only image2d_t src, __write_only image2d_t dst, float tangent, __global float* Mean)
{
	int2 coord = (int2)(get_global_id(0), get_global_id(1));

	uint4 tempSrc;
	uint4 tempDst;
	float fMean = Mean[0];

	tempSrc = read_imageui(src, imageSampler, coord);

	float offset = (float)tempSrc.x - fMean;
	float newValue = min(max(fMean + offset * tangent, 0.0f), 255.0f);

	tempDst.x = (uint)newValue;

	tempDst.y = tempDst.x;
	tempDst.z = tempDst.x;

	coord = (int2)(get_global_id(0), get_global_id(1));
	write_imageui(dst, coord, tempDst);
}

__kernel void ColorPainting_AverageGrayPixel(__read_only image2d_t src,  __global int* MaximumTable, int width, int height, int block_size) //, int tableWidth )
{
	int2 coord;// = (int2)(get_global_id(0), get_global_id(1));
	int w = get_global_id(0);
	int h = get_global_id(1);

    if( w < width )
	{
		uint4 tempValue = {0, 0, 0, 0};

		//int nStartX = w * block_size;
		//int nEndX = min((w + 1) * block_size - 1, width - 1);
		int nStartY = h * block_size;
		int nEndY = min((h + 1) * block_size, height);

		int nTotal = 0;

		//for(int x = nStartX; x <= nEndX; x++)
		uint x = w;
		{
			for(uint y = nStartY; y < nEndY; y++)
			{
				coord = (int2)(x, y);
				tempValue = read_imageui(src, imageSampler, coord);
				nTotal += (int)tempValue.x;
			}
		}

		MaximumTable[w + h * width] = nTotal;
	}
}

__kernel void ColorPainting_SumKernel(__global int4* MaximumTable, int TableSize, __global float* Mean, int TotalSize)
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

////////////////////////////////////////////////////////////
// Original
////////////////////////////////////////////////////////////

/*
__kernel void AdjustLevel_Blend_Original(__read_only image2d_t src1, __read_only image2d_t src2, __write_only image2d_t dst, int outputBlack)
{
	int2 coord = (int2)(get_global_id(0), get_global_id(1));

	int inputBlack = 0;
	int inputWhite = 255;
	int outputWhite = 255;

	uint4 tempSrc;
	uint4 tempDst;
	int4 tempResult;

	tempSrc = read_imageui(src1, imageSampler, coord);
	tempDst = read_imageui(src2, imageSampler2, coord);

	int4 lookupTable = {0, 0, 0, 0};

	if((int)tempDst.x <= inputBlack)
	{
		lookupTable.x = outputBlack;
	}
	else if((int)tempDst.x >= inputWhite)
	{
		lookupTable.x = outputWhite;
	}
	else
	{
		lookupTable.x = outputBlack + (outputWhite - outputBlack) * ((int)tempDst.x - inputBlack) / (inputWhite - inputBlack);
	}

	if((int)tempDst.y <= inputBlack)
	{
		lookupTable.y = outputBlack;
	}
	else if((int)tempDst.y >= inputWhite)
	{
		lookupTable.y = outputWhite;
	}
	else
	{
		lookupTable.y = outputBlack + (outputWhite - outputBlack) * ((int)tempDst.y - inputBlack) / (inputWhite - inputBlack);
	}

	if((int)tempDst.z <= inputBlack)
	{
		lookupTable.z = outputBlack;
	}
	else if((int)tempDst.z >= inputWhite)
	{
		lookupTable.z = outputWhite;
	}
	else
	{
		lookupTable.z = outputBlack + (outputWhite - outputBlack) * ((int)tempDst.z - inputBlack) / (inputWhite - inputBlack);
	}

	if(lookupTable.x <= 128)
	{
		tempDst.x = ((lookupTable.x * (int)tempSrc.x) >> 7);
	}
	else
	{
		tempDst.x = 255 - (((255 - lookupTable.x) * (255 - (int)tempSrc.x)) >> 7);
	}

	if(lookupTable.y <= 128)
	{
		tempDst.y = ((lookupTable.y * (int)tempSrc.x) >> 7);
	}
	else
	{
		tempDst.y = 255 - (((255 - lookupTable.y) * (255 - (int)tempSrc.x)) >> 7);
	}

	if(lookupTable.z <= 128)
	{
		tempDst.z = ((lookupTable.z * (int)tempSrc.x) >> 7);
	}
	else
	{
		tempDst.z = 255 - (((255 - lookupTable.z) * (255 - (int)tempSrc.x)) >> 7);
	}

	tempDst.w = 255;

	write_imageui(dst, coord, tempDst);
}

__kernel void AverageGrayPixel_Original(__read_only image2d_t src, __write_only image2d_t dst, __global int* MaximumTable, int width, int height, int block_size, int TableSize,
					__global float* Mean, int ShiftLength)
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
		}
	}

	MaximumTable[w + h * ShiftLength] = nTotal;
}

__kernel void SumKernel_Original(__global int* MaximumTable, int TableSize, __global float* Mean, int TotalSize)
{
	int nMaximumValue = 0;
	for(int i = 0; i < TableSize; i++)
	{
		nMaximumValue += MaximumTable[i];
	}

	float fMean = (float)nMaximumValue / (float)(TotalSize);
	Mean[0] = fMean;
}
*/


// buildOptions=
// RUN: %occ-cli %s --cl-options="-I%cwd -I%S " %cfg_path --cl-device=%cl_device 2>&1
