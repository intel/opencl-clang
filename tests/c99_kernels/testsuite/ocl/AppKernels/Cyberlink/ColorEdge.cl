__constant sampler_t imageSampler_Top = CLK_NORMALIZED_COORDS_FALSE | CLK_ADDRESS_CLAMP | CLK_FILTER_NEAREST;
__constant sampler_t imageSampler_Bottom = CLK_NORMALIZED_COORDS_FALSE | CLK_ADDRESS_CLAMP | CLK_FILTER_NEAREST;
__constant sampler_t imageSampler_Left = CLK_NORMALIZED_COORDS_FALSE | CLK_ADDRESS_CLAMP | CLK_FILTER_NEAREST;
__constant sampler_t imageSampler_Right = CLK_NORMALIZED_COORDS_FALSE | CLK_ADDRESS_CLAMP | CLK_FILTER_NEAREST;

__kernel void ColorEdge(__read_only image2d_t src, __write_only image2d_t dst, int width, int height)
{

	int2 coord = (int2)(get_global_id(0), get_global_id(1));
	int w = get_global_id(0);
	int h = get_global_id(1);

	uint4 tempSrc_Top;
	uint4 tempSrc_Bottom;
	uint4 tempSrc_Left;
	uint4 tempSrc_Right;
	uint4 tempDst;

	int der_x;
	int der_y;

	if(w >= 1 && h >= 1 && w < (width-1) && h < (height-1))
	{
		coord = (int2)(w + 1, h);
		tempSrc_Right = read_imageui(src, imageSampler_Right, coord);
		coord = (int2)(w - 1, h);
		tempSrc_Left = read_imageui(src, imageSampler_Left, coord);
		coord = (int2)(w, h + 1);
		tempSrc_Bottom = read_imageui(src, imageSampler_Bottom, coord);
		coord = (int2)(w, h - 1);
		tempSrc_Top = read_imageui(src, imageSampler_Top, coord);

		der_x = tempSrc_Right.x - tempSrc_Left.x;
		der_y = tempSrc_Bottom.x - tempSrc_Top.x;
		tempDst.x = min(255.0f, sqrt((float)(der_x * der_x + der_y * der_y)));

		der_x = tempSrc_Right.y - tempSrc_Left.y;
		der_y = tempSrc_Bottom.y - tempSrc_Top.y;
		tempDst.y = min(255.0f, sqrt((float)(der_x * der_x + der_y * der_y)));

		der_x = tempSrc_Right.z - tempSrc_Left.z;
		der_y = tempSrc_Bottom.z - tempSrc_Top.z;
		tempDst.z = min(255.0f, sqrt((float)(der_x * der_x + der_y * der_y)));

		coord = (int2)(get_global_id(0), get_global_id(1));
		tempDst.w = 255;

		write_imageui(dst, coord, tempDst);
	}
	else
	{
		tempDst.x = 0;
		tempDst.y = 0;
		tempDst.z = 0;
		tempDst.w = 255;
		write_imageui(dst, coord, tempDst);
	}


}


__kernel void MaximumPixel(__read_only image2d_t src, __write_only image2d_t dst, __global uchar4* MaximumTable, int width, int height, int block_size, int TableSize)
{
	int2 coord = (int2)(get_global_id(0), get_global_id(1));
	int w = get_global_id(0);
	int h = get_global_id(1);

	uint4 tempValue = {0, 0, 0, 0};

	int nStartX = w * block_size;
	int nEndX = min((w + 1) * block_size - 1, width - 1);
	int nStartY = h * block_size;
	int nEndY = min((h + 1) * block_size - 1, height - 1);

	int nMaximumValue = 0;
	uchar4 MaximumPixel;


	for(int x = nStartX; x <= nEndX; x++)
	{
		for(int y = nStartY; y <= nEndY; y++)
		{
			coord = (int2)(x, y);
			tempValue = read_imageui(src, imageSampler_Right, coord);

			if(tempValue.x > nMaximumValue)
				nMaximumValue = tempValue.x;
			if(tempValue.y > nMaximumValue)
				nMaximumValue = tempValue.y;
			if(tempValue.z > nMaximumValue)
				nMaximumValue = tempValue.z;

		}
	}

	MaximumPixel.x = nMaximumValue;
	MaximumTable[w + h * width / block_size] = MaximumPixel;

}

__kernel void SumKernel(__global uchar4* MaximumTable, int TableSize, __global float* Mean)
{
	int nMaximumValue = 0;
	for(int i = 0; i < TableSize; i++)
	{
		if(nMaximumValue < MaximumTable[i].x)
		{
			nMaximumValue = MaximumTable[i].x;
		}
	}

	Mean[0] = (float)nMaximumValue;
}

__kernel void Normalize(__read_only image2d_t src, __global float* Mean, __write_only image2d_t dst, int width, int height)
{
	int2 coord = (int2)(get_global_id(0), get_global_id(1));
	int w = get_global_id(0);
	int h = get_global_id(1);

	uint4 tempValue = {0, 0, 0, 0};

	int Ratio = 255 * 65536 / (int)Mean[0];

	coord = (int2)(get_global_id(0), get_global_id(1));
	tempValue = read_imageui(src, imageSampler_Right, coord);

	tempValue.x = (int)tempValue.x * Ratio >> 16;
	tempValue.y = (int)tempValue.y * Ratio >> 16;
	tempValue.z = (int)tempValue.z * Ratio >> 16;

	coord = (int2)(get_global_id(0), get_global_id(1));
	write_imageui(dst, coord, tempValue);
}



// buildOptions=
// RUN: %occ-cli %s --cl-options="-I%cwd -I%S " %cfg_path --cl-device=%cl_device 2>&1
