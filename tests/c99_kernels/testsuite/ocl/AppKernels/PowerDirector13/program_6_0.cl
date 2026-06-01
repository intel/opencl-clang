__constant sampler_t imageSampler = CLK_NORMALIZED_COORDS_FALSE | CLK_ADDRESS_CLAMP | CLK_FILTER_NEAREST;
__constant sampler_t imageSamplerTemp = CLK_NORMALIZED_COORDS_FALSE | CLK_ADDRESS_CLAMP_TO_EDGE | CLK_FILTER_NEAREST;


__kernel void Bloom_HighPass(__read_only image2d_t src, __write_only image2d_t dst, int width, int height)
{
	int2 coord = (int2)(get_global_id(0), get_global_id(1));
	uint4 tempSrc = read_imageui(src, imageSampler, coord);
	int4 tempResult;
	float4 tempColor;

	//B
	tempColor.x = (float)tempSrc.x / 255.0f;
	tempColor.x *= 0.18f / (0.08f + 0.001f);
	tempColor.x *= (1.0f + (tempColor.x / 0.8f / 0.8f));

	tempColor.x -= 5.0f;
	tempColor.x = max( tempColor.x, 0.0f );
	tempColor.x /= ( 10.0f + tempColor.x );

	//G
	tempColor.y = (float)tempSrc.y / 255.0f;
	tempColor.y *= 0.18f / (0.08f + 0.001f);
	tempColor.y *= (1.0f + (tempColor.y / 0.8f / 0.8f));

	tempColor.y -= 5.0f;
	tempColor.y = max( tempColor.y, 0.0f );
	tempColor.y /= ( 10.0f + tempColor.y );

	//R
	tempColor.z = (float)tempSrc.z / 255.0f;
	tempColor.z *= 0.18f / (0.08f + 0.001f);
	tempColor.z *= (1.0f + (tempColor.z / 0.8f / 0.8f));

	tempColor.z -= 5.0f;
	tempColor.z = max( tempColor.z, 0.0f );
	tempColor.z /= ( 10.0f + tempColor.z );

	tempResult.x = (int)(tempColor.x * 255.0f);
	tempResult.y = (int)(tempColor.y * 255.0f);
	tempResult.z = (int)(tempColor.z * 255.0f);

	tempSrc = convert_uint4(tempResult);

	if( get_global_id(0) < width && get_global_id(1) < height )
		write_imageui(dst, coord, tempSrc);
}

/*
__kernel void Bloom_Kernel_Original(__read_only image2d_t src, __write_only image2d_t dst, __read_only image2d_t Temp, __constant int* Table, __constant float* Weight, int width, int height, int kernelNumber, int lightNumber, int scaleRatio)
{
	int2 coord;
	uint4 tempSrc;

	int ty = get_global_id(1);
	int tx = get_global_id(0);

	// bloom
	int4 sumOfKernel = {0, 0, 0, 0};

	uint Reciprocal = 65536 / kernelNumber;

	int ki = 0;

	for(int li = 0; li < lightNumber; ++li)
	{
		for(int di = 0; di < kernelNumber; ++di)
		{
			int2 kernelOffset;
			kernelOffset.x = Table[ki];
			kernelOffset.y = Table[ki+1];

			// 為了模擬CPU版本處理時有先將原圖縮小再放大,故offset也要照比例放大
			int kernelX = tx + kernelOffset.x;
			int kernelY = ty + kernelOffset.y;

			if(kernelX < 0)
				kernelX = 0;
			else if(kernelX >= width)
				kernelX = width - 1;
			if(kernelY < 0)
				kernelY = 0;
			else if(kernelY >= height)
				kernelY = height - 1;

			coord = (int2)(kernelX, kernelY);
			tempSrc = read_imageui(Temp, imageSamplerTemp, coord);

			float weighting = Weight[di];

			//remove if branch divergence to improve performance
			//if(tempSrc.x)
				sumOfKernel.x += (int)(tempSrc.x * weighting);
			//if(tempSrc.y)
				sumOfKernel.y += (int)(tempSrc.y * weighting);
			//if(tempSrc.z)
				sumOfKernel.z += (int)(tempSrc.z * weighting);
			ki += 2;
		}
	}

	coord = (int2)(get_global_id(0), get_global_id(1));
	uint4 TempPixel = read_imageui(Temp, imageSamplerTemp, coord);

	uint4 tempDest = {0, 0, 0, 0};
//	tempDest.x = (int)TempPixel.x + ((sumOfKernel.x * Reciprocal) >> 16);
//	tempDest.y = (int)TempPixel.y + ((sumOfKernel.y * Reciprocal) >> 16);
//	tempDest.z = (int)TempPixel.z + ((sumOfKernel.z * Reciprocal) >> 16);
	tempDest.x = ((sumOfKernel.x * Reciprocal) >> 16);
	tempDest.y = ((sumOfKernel.y * Reciprocal) >> 16);
	tempDest.z = ((sumOfKernel.z * Reciprocal) >> 16);

	// merge
	coord = (int2)(get_global_id(0), get_global_id(1));
	tempSrc = read_imageui(src, imageSampler, coord);

	tempSrc.x = min((int)tempSrc.x + (int)tempDest.x, 255);
	tempSrc.y = min((int)tempSrc.y + (int)tempDest.y, 255);
	tempSrc.z = min((int)tempSrc.z + (int)tempDest.z, 255);
	tempSrc.w = 255;

	coord = (int2)(get_global_id(0), get_global_id(1));
	write_imageui(dst, coord, tempSrc);
}
*/

__kernel void Bloom_Kernel(__read_only image2d_t src, __global uchar4 * dst, __read_only image2d_t Temp,
							__constant int* Table, __constant float* Weight, __local int* slmTable, __local float* slmWeight,
							int width, int height, int kernelNumber, int lightNumber, int scaleRatio  )
{
	int	lidX = get_local_id(0);
	int	lidY = get_local_id(1);
	int	sizeX = get_local_size(0);
	int	sizeY = get_local_size(1);

	int	tabSize = kernelNumber * lightNumber * 2;
	int	startID = lidX + sizeX * lidY;
	int	stepSize = sizeX * sizeY;

	for( int j = startID; j < tabSize; j += stepSize )
		slmTable[j] = Table[j];

	for( int j = startID; j < kernelNumber; j += stepSize )
		slmWeight[j] = Weight[j];


	barrier( CLK_LOCAL_MEM_FENCE );


	int2 coord;
	uint4 tempSrc;

	int ty = get_global_id(1);
	int tx = get_global_id(0);

	if( tx < width && ty < height )
	{
		// bloom
		int4 sumOfKernel = {0, 0, 0, 0};

		uint Reciprocal = 65536 / kernelNumber;// / lightNumber;

		int ki = 0;

		int	baseKi = 0;
		int	kernelNum2 = 2* kernelNumber;

		for(int di = 0; di < kernelNumber; ++di)
		{
			ki = baseKi;
			baseKi += 2;
			int4	tempSum = 0;

			for(int li = 0; li < lightNumber; ++li)
			{
				// pull offsets from shared local memory table copy
				int kernelX = tx + slmTable[ki];
				int kernelY = ty + slmTable[ki+1];
				ki += kernelNum2;

				// clamped to edge by samplerTemp - replaces/faster than range checks
				//   but is slower than clamp to border color, which gives visible differences
				coord = (int2)(kernelX, kernelY);
				tempSrc = read_imageui(Temp, imageSamplerTemp, coord);

				tempSum.x += (int)tempSrc.x;
				tempSum.y += (int)tempSrc.y;
				tempSum.z += (int)tempSrc.z;

			}

			float weighting = slmWeight[di];
			sumOfKernel.x += tempSum.x * weighting;
			sumOfKernel.y += tempSum.y * weighting;
			sumOfKernel.z += tempSum.z * weighting;
		}

		/////coord = (int2)(get_global_id(0), get_global_id(1));
		/////uint4 TempPixel = read_imageui(Temp, imageSamplerTemp, coord);

		uint4 tempDest;// = {0, 0, 0, 0};
	//	tempDest.x = (int)TempPixel.x + ((sumOfKernel.x * Reciprocal) >> 16);
	//	tempDest.y = (int)TempPixel.y + ((sumOfKernel.y * Reciprocal) >> 16);
	//	tempDest.z = (int)TempPixel.z + ((sumOfKernel.z * Reciprocal) >> 16);
		tempDest.x = ((sumOfKernel.x * Reciprocal) >> 16);
		tempDest.y = ((sumOfKernel.y * Reciprocal) >> 16);
		tempDest.z = ((sumOfKernel.z * Reciprocal) >> 16);

		// merge
		coord = (int2)(get_global_id(0), get_global_id(1));
		tempSrc = read_imageui(src, imageSampler, coord);

		//tempSrc.x = min((int)tempSrc.x + (int)tempDest.x, 255);
		//tempSrc.y = min((int)tempSrc.y + (int)tempDest.y, 255);
		//tempSrc.z = min((int)tempSrc.z + (int)tempDest.z, 255);
		//// write_imageui will saturate to uchar - only need "min" if dest image not uchar...
		tempSrc.x = ((int)tempSrc.x + (int)tempDest.x);
		tempSrc.y = ((int)tempSrc.y + (int)tempDest.y);
		tempSrc.z = ((int)tempSrc.z + (int)tempDest.z);

		int	index = tx + ty * width;
		dst[index] = convert_uchar4_sat( tempSrc );
	}
}

// buildOptions=
// RUN: %occ-cli %s --cl-options="-I%cwd -I%S " %cfg_path --cl-device=%cl_device 2>&1
