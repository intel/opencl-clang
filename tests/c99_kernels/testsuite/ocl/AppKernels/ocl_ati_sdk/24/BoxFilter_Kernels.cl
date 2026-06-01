/*
 * HorizontalSAT0 - For first horizontal pass for SAT computation
 *                - input : 8 bpp image
 *	          - output : 32 bpp data
 * HorizontalSAT - For rest of the horizontal passes
 * VerticalSAT - All the vertical SAT passes
 * BoxFilter - Reads 4 values from SAT for each pixel and computes average value of the pixel
 */


__kernel void box_filter(__global uint4* inputImage, __global uchar4* outputImage, uint N)
{
	int x = get_global_id(0);
	int y = get_global_id(1);
	int width = get_global_size(0);
	int height = get_global_size(1);
	int k = (N - 1) / 2;

	if(x < k || y < k || x > width - k - 1 || y > height - k - 1)
	{
		outputImage[x + y * width] = (uchar4)(0);
		return;
	}

	/* N should be an odd number */
	int4 filterSize = (int4)(N * N);

	int2 posA = (int2)(x - k, y - k);
	int2 posB = (int2)(x + k, y - k);
	int2 posC = (int2)(x + k, y + k);
	int2 posD = (int2)(x - k, y + k);

	int4 sumA = (int4)(0);
	int4 sumB = (int4)(0);
	int4 sumC = (int4)(0);
	int4 sumD = (int4)(0);

	/* Shift coordinates to get corresponding values from SAT */
	posA.x -= 1;
	posA.y -= 1;
	posB.y -= 1;
	posD.x -= 1;

	if(posA.x >= 0 && posA.y >= 0)
	{
		sumA = convert_int4(inputImage[posA.x + posA.y * width]);
	}
	if(posB.x >= 0 && posB.y >= 0)
	{
		sumB = convert_int4(inputImage[posB.x + posB.y * width]);
	}
	if(posD.x >= 0 && posD.y >= 0)
	{
		sumD = convert_int4(inputImage[posD.x + posD.y * width]);
	}
	sumC = convert_int4(inputImage[posC.x + posC.y * width]);

	outputImage[x + y * width] = convert_uchar4((sumA + sumC - sumB - sumD) / filterSize);

}

__kernel void horizontalSAT0(__global uchar4* input,
							 __global uint4* output,
							 int i, int r, int width)
{
	int x = get_global_id(0);
	int y = get_global_id(1);
	int pos = x + y * width;

	//Do a copy from input to output buffer
	//output[x + y * width] = convert_uint4(input[x + y * width]);
	//barrier(CLK_GLOBAL_MEM_FENCE);

	int c = pow((float)r, (float)i);

	uint4 sum = 0;

	for(int j = 0; j < r; j++)
	{
		if((x - (j * c)) < 0)
		{
			output[pos] = sum;
			return;
		}

		sum += convert_uint4(input[pos - (j * c)]);
	}

	output[pos] = sum;
}

__kernel void horizontalSAT(__global uint4* input,
						    __global uint4* output,
							int i, int r, int width)
{
	int x = get_global_id(0);
	int y = get_global_id(1);
	int pos = x + y * width;

	int c = pow((float)r, (float)i);

	uint4 sum = 0;

	for(int j = 0; j < r; j++)
	{
		if(x - (j * c) < 0)
		{
			output[pos] = sum;
			return;
		}
		sum += input[pos - (j * c)];
	}

	output[pos] = sum;
}


__kernel void verticalSAT(__global uint4* input,
			              __global uint4* output,
			              int i, int r, int width)
{
	int x = get_global_id(0);
	int y = get_global_id(1);

	int c = pow((float)r, (float)i);

	uint4 sum = (uint4)(0);

	for(int j = 0; j < r; j++)
	{
		if(y - (j * c) < 0)
		{
			output[x + y * width] = sum;
			return;
		}

		sum += input[x + width * (y - (j * c))];
	}

	output[x + y * width] = sum;
}


// Separable kernel code.

#define GROUP_SIZE 256

__kernel void box_filter_horizontal(__global uchar4* inputImage, __global uchar4* outputImage, int filterWidth)
{
	int x = get_global_id(0);
    int y = get_global_id(1);

	int width = get_global_size(0);
	int height = get_global_size(1);

	int pos = x + y * width;
	int k = (filterWidth - 1)/2;

	/* Discard pixels in apron */
	if(x < k || x >= (width - k))
	{
		outputImage[pos] = (uchar4)(0);
		return;
	}

	int4 size = (int4)(filterWidth);

	int4 sum = 0;
	/* Read values from (filterWidth x filterWidth) sized kernel */
	for(int X = -k; X < k; X=X+2)
	{
		sum += convert_int4(inputImage[pos + X]);
		sum += convert_int4(inputImage[pos + X + 1]);
	}
	sum += convert_int4(inputImage[pos + k]);
	outputImage[pos] = convert_uchar4(sum / size);
}


__kernel void box_filter_vertical(__global uchar4* inputImage, __global uchar4* outputImage, int filterWidth)
{
	int x = get_global_id(0);
    	int y = get_global_id(1);

	int width = get_global_size(0);
	int height = get_global_size(1);

	int pos = x + y * width;
	int k = (filterWidth - 1)/2;

	/* Discard pixels in apron */
	if(y < k || y >= (height - k))
	{
		outputImage[pos] = (uchar4)(0);
		return;
	}

	int4 size = (int4)(filterWidth);

	int4 sum = 0;
	/* Read values from (filterWidth x filterWidth) sized kernel */
	for(int Y = -k; Y < k; Y=Y+2)
	{
		sum += convert_int4(inputImage[pos + Y * width]);
		sum += convert_int4(inputImage[pos + (Y + 1) * width]);
	}
	sum += convert_int4(inputImage[pos + k * width]);
	outputImage[pos] = convert_uchar4(sum / size);
}

/* This kernel uses local memory for calculation of horizontal filter */
__kernel void box_filter_horizontal_local(__global uchar4* inputImage, __global uchar4* outputImage, int filterWidth, __local uchar4 *lds)
{
	int x = get_global_id(0);
    	int y = get_global_id(1);

	int width = get_global_size(0);
	int height = get_global_size(1);

	int pos = x + y * width;
	int k = (filterWidth - 1)/2;


	int lid = get_local_id(0);
	int gidX = get_group_id(0);
	int gidY = get_group_id(1);

	int gSizeX = get_local_size(0);
	int gSizeY = get_local_size(1);

	int firstElement = gSizeX * gidX + width * gidY * gSizeY;

	/* Load first k and last k into shared memory */
	if(lid < k)
	{
		lds[lid] = inputImage[firstElement - k + lid];
		lds[GROUP_SIZE + k + lid] = inputImage[firstElement + lid + GROUP_SIZE];
	}

	/* Load GROUP_SIZE  values into shared memory */
	lds[lid + k] = inputImage[firstElement + lid];

	barrier(CLK_LOCAL_MEM_FENCE);

	/* Discard pixels in apron */
	if(x < k || x >= (width - k))
		return;

	int4 size = (int4)(filterWidth);

	int4 sum = 0;
	/* Read values from (filterWidth x filterWidth) sized kernel */
	for(int X = -k; X <= k; X++)
	{
		sum += convert_int4(lds[lid + X + k]);
	}
	outputImage[pos] = convert_uchar4(sum / size);
}


// buildOptions=
// RUN: %occ-cli %s --cl-options="-I%cwd -I%S " %cfg_path --cl-device=%cl_device 2>&1
