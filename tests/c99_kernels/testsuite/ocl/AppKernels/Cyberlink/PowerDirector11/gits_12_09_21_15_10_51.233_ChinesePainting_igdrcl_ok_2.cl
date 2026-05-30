__constant sampler_t imageSampler = CLK_NORMALIZED_COORDS_FALSE | CLK_ADDRESS_CLAMP | CLK_FILTER_NEAREST;
__constant sampler_t imageSampler2 = CLK_NORMALIZED_COORDS_FALSE | CLK_ADDRESS_CLAMP | CLK_FILTER_NEAREST;

__kernel void ChinesePainting_RGBtoGray(__read_only image2d_t src, __write_only image2d_t dst)
{

	int2 coord = (int2)(get_global_id(0), get_global_id(1));

	uint4 tempSrc;
	uint4 tempDst;

	tempSrc = read_imageui(src, imageSampler, coord);

	tempDst.x = (( 1053 * (int)tempSrc.z + 2064 * (int)tempSrc.y +  401 * (int)tempSrc.x +  67584 ) >> 12);

	write_imageui(dst, coord, tempDst);
}

__kernel void ChinesePainting_GraytoRGB(__read_only image2d_t src, __write_only image2d_t dst, float tangent, __global float* Mean)
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

__kernel void ChinesePainting_Kernel(__read_only image2d_t src, __write_only image2d_t dst)
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

	tempDst.w = 255;
	write_imageui(dst, coord, tempDst);
}

__kernel void ChinesePainting_AverageGrayPixel(__read_only image2d_t src,  __global int* MaximumTable, int width, int height, int block_size, int TableSize, int ShiftLength)
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

/*
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
*/

__kernel void ChinesePainting_SumKernel(__global int* MaximumTable, int TableSize, __global float* Mean, int TotalSize)
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
