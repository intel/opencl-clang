__constant sampler_t imageSampler = CLK_NORMALIZED_COORDS_FALSE | CLK_ADDRESS_CLAMP | CLK_FILTER_NEAREST;
__constant sampler_t imageSampler2 = CLK_NORMALIZED_COORDS_FALSE | CLK_ADDRESS_CLAMP | CLK_FILTER_NEAREST;

__kernel void AdjustLevel_Blend(__read_only image2d_t src1, __read_only image2d_t src2, __write_only image2d_t dst, int outputBlack)
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

__kernel void Sub_Invert(__read_only image2d_t src1, __read_only image2d_t src2, __write_only image2d_t dst)
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

__kernel void RGBtoGray(__read_only image2d_t src, __write_only image2d_t dst)
{

	int2 coord = (int2)(get_global_id(0), get_global_id(1));

	uint4 tempSrc;
	uint4 tempDst;

	tempSrc = read_imageui(src, imageSampler, coord);

	tempDst.x = (( 1053 * (int)tempSrc.z + 2064 * (int)tempSrc.y +  401 * (int)tempSrc.x +  67584 ) >> 12);

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

	tempDst.y = tempDst.x;
	tempDst.z = tempDst.x;

	coord = (int2)(get_global_id(0), get_global_id(1));
	write_imageui(dst, coord, tempDst);
}

__kernel void ChinesePainting(__read_only image2d_t src, __write_only image2d_t dst)
{
	int2 coord = (int2)(get_global_id(0), get_global_id(1));

	uint4 tempSrc;
	uint4 tempDst;

	tempSrc = read_imageui(src, imageSampler, coord);

	tempDst.z = (215 * (int)tempSrc.z) >> 8;
	tempDst.y = (210 * (int)tempSrc.y) >> 8;
	tempDst.x = (204 * (int)tempSrc.x) >> 8;

	if(tempDst.z <= 128)
	{
		tempDst.z = (510 * (int)tempDst.z) >> 8;
	}
	else
	{
		tempDst.z = 255;
	}

	if(tempDst.y <= 128)
	{
		tempDst.y = (510 * (int)tempDst.y) >> 8;
	}
	else
	{
		tempDst.y = 255;
	}

	if(tempDst.x <= 128)
	{
		tempDst.x = (510 * (int)tempDst.x) >> 8;
	}
	else
	{
		tempDst.x = 255;
	}

	write_imageui(dst, coord, tempDst);
}

__kernel void AverageGrayPixel(__read_only image2d_t src,  __global int* MaximumTable, int width, int height, int block_size, int TableSize,
					int ShiftLength)
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


__kernel void AverageFinal(  __global int* MaximumTable, int width, int height,  int TableSize, __global float* Mean )
{

	int nMaximumValue = 0;

	for(int i = 0; i < TableSize; i++)
	{
		nMaximumValue += MaximumTable[i];
	}

	float fMean = (float)nMaximumValue / (float)(width * height);

	Mean[0] = fMean;


}


// buildOptions=
// RUN: %occ-cli %s --cl-options="-I%cwd -I%S " %cfg_path --cl-device=%cl_device 2>&1
