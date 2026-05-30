__constant sampler_t imageSamplerYUVtoRGB = CLK_NORMALIZED_COORDS_FALSE | CLK_ADDRESS_CLAMP | CLK_FILTER_NEAREST;
__constant sampler_t imageSamplerRGBtoYUV = CLK_NORMALIZED_COORDS_FALSE | CLK_ADDRESS_CLAMP | CLK_FILTER_NEAREST;
__constant sampler_t imageSampler = CLK_NORMALIZED_COORDS_FALSE | CLK_ADDRESS_CLAMP | CLK_FILTER_NEAREST;
__constant sampler_t imageSamplerRemainder = CLK_NORMALIZED_COORDS_FALSE | CLK_ADDRESS_CLAMP | CLK_FILTER_NEAREST;

__kernel void YUVtoRGB(__read_only image2d_t src, __write_only image2d_t dst)
{
	int2 coord = (int2)(get_global_id(0), get_global_id(1));

	uint4 tempSrc_YUV;
	int4 tempSrc;
	int4 tempDst;

	tempSrc_YUV = read_imageui(src, imageSampler, coord);
	tempSrc.z = (int)tempSrc_YUV.z - 16;
	tempSrc.y = (int)tempSrc_YUV.y - 128;
	tempSrc.x = (int)tempSrc_YUV.x - 128;

	tempDst.z = ( 4768 * tempSrc.z             + 6537 * tempSrc.x + 2048 ) >> 12;
	tempDst.y = ( 4768 * tempSrc.z - 1602 * tempSrc.y - 3330 * tempSrc.x + 2048 ) >> 12;
	tempDst.x = ( 4768 * tempSrc.z + 8266 * tempSrc.y             + 2048 ) >> 12;

	tempSrc_YUV.x = max(min(tempDst.x, 255), 0);
	tempSrc_YUV.y = max(min(tempDst.y, 255), 0);
	tempSrc_YUV.z = max(min(tempDst.z, 255), 0);

	write_imageui(dst, coord, tempSrc_YUV);
}

__kernel void RGBtoYUV(__read_only image2d_t src, __write_only image2d_t dst)
{
	int2 coord = (int2)(get_global_id(0), get_global_id(1));

	uint4 tempSrc_YUV;
	int4 tempDst;

	tempSrc_YUV = read_imageui(src, imageSampler, coord);

	tempDst.z = ( 1053 * (int)tempSrc_YUV.z + 2064 * (int)tempSrc_YUV.y +  401 * (int)tempSrc_YUV.x +  67584 ) >> 12;		// 65536 -> 16 x 2^12
	tempDst.y = ( -606 * (int)tempSrc_YUV.z - 1192 * (int)tempSrc_YUV.y + 1798 * (int)tempSrc_YUV.x + 526336 ) >> 12;		// 524288 -> 128 x2^12
	tempDst.x = ( 1798 * (int)tempSrc_YUV.z - 1507 * (int)tempSrc_YUV.y -  291 * (int)tempSrc_YUV.x + 526336 ) >> 12;
	tempDst.w = (int)tempSrc_YUV.w;

	tempSrc_YUV = convert_uint4(tempDst);

	write_imageui(dst, coord, tempSrc_YUV);
}

__kernel void bufferSetColor(__global uchar4* dst, int bColor)
{
	int index = get_global_id(0);

	unsigned char R = bColor & 0x000000ff;
	unsigned char G = (bColor & 0x0000ff00) >> 8;
	unsigned char B = (bColor & 0x00ff0000) >> 16;
	unsigned char A = (bColor & 0xff000000) >> 24;

	uchar4 tempDst;

	tempDst.x = B;
	tempDst.y = G;
	tempDst.z = R;
	tempDst.w = A;

	dst[index] = tempDst;
}

__kernel void bufferSetColorAndSrcAlpha(__global uchar4* dst, __global const uchar4* src, int bColor)
{
	int index = get_global_id(0);

	unsigned char R = bColor & 0x000000ff;
	unsigned char G = (bColor & 0x0000ff00) >> 8;
	unsigned char B = (bColor & 0x00ff0000) >> 16;
	unsigned char A = src[index].w;

	uchar4 tempDst;

	tempDst.x = B;
	tempDst.y = G;
	tempDst.z = R;
	tempDst.w = A;

	dst[index] = tempDst;
}

__kernel void bufferYUVtoRGB(__global const uchar4* src, __global uchar4* dst)
{
	int index = get_global_id(0);

	uint4 tempSrc_YUV;
	int4 tempSrc;
	int4 tempDst;

	tempSrc_YUV = convert_uint4(src[index]);
	tempSrc.z = (int)tempSrc_YUV.z - 16;
	tempSrc.y = (int)tempSrc_YUV.y - 128;
	tempSrc.x = (int)tempSrc_YUV.x - 128;

	tempDst.z = ( 4768 * tempSrc.z +                                6537 * tempSrc.x + 2048 ) >> 12;
	tempDst.y = ( 4768 * tempSrc.z - 1602 * tempSrc.y - 3330 * tempSrc.x + 2048 ) >> 12;
	tempDst.x = ( 4768 * tempSrc.z + 8266 * tempSrc.y                               + 2048 ) >> 12;

	tempSrc_YUV.x = max(min(tempDst.x, 255), 0);
	tempSrc_YUV.y = max(min(tempDst.y, 255), 0);
	tempSrc_YUV.z = max(min(tempDst.z, 255), 0);
	tempSrc_YUV.w = tempSrc.w;

	dst[index] = convert_uchar4(tempSrc_YUV);
}


__kernel void bufferRGBtoYUV(__global const uchar4* src, __global uchar4* dst)
{
	int index = get_global_id(0);

	uint4 tempSrc_YUV;
	int4 tempDst;

	tempSrc_YUV = convert_uint4(src[index]);

	tempDst.z = ( 1053 * (int)tempSrc_YUV.z + 2064 * (int)tempSrc_YUV.y +  401 * (int)tempSrc_YUV.x +  67584 ) >> 12;		// 65536 -> 16 x 2^12
	tempDst.y = ( -606 * (int)tempSrc_YUV.z - 1192 * (int)tempSrc_YUV.y + 1798 * (int)tempSrc_YUV.x + 526336 ) >> 12;	// 524288 -> 128 x2^12
	tempDst.x = ( 1798 * (int)tempSrc_YUV.z - 1507 * (int)tempSrc_YUV.y -  291 * (int)tempSrc_YUV.x + 526336 ) >> 12;
	tempDst.w = (int)tempSrc_YUV.w;

	tempSrc_YUV = convert_uint4(tempDst);

	dst[index] = convert_uchar4(tempSrc_YUV);
}


__kernel void Blur_Horizontal_ARGB(__read_only image2d_t src, __write_only image2d_t dst, __write_only image2d_t Remainder, int width, int height, int blurRadius)
{
	int h = get_global_id(0);
	int index = 0;
	int index_Dst = 0;
	int index_Left = 0;
	int2 coord = {0, 0};

	if(h >= height)
		return;

	int nBound = width < height ? width : height;
	int nRealBlurRadius = blurRadius;
	if((nRealBlurRadius * 2 + 1) > nBound)
		nRealBlurRadius = (nBound - 1) / 2;

	nRealBlurRadius = nRealBlurRadius + 1;

	uint4 SumARGB = {0, 0, 0, 0};
	uint4 tempSrc = {0, 0, 0, 0};
	uint4 tempResult = {0, 0, 0, 0};
	int num = 0;

	index = 0;
	index_Dst = 0;
	index_Left = 0;
	int x = 0;

	for (x = 0; x < nRealBlurRadius; ++x)
	{
		coord = (int2)(index, h);
		tempSrc = read_imageui(src, imageSampler, coord);

		SumARGB.x += tempSrc.x;
		SumARGB.y += tempSrc.y;
		SumARGB.z += tempSrc.z;

		index++;
	}

	num = nRealBlurRadius;
	tempResult.x = SumARGB.x / num;
	tempResult.y = SumARGB.y / num;
	tempResult.z = SumARGB.z / num;

	coord = (int2)(index_Dst, h);
	write_imageui(dst, coord, tempResult);

	tempResult.x = SumARGB.x - tempResult.x * num;
	tempResult.y = SumARGB.y - tempResult.y * num;
	tempResult.z = SumARGB.z - tempResult.z * num;
	tempResult.w = num;

	coord = (int2)(index_Dst, h);
	write_imageui(Remainder, coord, tempResult);

	index_Dst++;

	for(x = 1; x < nRealBlurRadius; ++x)
	{
		coord = (int2)(index, h);
		tempSrc = read_imageui(src, imageSampler, coord);

		SumARGB.x += tempSrc.x;
		SumARGB.y += tempSrc.y;
		SumARGB.z += tempSrc.z;
		index++;
		num += 1;
		tempResult.x = SumARGB.x / num;
		tempResult.y = SumARGB.y / num;
		tempResult.z = SumARGB.z / num;

		coord = (int2)(index_Dst, h);
		write_imageui(dst, coord, tempResult);

		tempResult.x = SumARGB.x - tempResult.x * num;
		tempResult.y = SumARGB.y - tempResult.y * num;
		tempResult.z = SumARGB.z - tempResult.z * num;
		tempResult.w = num;

		coord = (int2)(index_Dst, h);
		write_imageui(Remainder, coord, tempResult);

		index_Dst++;
	}

	for (x = nRealBlurRadius; x < width-blurRadius; ++x)
	{
		coord = (int2)(index, h);
		tempSrc = read_imageui(src, imageSampler, coord);

		SumARGB.x += tempSrc.x;
		SumARGB.y += tempSrc.y;
		SumARGB.z += tempSrc.z;
		index++;

		coord = (int2)(index_Left, h);
		tempSrc = read_imageui(src, imageSampler, coord);

		SumARGB.x -= tempSrc.x;
		SumARGB.y -= tempSrc.y;
		SumARGB.z -= tempSrc.z;
		index_Left++;

		tempResult.x = SumARGB.x / num;
		tempResult.y = SumARGB.y / num;
		tempResult.z = SumARGB.z / num;

		coord = (int2)(index_Dst, h);
		write_imageui(dst, coord, tempResult);

		tempResult.x = SumARGB.x - tempResult.x * num;
		tempResult.y = SumARGB.y - tempResult.y * num;
		tempResult.z = SumARGB.z - tempResult.z * num;
		tempResult.w = num;

		coord = (int2)(index_Dst, h);
		write_imageui(Remainder, coord, tempResult);

		index_Dst++;
	}

	for (x = width - blurRadius; x < width; ++x)
	{
		coord = (int2)(index_Left, h);
		tempSrc = read_imageui(src, imageSampler, coord);

		SumARGB.x -= tempSrc.x;
		SumARGB.y -= tempSrc.y;
		SumARGB.z -= tempSrc.z;
		index_Left++;

		num -= 1;

		tempResult.x = SumARGB.x / num;
		tempResult.y = SumARGB.y / num;
		tempResult.z = SumARGB.z / num;

		coord = (int2)(index_Dst, h);
		write_imageui(dst, coord, tempResult);

		tempResult.x = SumARGB.x - tempResult.x * num;
		tempResult.y = SumARGB.y - tempResult.y * num;
		tempResult.z = SumARGB.z - tempResult.z * num;
		tempResult.w = num;

		coord = (int2)(index_Dst, h);
		write_imageui(Remainder, coord, tempResult);

		index_Dst++;
	}
}

__kernel void Blur_Vertical_ARGB(__read_only image2d_t src, __read_only image2d_t Remainder, __write_only image2d_t dst, int width, int height, int blurRadius)
{
	int w = get_global_id(0);
	int index = 0;
	int index_Dst = 0;
	int index_Top = 0;
	int2 coord = {0, 0};

	if(w >= width)
		return;

	int nBound = width < height ? width : height;
	int nRealBlurRadius = blurRadius;
	if((nRealBlurRadius * 2 + 1) > nBound)
		nRealBlurRadius = (nBound - 1) / 2;

	nRealBlurRadius = nRealBlurRadius + 1;

	uint4 SumARGB = {0, 0, 0, 0};
	uint4 tempSrc = {0, 0, 0, 0};
	uint4 tempResult = {0, 0, 0, 0};
	int num = 0;
	int weighting;

	for (int y = 0; y < nRealBlurRadius; ++y)
	{
		coord = (int2)(w, index);
		tempSrc = read_imageui(src, imageSampler, coord);
		tempResult = read_imageui(Remainder, imageSamplerRemainder, coord);

		SumARGB.x += tempResult.x;
		SumARGB.y += tempResult.y;
		SumARGB.z += tempResult.z;

		SumARGB.x += tempSrc.x * tempResult.w;
		SumARGB.y += tempSrc.y * tempResult.w;
		SumARGB.z += tempSrc.z * tempResult.w;

		index++;
	}

	num = nRealBlurRadius;

	weighting = num * tempResult.w;

	tempResult.x = SumARGB.x / weighting;
	tempResult.y = SumARGB.y / weighting;
	tempResult.z = SumARGB.z / weighting;

	coord = (int2)(w, index_Dst);
	write_imageui(dst, coord, tempResult);
	index_Dst++;

	// top
	for(int x = 1; x < nRealBlurRadius; ++x)
	{
		coord = (int2)(w, index);
		tempSrc = read_imageui(src, imageSampler, coord);
		tempResult = read_imageui(Remainder, imageSamplerRemainder, coord);

		SumARGB.x += tempResult.x;
		SumARGB.y += tempResult.y;
		SumARGB.z += tempResult.z;

		SumARGB.x += tempSrc.x * tempResult.w;
		SumARGB.y += tempSrc.y * tempResult.w;
		SumARGB.z += tempSrc.z * tempResult.w;

		index++;
		num += 1;

		weighting = num * tempResult.w;

		tempResult.x = SumARGB.x / weighting;
		tempResult.y = SumARGB.y / weighting;
		tempResult.z = SumARGB.z / weighting;

		coord = (int2)(w, index_Dst);
		write_imageui(dst, coord, tempResult);
		index_Dst++;
	}

	// middle
	for (int x = nRealBlurRadius; x < height - blurRadius; ++x)
	{
		coord = (int2)(w, index);
		tempSrc = read_imageui(src, imageSampler, coord);
		tempResult = read_imageui(Remainder, imageSamplerRemainder, coord);

		SumARGB.x += tempResult.x;
		SumARGB.y += tempResult.y;
		SumARGB.z += tempResult.z;

		SumARGB.x += tempSrc.x * tempResult.w;
		SumARGB.y += tempSrc.y * tempResult.w;
		SumARGB.z += tempSrc.z * tempResult.w;

		index++;

		coord = (int2)(w, index_Top);
		tempSrc = read_imageui(src, imageSampler, coord);
		tempResult = read_imageui(Remainder, imageSamplerRemainder, coord);

		SumARGB.x -= tempResult.x;
		SumARGB.y -= tempResult.y;
		SumARGB.z -= tempResult.z;

		SumARGB.x -= tempSrc.x * tempResult.w;
		SumARGB.y -= tempSrc.y * tempResult.w;
		SumARGB.z -= tempSrc.z * tempResult.w;

		index_Top++;

		weighting = num * tempResult.w;

		tempResult.x = SumARGB.x / weighting;
		tempResult.y = SumARGB.y / weighting;
		tempResult.z = SumARGB.z / weighting;

		coord = (int2)(w, index_Dst);
		write_imageui(dst, coord, tempResult);
		index_Dst++;
	}

	// bottom
	for (int x = height - nRealBlurRadius; x < height; ++x)
	{
		coord = (int2)(w, index_Top);
		tempSrc = read_imageui(src, imageSampler, coord);
		tempResult = read_imageui(Remainder, imageSamplerRemainder, coord);

		SumARGB.x -= tempResult.x;
		SumARGB.y -= tempResult.y;
		SumARGB.z -= tempResult.z;

		SumARGB.x -= tempSrc.x * tempResult.w;
		SumARGB.y -= tempSrc.y * tempResult.w;
		SumARGB.z -= tempSrc.z * tempResult.w;

		index_Top++;
		num -= 1;

		weighting = num * tempResult.w;

		tempResult.x = SumARGB.x / weighting;
		tempResult.y = SumARGB.y / weighting;
		tempResult.z = SumARGB.z / weighting;

		coord = (int2)(w, index_Dst);
		write_imageui(dst, coord, tempResult);
		index_Dst++;
	}
}

__kernel void BlendRegion_Box_NoInverse(__read_only image2d_t src, __read_only image2d_t back, __write_only image2d_t dst, int width, int height,
int LeftBound, int RightBound, int TopBound, int BottomBound, float Gradient)
{
	int2 coord = (int2)(get_global_id(0), get_global_id(1));

	int w = get_global_id(0);
	int h = get_global_id(1);

	uint4 tempSrc = {0, 0, 0, 0};
	uint4 tempBack = {0, 0, 0, 0};

	if(w >= LeftBound && h >= TopBound && w < RightBound && h < BottomBound)
	{
		int distance = min(min(w-LeftBound, RightBound-1-w), min(h - TopBound, BottomBound-1 -h));

		tempSrc = read_imageui(src, imageSampler, coord);
		tempBack = read_imageui(back, imageSamplerRemainder, coord);

		float sat;

		if (distance < Gradient)
		{
			// the gradient part
			sat = (float)distance / Gradient;
		}
		else
		{
			sat = 1.0f;
		}

		tempSrc.x = (1 - sat) * tempSrc.x + sat * tempBack.x;
		tempSrc.y = (1 - sat) * tempSrc.y + sat * tempBack.y;
		tempSrc.z = (1 - sat) * tempSrc.z + sat * tempBack.z;

		write_imageui(dst, coord, tempSrc);
	}
	else
	{
		tempSrc = read_imageui(src, imageSampler, coord);

		write_imageui(dst, coord, tempSrc);
	}
}

__kernel void BlendRegion_Circle_NoInverse(__read_only image2d_t src, __read_only image2d_t back, __write_only image2d_t dst, int width, int height,
int LeftBound, int RightBound, int TopBound, int BottomBound, float Gradient)
{
	int2 coord = (int2)(get_global_id(0), get_global_id(1));

	int w = get_global_id(0);
	int h = get_global_id(1);

	uint4 tempSrc = {0, 0, 0, 0};
	uint4 tempBack = {0, 0, 0, 0};

	if(w >= LeftBound && h >= TopBound && w < RightBound && h < BottomBound)
	{
		int sqrWidth = ((RightBound - LeftBound)  * (RightBound - LeftBound)) >> 2 ;
		int sqrHeight = ((BottomBound - TopBound) * (BottomBound - TopBound)) >> 2 ;

		int newY = h - (TopBound + ((BottomBound - TopBound) >> 1));
		int newX = w - (LeftBound + ((RightBound - LeftBound) >> 1));

		tempSrc = read_imageui(src, imageSampler, coord);
		tempBack = read_imageui(back, imageSamplerRemainder, coord);

		float t = (float)(newX * newX) / (float)sqrWidth + (float)(newY * newY) / (float)sqrHeight;

		float sat;

		if(t <= 1.0f && t > 1.0f - Gradient)
		{
			// the gradient part
			sat = (1.0 - t) / Gradient;
		}
		else if(t <= 1.0f - Gradient)
		{
			sat = 1.0f;
		}
		else
		{
			sat = 0.0f;
		}

		tempSrc.x = (1.0f - sat) * tempSrc.x + sat * tempBack.x;
		tempSrc.y = (1.0f - sat) * tempSrc.y + sat * tempBack.y;
		tempSrc.z = (1.0f - sat) * tempSrc.z + sat * tempBack.z;

		write_imageui(dst, coord, tempSrc);
	}
	else
	{
		tempSrc = read_imageui(src, imageSampler, coord);
		write_imageui(dst, coord, tempSrc);
	}
}

__kernel void BlendRegion_Box_Inverse(__read_only image2d_t src, __read_only image2d_t back, __write_only image2d_t dst, int width, int height,
int LeftBound, int RightBound, int TopBound, int BottomBound, float Gradient)
{
	int2 coord = (int2)(get_global_id(0), get_global_id(1));

	int w = get_global_id(0);
	int h = get_global_id(1);

	uint4 tempSrc = {0, 0, 0, 0};
	uint4 tempBack = {0, 0, 0, 0};

	if(w >= LeftBound && h >= TopBound && w < RightBound && h < BottomBound)
	{
		int distance = min(min(w-LeftBound, RightBound-1-w), min(h - TopBound, BottomBound-1 -h));

		tempBack = read_imageui(src, imageSampler, coord);
		tempSrc = read_imageui(back, imageSamplerRemainder, coord);

		float sat;

		if (distance < Gradient)
		{
			// the gradient part
			sat = (float)distance / Gradient;
		}
		else
		{
			sat = 1.0f;
		}

		tempSrc.x = (1 - sat) * tempSrc.x + sat * tempBack.x;
		tempSrc.y = (1 - sat) * tempSrc.y + sat * tempBack.y;
		tempSrc.z = (1 - sat) * tempSrc.z + sat * tempBack.z;
		tempSrc.w = tempBack.w;
		write_imageui(dst, coord, tempSrc);
	}
	else
	{
		tempBack = read_imageui(src, imageSampler, coord);
		tempSrc = read_imageui(back, imageSamplerRemainder, coord);
		tempSrc.w = tempBack.w;
		write_imageui(dst, coord, tempSrc);
	}
}

__kernel void BlendRegion_Circle_Inverse(__read_only image2d_t src, __read_only image2d_t back, __write_only image2d_t dst, int width, int height,
int LeftBound, int RightBound, int TopBound, int BottomBound, float Gradient)
{
	int2 coord = (int2)(get_global_id(0), get_global_id(1));

	int w = get_global_id(0);
	int h = get_global_id(1);

	uint4 tempSrc = {0, 0, 0, 0};
	uint4 tempBack = {0, 0, 0, 0};

	if(w >= LeftBound && h >= TopBound && w < RightBound && h < BottomBound)
	{
		int sqrWidth = ((RightBound - LeftBound)  * (RightBound - LeftBound)) >> 2 ;
		int sqrHeight = ((BottomBound - TopBound) * (BottomBound - TopBound)) >> 2 ;

		int newY = h - (TopBound + ((BottomBound - TopBound) >> 1));
		int newX = w - (LeftBound + ((RightBound - LeftBound) >> 1));

		tempBack = read_imageui(src, imageSampler, coord);
		tempSrc = read_imageui(back, imageSamplerRemainder, coord);

		float t = (float)(newX * newX) / (float)sqrWidth + (float)(newY * newY) / (float)sqrHeight;

		float sat;

		if(t <= 1.0f && t > 1.0f - Gradient)
		{
			// the gradient part
			sat = (1.0 - t) / Gradient;
		}
		else if(t <= 1.0f - Gradient)
		{
			sat = 1.0f;
		}
		else
		{
			sat = 0.0f;
		}

		tempSrc.x = (1.0f - sat) * tempSrc.x + sat * tempBack.x;
		tempSrc.y = (1.0f - sat) * tempSrc.y + sat * tempBack.y;
		tempSrc.z = (1.0f - sat) * tempSrc.z + sat * tempBack.z;
		tempSrc.w = tempBack.w;
		write_imageui(dst, coord, tempSrc);
	}
	else
	{
		tempBack = read_imageui(src, imageSampler, coord);
		tempSrc = read_imageui(back, imageSamplerRemainder, coord);
		tempSrc.w = tempBack.w;
		write_imageui(dst, coord, tempSrc);
	}
}

__kernel void Blur_Horizontal_Gray(__read_only image2d_t src, __write_only image2d_t dst, int width, int height, int blurRadius)
{
	int h = get_global_id(0);
	int index = 0;
	int index_Dst = 0;
	int index_Left = 0;
	int2 coord = {0, 0};

	if(h >= height)
		return;

	int nBound = width < height ? width : height;
	int nRealBlurRadius = blurRadius;
	if((nRealBlurRadius * 2 + 1) > nBound)
		nRealBlurRadius = (nBound - 1) / 2;

	nRealBlurRadius = nRealBlurRadius + 1;

	uint SumGray = 0;
	uint4 tempSrc = {0, 0, 0, 0};
	uint4 tempResult = {0, 0, 0, 0};
	int num = 0;

	index = 0;
	index_Dst = 0;
	index_Left = 0;
	int x = 0;

	for (x = 0; x < nRealBlurRadius; ++x)
	{
		coord = (int2)(index, h);
		tempSrc = read_imageui(src, imageSampler, coord);

		SumGray += tempSrc.x;

		index++;
	}

	num = nRealBlurRadius;
	tempResult.x = SumGray / num;
	tempResult.y = SumGray - tempResult.x * num;
	tempResult.w = num;

	coord = (int2)(index_Dst, h);
	write_imageui(dst, coord, tempResult);

	index_Dst++;

	for(x = 1; x < nRealBlurRadius; ++x)
	{
		coord = (int2)(index, h);
		tempSrc = read_imageui(src, imageSampler, coord);

		SumGray += tempSrc.x;

		index++;
		num += 1;
		tempResult.x = SumGray / num;
		tempResult.y = SumGray - tempResult.x * num;
		tempResult.w = num;

		coord = (int2)(index_Dst, h);
		write_imageui(dst, coord, tempResult);

		index_Dst++;
	}

	for (x = nRealBlurRadius; x < width-blurRadius; ++x)
	{
		coord = (int2)(index, h);
		tempSrc = read_imageui(src, imageSampler, coord);

		SumGray += tempSrc.x;
		index++;

		coord = (int2)(index_Left, h);
		tempSrc = read_imageui(src, imageSampler, coord);

		SumGray -= tempSrc.x;
		index_Left++;

		tempResult.x = SumGray / num;
		tempResult.y = SumGray - tempResult.x * num;
		tempResult.w = num;

		coord = (int2)(index_Dst, h);
		write_imageui(dst, coord, tempResult);

		index_Dst++;
	}

	for (x = width - blurRadius; x < width; ++x)
	{
		coord = (int2)(index_Left, h);
		tempSrc = read_imageui(src, imageSampler, coord);

		SumGray -= tempSrc.x;
		index_Left++;

		num -= 1;

		tempResult.x = SumGray / num;
		tempResult.y = SumGray - tempResult.x * num;
		tempResult.w = num;

		coord = (int2)(index_Dst, h);
		write_imageui(dst, coord, tempResult);

		index_Dst++;
	}
}

__kernel void Blur_Vertical_Gray(__read_only image2d_t src, __write_only image2d_t dst, int width, int height, int blurRadius)
{
	int w = get_global_id(0);
	int index = 0;
	int index_Dst = 0;
	int index_Top = 0;
	int2 coord = {0, 0};

	if(w >= width)
		return;

	int nBound = width < height ? width : height;
	int nRealBlurRadius = blurRadius;
	if((nRealBlurRadius * 2 + 1) > nBound)
		nRealBlurRadius = (nBound - 1) / 2;

	nRealBlurRadius = nRealBlurRadius + 1;

	uint SumGray = 0;
	uint4 tempSrc = {0, 0, 0, 0};
	uint4 tempResult = {0, 0, 0, 0};
	int num = 0;
	int weighting;

	for (int y = 0; y < nRealBlurRadius; ++y)
	{
		coord = (int2)(w, index);
		tempSrc = read_imageui(src, imageSampler, coord);

		SumGray += tempSrc.y;
		SumGray += tempSrc.x * tempSrc.w;

		index++;
	}

	num = nRealBlurRadius;

	weighting = num * tempSrc.w;

	tempResult.x = SumGray / weighting;

	coord = (int2)(w, index_Dst);
	write_imageui(dst, coord, tempResult);
	index_Dst++;

	// top
	for(int x = 1; x < nRealBlurRadius; ++x)
	{
		coord = (int2)(w, index);
		tempSrc = read_imageui(src, imageSampler, coord);

		SumGray += tempSrc.y;
		SumGray += tempSrc.x * tempSrc.w;

		index++;
		num += 1;

		weighting = num * tempSrc.w;

		tempResult.x = SumGray / weighting;

		coord = (int2)(w, index_Dst);
		write_imageui(dst, coord, tempResult);
		index_Dst++;
	}

	// middle
	for (int x = nRealBlurRadius; x < height - blurRadius; ++x)
	{
		coord = (int2)(w, index);
		tempSrc = read_imageui(src, imageSampler, coord);

		SumGray += tempSrc.y;
		SumGray += tempSrc.x * tempSrc.w;

		index++;

		coord = (int2)(w, index_Top);
		tempSrc = read_imageui(src, imageSampler, coord);

		SumGray -= tempSrc.y;
		SumGray -= tempSrc.x * tempSrc.w;

		index_Top++;

		weighting = num * tempSrc.w;

		tempResult.x = SumGray / weighting;

		coord = (int2)(w, index_Dst);
		write_imageui(dst, coord, tempResult);
		index_Dst++;
	}

	// bottom
	for (int x = height - nRealBlurRadius; x < height; ++x)
	{
		coord = (int2)(w, index_Top);
		tempSrc = read_imageui(src, imageSampler, coord);

		SumGray -= tempSrc.y;
		SumGray -= tempSrc.x * tempSrc.w;

		index_Top++;
		num -= 1;

		weighting = num * tempSrc.w;

		tempResult.x = SumGray / weighting;

		coord = (int2)(w, index_Dst);
		write_imageui(dst, coord, tempResult);
		index_Dst++;
	}
}

__kernel void DivideSource(__global const uchar4* src, __global uchar4* srcLeft, __global uchar4* srcRight, int width, int height)
{
	int SrcIndex = get_global_id(0);

	int SrcY = SrcIndex / width;
	int SrcX = SrcIndex % width;

	int halfWidth = width / 2;

	int DstY = SrcY;
	int DstX = (SrcX < halfWidth) ? SrcX : (SrcX - halfWidth);
	int DstIndex = DstY * halfWidth + DstX;

	if( SrcX < halfWidth )
		srcLeft[DstIndex] = src[SrcIndex];
	else
		srcRight[DstIndex] = src[SrcIndex];

}

__kernel void CombineDest(__global uchar4* dstLeft, __global uchar4* dstRight, __global uchar4* dst, int width, int height)
{
	int SrcIndex = get_global_id(0);

	int FullWidth = width * 2;

	int SrcY = SrcIndex / width;
	int SrcX = SrcIndex % width;

	int DstIndexLeft = SrcY * FullWidth + SrcX;
	int DstIndexRight = SrcY * FullWidth + SrcX + width;

	dst[DstIndexLeft] = dstLeft[SrcIndex];
	dst[DstIndexRight] = dstRight[SrcIndex];

}

__kernel void Stretch_Nearest_RGB32(__global uchar4* Dst, int DstWidth, int DstHeight, int DstStride,
				    __global uchar4* Src, int SrcWidth, int SrcHeight, int SrcStride,
				    int fxSrcXStep, int fxSrcYStep,
				    int SrcMarginX, int SrcMarginY, int DstMarginX, int DstMarginY)
{
	int w = get_global_id(0);
	int h = get_global_id(1);

	int fxX = w * fxSrcXStep;
	int fxY = h * fxSrcYStep;

	int x = fxX >> 16;
	int y = fxY >> 16;

	int DstIndex = w + DstMarginX + (h + DstMarginY) * DstStride;
	int SrcIndex = x + SrcMarginX + (y + SrcMarginY) * SrcStride;

	Dst[DstIndex] = Src[SrcIndex];

}

__kernel void Stretch_Coverage_RGB32(__global uchar4* Dst, int DstWidth, int DstHeight, int DstStride,
				    __global uchar4* Src, int SrcWidth, int SrcHeight, int SrcStride,
				    int fxSrcXStep, int fxSrcYStep,
				    int SrcMarginX, int SrcMarginY, int DstMarginX, int DstMarginY,
				    int nInnerXStep, int nInnerYStep)
{
	int w = get_global_id(0);
	int h = get_global_id(1);

	int fxX = w * fxSrcXStep;
	int fxY = h * fxSrcYStep;

	int x_shift = 0;
	int y_shift = 0;


	int nSum_R = 0;
	int nSum_G = 0;
	int nSum_B = 0;
	int nSum_A = 0;

	uchar4 tempSrc;

	y_shift = fxY;
	for(int i = 0; i < 4; i++)
	{
		x_shift = fxX;
		for(int j = 0; j < 4; j++)
		{
			int x = x_shift >> 16;
			int y = y_shift >> 16;

			tempSrc = Src[x + SrcMarginX + (y + SrcMarginY) * SrcStride];

			nSum_B += (int)tempSrc.x;
			nSum_G += (int)tempSrc.y;
			nSum_R += (int)tempSrc.z;
			nSum_A += (int)tempSrc.w;

			x_shift += nInnerXStep;
		}

		y_shift += nInnerYStep;
	}

	nSum_R = nSum_R >> 4;
	nSum_G = nSum_G >> 4;
	nSum_B = nSum_B >> 4;
	nSum_A = nSum_A >> 4;

	int DstIndex = w + DstMarginX + (h + DstMarginY) * DstStride;

	tempSrc.x = nSum_B;
	tempSrc.y = nSum_G;
	tempSrc.z = nSum_R;
	tempSrc.w = nSum_A;

	Dst[DstIndex] = tempSrc;

}

__kernel void Stretch_Bilinear_RGB32(__global uchar4* Dst, int DstWidth, int DstHeight, int DstStride,
				     __global uchar4* Src, int SrcWidth, int SrcHeight, int SrcStride,
				     int fxSrcXStep, int fxSrcYStep,
				     int SrcMarginX, int SrcMarginY, int DstMarginX, int DstMarginY)
{
	int w = get_global_id(0);
	int h = get_global_id(1);

	int fxX = w * fxSrcXStep;
	int fxY = h * fxSrcYStep;

	uchar4 Src_Iac;
	uchar4 Src_Ibc;
	uchar4 Src_Iad;
	uchar4 Src_Ibd;

	int x = fxX >> 16;
	int y = fxY >> 16;
	Src_Iac = Src[x + SrcMarginX + (y + SrcMarginY) * SrcStride];


	x = (fxX + 65536) >> 16;
	y = fxY >> 16;

	if(x >= SrcWidth)
		x = SrcWidth - 1;

	Src_Ibc = Src[x + SrcMarginX + (y + SrcMarginY) * SrcStride];

	x = fxX >> 16;
	y = (fxY + 65536) >> 16;

	if(y >= SrcHeight)
		y = SrcHeight - 1;

	Src_Iad = Src[x + SrcMarginX + (y + SrcMarginY) * SrcStride];

	x = (fxX + 65536) >> 16;
	y = (fxY + 65536) >> 16;

	if(x >= SrcWidth)
		x = SrcWidth - 1;

	if(y >= SrcHeight)
		y = SrcHeight - 1;

	Src_Ibd = Src[x + SrcMarginX + (y + SrcMarginY) * SrcStride];

	int Weight_X = fxX & 0x0000FFFF;
	int Weight_Y = fxY & 0x0000FFFF;

	int h1_B = (int)(Src_Iac.x) + (((int)(Src_Ibc.x) - (int)(Src_Iac.x)) * Weight_X >> 16);
 	int h2_B = (int)(Src_Iad.x) + (((int)(Src_Ibd.x) - (int)(Src_Iad.x)) * Weight_X >> 16);

 	int h1_G = (int)(Src_Iac.y) + (((int)(Src_Ibc.y) - (int)(Src_Iac.y)) * Weight_X >> 16);
 	int h2_G = (int)(Src_Iad.y) + (((int)(Src_Ibd.y) - (int)(Src_Iad.y)) * Weight_X >> 16);

 	int h1_R = (int)(Src_Iac.z) + (((int)(Src_Ibc.z) - (int)(Src_Iac.z)) * Weight_X >> 16);
 	int h2_R = (int)(Src_Iad.z) + (((int)(Src_Ibd.z) - (int)(Src_Iad.z)) * Weight_X >> 16);

 	int h1_A = (int)(Src_Iac.w) + (((int)(Src_Ibc.w) - (int)(Src_Iac.w)) * Weight_X >> 16);
 	int h2_A = (int)(Src_Iad.w) + (((int)(Src_Ibd.w) - (int)(Src_Iad.w)) * Weight_X >> 16);

	h1_B = h1_B + ((h2_B - h1_B) * Weight_Y >> 16);
	h1_G = h1_G + ((h2_G - h1_G) * Weight_Y >> 16);
	h1_R = h1_R + ((h2_R - h1_R) * Weight_Y >> 16);
	h1_A = h1_A + ((h2_A - h1_A) * Weight_Y >> 16);

	Src_Iac.x = h1_B;
	Src_Iac.y = h1_G;
	Src_Iac.z = h1_R;
	Src_Iac.w = h1_A;

	int DstIndex = w + DstMarginX + (h + DstMarginY) * DstStride;
	Dst[DstIndex] = Src_Iac;

}

__kernel void Stretch_FillColor_RGB32(__global uchar4* dst, int DstWidth, int DstHeight, int DstStride, int dwColor, int nOffset)
{
	int index = get_global_id(0);

	int w = index % DstWidth;
	int h = index / DstWidth;

	int DstIndex = w + h * DstStride + nOffset;

	uchar B = dwColor & 0x000000ff;
	uchar G = (dwColor & 0x0000ff00) >> 8;
	uchar R = (dwColor & 0x00ff0000) >> 16;
	uchar A = (dwColor & 0xff000000) >> 24;

	uchar4 tempDst;
	tempDst.z = R;
	tempDst.y = G;
	tempDst.x = B;
	tempDst.w = A;

	dst[DstIndex] = tempDst;
}


////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


__kernel  void Blur_Horizontal_ARGB_Buffer( __read_only image2d_t src, __global uint4 * accum, int width, int height, int blurRadius)
{
	size_t	 v = get_global_id(0);

	if( v >= height )
		return;	// avoid reading extra rows due to global size not an exact multiple of local size

	int index;
	int index_Dst;
	int index_Left;

	int2 coord = {0, v};
	int2 coord_left = coord;

	int nRealBlurRadius = blurRadius + 1;

	uint4 sumARGB = {0, 0, 0, 0};
	uint4 tempSrc;
	uint4 tempResult;

	index = 0;
	index_Left = index;
	index_Dst = v * width;

	unsigned int x;

	// sum up 1st radius + 1 pixels to get to first write
	for (x = 0; x < nRealBlurRadius; x++)
	{
		coord = (int2)(index, v);
		index++;
		tempSrc = read_imageui(src, imageSampler, coord);//convert_uint4( src[index] );			// NOTE: CHANGE TO USE VLOAD8 AND DO 2 PIXEL AT A TIME
		//coord.x++;

		sumARGB.x = sumARGB.x + tempSrc.x;
		sumARGB.y = sumARGB.y + tempSrc.y;
		sumARGB.z = sumARGB.z + tempSrc.z;

		//index++;
	}

	accum[index_Dst++] = sumARGB;


	// sum another radius pixels writing sums to get to and write first full width
	for(x = 1; x < nRealBlurRadius; x++)
	{
		coord = (int2)(index, v);
		index++;
		tempSrc = read_imageui(src, imageSampler, coord);//convert_uint4( src[index++] );			// NOTE: CHANGE TO USE VLOAD8 AND DO 2 PIXEL AT A TIME
		//coord.x++;

		sumARGB.x = sumARGB.x + tempSrc.x;
		sumARGB.y = sumARGB.y + tempSrc.y;
		sumARGB.z = sumARGB.z + tempSrc.z;

		accum[index_Dst++] = sumARGB;
	}

	// sum and subtract pixels from 2nd full width to and including last
	for ( ; x <= width-nRealBlurRadius; x++)
	{
		coord = (int2)(index, v);
		index++;
		tempSrc = read_imageui(src, imageSampler, coord);//convert_uint4( src[index++] );			// NOTE: CHANGE TO USE VLOAD8 AND DO 2 PIXEL AT A TIME
		////coord.x++;

		sumARGB.x = sumARGB.x + tempSrc.x;
		sumARGB.y = sumARGB.y + tempSrc.y;
		sumARGB.z = sumARGB.z + tempSrc.z;

		coord_left = (int2)(index_Left, v);
		index_Left++;
		tempSrc = read_imageui(src, imageSampler, coord_left);//convert_uint4( src[index_Left++] );		// NOTE: CHANGE TO USE VLOAD8 AND DO 2 PIXEL AT A TIME
		////coord_left.x++;

		sumARGB.x = sumARGB.x - tempSrc.x;
		sumARGB.y = sumARGB.y - tempSrc.y;
		sumARGB.z = sumARGB.z - tempSrc.z;

		accum[index_Dst++] = sumARGB;
	}

	// subtract pixels for all remaining reduced width blocks
	for ( ; x < width; x++)
	{
		coord_left = (int2)(index_Left, v);
		index_Left++;
		tempSrc = read_imageui(src, imageSampler, coord_left);//convert_uint4( src[index_Left++] );		// NOTE: CHANGE TO USE VLOAD8 AND DO 2 PIXEL AT A TIME
		////coord_left.x++;

		sumARGB.x = sumARGB.x - tempSrc.x;
		sumARGB.y = sumARGB.y - tempSrc.y;
		sumARGB.z = sumARGB.z - tempSrc.z;

		accum[index_Dst++] = sumARGB;
	}
}


__kernel  void Blur_Vertical_ARGB_Buffer(__global uint4 * accum, __write_only image2d_t dst, int width, int height, int blurRadius)
{
	size_t	 h = get_global_id(0);

	if(h >= width)		// limit to actual width
		return;

	int index = h;
	int index_Top = h;
	//int index_Dst = 0;

	int2 coord = {h, 0};

	int nRealBlurRadius = blurRadius + 1;

	uint	divisor;
	uint	mod_div;

	mod_div = (h < nRealBlurRadius) ? (h + nRealBlurRadius) :
									( (h > (width - nRealBlurRadius)) ? (width - (h+1) + nRealBlurRadius) : (2 * nRealBlurRadius - 1)  );

	divisor = nRealBlurRadius * mod_div;

	uint4 sumARGB = {0, 0, 0, 0};
	uint4 tempSrc;
	uint4 tempResult;

	unsigned int	y;

	// Add up radius+1 before write first output
	for (y = 0; y < nRealBlurRadius; y++)
	{
		tempSrc = ( accum[index] );
		sumARGB.x = sumARGB.x + tempSrc.x;
		sumARGB.y = sumARGB.y + tempSrc.y;
		sumARGB.z = sumARGB.z + tempSrc.z;

		index += width;
	}

	tempResult.x = ( sumARGB.x / divisor );
	tempResult.y = ( sumARGB.y / divisor );
	tempResult.z = ( sumARGB.z / divisor );

	//coord = (int2)(h, index_Dst);
	//index_Dst++;
	write_imageui(dst, coord, tempResult);
	coord.y++;

	// Add up another radius rows to get to (and write) first whole block height averages
	for(y = 1; y < nRealBlurRadius; y++)
	{
		tempSrc = ( accum[index] );

		index += width;
		sumARGB.x = sumARGB.x + tempSrc.x;
		sumARGB.y = sumARGB.y + tempSrc.y;
		sumARGB.z = sumARGB.z + tempSrc.z;

		divisor += mod_div;
		//tempResult = ( sumARGB / divisor );
		tempResult.x = ( sumARGB.x / divisor );
		tempResult.y = ( sumARGB.y / divisor );
		tempResult.z = ( sumARGB.z / divisor );

		//coord = (int2)(h, index_Dst);
		//index_Dst ++;
		write_imageui(dst, coord, tempResult);
		coord.y++;
	}

	// Continue adding and now subtracting rows and writing full block height averages, including last full height
	for ( ; y <= height - nRealBlurRadius; y++)
	{
		tempSrc = ( accum[index] );
		index += width;
		sumARGB.x = sumARGB.x + tempSrc.x;
		sumARGB.y = sumARGB.y + tempSrc.y;
		sumARGB.z = sumARGB.z + tempSrc.z;

		tempSrc = ( accum[index_Top] );
		index_Top += width;
		sumARGB.x -= tempSrc.x;
		sumARGB.y -= tempSrc.y;
		sumARGB.z -= tempSrc.z;

		//tempResult = ( sumARGB / divisor );
		tempResult.x = ( sumARGB.x / divisor );
		tempResult.y = ( sumARGB.y / divisor );
		tempResult.z = ( sumARGB.z / divisor );

		//coord = (int2)(h, index_Dst);
		//index_Dst ++;
		write_imageui(dst, coord, tempResult);
		coord.y++;
	}

	// subtract rows for all remaining blocks
	for ( ; y < height; y++)
	{
		tempSrc = ( accum[index_Top] );
		index_Top += width;
		sumARGB.x -= tempSrc.x;
		sumARGB.y -= tempSrc.y;
		sumARGB.z -= tempSrc.z;

		divisor -= mod_div;

		//tempResult = ( sumARGB / divisor );
		tempResult.x = ( sumARGB.x / divisor );
		tempResult.y = ( sumARGB.y / divisor );
		tempResult.z = ( sumARGB.z / divisor );

		//coord = (int2)(h, index_Dst);
		//index_Dst ++;
		write_imageui(dst, coord, tempResult);
		coord.y++;
	}
}

// REQUIRES WIDTH == MULTIPLE OF 16 PIXELS!
__kernel void GrayBlur_Horiz(__global const uint4 * src, __global float4 * dst, int width, int height, int blurRadius)
{
	size_t	 h = get_global_id(0);
	int index = 0;
	int index_Dst = 0;
	int index_Left = 0;
	int2 coord = {0, 0};

	if(h >= height)
		return;

	int	offset = h * width / 4;

	float4	front4;
	float *	pFront = (float *)&front4;
	uint	frontIndex = 4;
	uint	frontOffset = offset;

	float4	back4;
	float *	pBack = (float *)&back4;
	uint	backIndex = 4;
	uint	backOffset = offset;

	float4	dst16;
	float *	pDst = (float *)&dst16;
	uint	dstIndex = 0;
	uint	dstOffset = offset;

	int	nRealBlurRadius = blurRadius;	// bounded on the host


	float SumGray = 0.0f;
	float tempSrc = 0;//{0, 0, 0, 0};
	float tempResult = 0.0f;//{0, 0, 0, 0};
	int num = 0;

	index = h * width;
	index_Dst = h * width;
	index_Left = h * width;
	int x = 0;

	for (x = 0; x < nRealBlurRadius; ++x)
	{
		if( frontIndex == 4 )
		{
			front4 = convert_float4( (src[frontOffset++] & (uint4)0x0ff) );
			frontIndex = 0;
		}

		//SumGray += (float)((src[index]) & 0x0ff);
		SumGray += pFront[frontIndex++];

		index++;
	}

//	num = nRealBlurRadius;

	for(x = 0; x <= nRealBlurRadius; ++x)
	{
		if( frontIndex == 4 )
		{
			front4 = convert_float4( (src[frontOffset++] & (uint4)0x0ff) );
			frontIndex = 0;
		}

		//SumGray += (float)((src[index]) & 0x0ff);
		SumGray += pFront[frontIndex++];
//		index++;
//		num++;

        //dst[index_Dst] = SumGray;// / (float)num;
		//index_Dst++;
		pDst[dstIndex++] = SumGray;
		if( dstIndex == 4 )
		{
			dst[dstOffset++] = dst16;
			dstIndex = 0;
		}
	}

	for ( ; x < width-blurRadius; ++x)
	{
		if( frontIndex == 4 )
		{
			front4 = convert_float4( (src[frontOffset++] & (uint4)0x0ff) );
			frontIndex = 0;
		}

		//SumGray += (float)((src[index]) & 0x0ff);
		//index++;
		SumGray += pFront[frontIndex++];

//		SumGray -= (float)((src[index_Left]) & 0x0ff);
//		index_Left++;
		if( backIndex == 4 )
		{
			back4 = convert_float4( (src[backOffset++] & (uint4)0x0ff) );
			backIndex = 0;
		}

		//SumGray += (float)((src[index]) & 0x0ff);
		SumGray -= pBack[backIndex++];

        //dst[index_Dst] = SumGray;// / (float)num;
		//index_Dst++;
		pDst[dstIndex++] = SumGray;
		if( dstIndex == 4 )
		{
			dst[dstOffset++] = dst16;
			dstIndex = 0;
		}
	}

	for ( ; x < width; ++x)
	{
//		SumGray -= (float)((src[index_Left]) & 0x0ff);
//		index_Left++;
		if( backIndex == 4 )
		{
			back4 = convert_float4( (src[backOffset++] & (uint4)0x0ff) );
			backIndex = 0;
		}

		//SumGray += (float)((src[index]) & 0x0ff);
		SumGray -= pBack[backIndex++];

		//num--;

        //dst[index_Dst] = SumGray;// / (float)num;
		//index_Dst++;
		pDst[dstIndex++] = SumGray;

		if( dstIndex == 4 )
		{
			dst[dstOffset++] = dst16;
			dstIndex = 0;
		}
	}
}


__kernel void GrayBlur_Vert (  __global const float4 * src, __global uint4 * dst,
								int width, int height, int blurRadius )
{
	uint	width4 = width>>2;
    /* Each work-item is doing 4 pixel columns */
	size_t	 w = get_global_id(0);
	if(w >= width4)
		return;

	int blurDiam = 2 * blurRadius + 1;

	float4	hpos =  (float4)(4 * w);
	hpos.y += 1;
	hpos.z += 2;
	hpos.w += 3;

	// if near right edge, clip hpos to actual horiz width summed in horiz pass
	hpos = select( hpos, ((float4)(width - 1) - hpos), (hpos >= (width - blurRadius)) );

	float4	weight = hpos + blurRadius + 1;

	weight = min( weight, (float4)blurDiam );

	float4	divisor =  (float4)blurRadius * weight;	// base weight;

	int index = w;
	int index_Top = w;
	int index_Dst = w;

    float4 SumGray = (float4)(.0f, .0f, .0f, .0f);

	int x = 0;
	for ( ; x < blurRadius; ++x)
	{
		SumGray += src[index];
		index += width4;
	}
	//int num = blurRadius;


	for(x = 0; x <= blurRadius; ++x)
	{
		SumGray += src[index];

		index += width4;

		divisor += weight;

		dst[index_Dst] = min( (convert_uint4( SumGray / divisor )), (uint4)255 );

		index_Dst += width4;
	}

	for ( ; x < height-blurRadius; ++x)
	{
		SumGray += src[index];
		SumGray -= src[index_Top];

		index += width4;
		index_Top += width4;

		dst[index_Dst] = min( (convert_uint4( SumGray / divisor )), (uint4)255 );
		index_Dst += width4;
	}

	for ( ; x < height; ++x)
	{
		SumGray -= src[index_Top];

		index_Top += width4;

		divisor -= weight;

		dst[index_Dst] = min( (convert_uint4( SumGray / divisor )), (uint4)255 );
		index_Dst += width4;
	}
}


//		pre-calculate "blurRadius" before call, so that the blur diameter is less than or equal to the width and height of buffers!
__kernel void Blur_Vert_UCBuffer(__global  uchar4* src, __global  ushort4* accum, int width, int height, int blurRadius)
{
	int	 h = get_global_id(0);

	if(h >= width)		// not needed if default work group size or pad buffer - but may do extra columns
		return;

	int index = h;
	int index_Top = h;
	int index_Dst = h;
	uint4 Sum = 0;
	int nRealBlurRadius = blurRadius;
	nRealBlurRadius = nRealBlurRadius + 1;

	int	y;

	// Add up radius+1 before write first output
	for (y = 0; y < nRealBlurRadius; y++)
	{
		Sum = Sum +   convert_uint4( src[index] );

		index += width;
	}

	accum[index_Dst] = convert_ushort4( Sum );
	index_Dst += width;

	// Add up another radius rows to get to (and write) first whole block height averages
	for(y = 1; y < nRealBlurRadius; y++)
	{
		Sum = Sum +  convert_uint4( src[index] );
		index += width;

		accum[index_Dst] = convert_ushort4( Sum );
		index_Dst += width;
	}

	// Continue adding and now subtracting rows and writing full block height averages, including last full height
	for ( ; y <= height - nRealBlurRadius; y++)
	{
		Sum = Sum +  convert_uint4( src[index] );
		index += width;

		Sum = Sum -  convert_uint4( src[index_Top] );
		index_Top += width;

		accum[index_Dst] = convert_ushort4( Sum );
		index_Dst += width;
	}

	// subtract rows for all remaining blocks
	for ( ; y < height; y++)
	{
		Sum = Sum -  convert_uint4( src[index_Top] );
		index_Top += width;

		accum[index_Dst] = convert_ushort4( Sum );
		index_Dst += width;
	}
}


//		pre-calculate "blurRadius" so that the blur diameter is less than or equal to the width and height of buffers!
__kernel void Blur_Vert_USBuffer(__global  ushort4*  accum, __global  uint*   dst, int width, int height, int blurRadius)
{
	int	 h = get_global_id(0);

	if(h >= width)		// not needed if default work group size or pad buffer - but may do extra columns
		return;

	int index = h;
	int index_Top = h;
	int index_Dst = h;
	int nRealBlurRadius = blurRadius;
	nRealBlurRadius = nRealBlurRadius + 1;

	float	divisor;
	float	mod_div;

	mod_div = (float) ( (h < nRealBlurRadius) ? (h+nRealBlurRadius) :
									( (h > (width - nRealBlurRadius)) ? (width - (h+1) + nRealBlurRadius) : (2 * nRealBlurRadius - 1)  ) );

	divisor = (float) nRealBlurRadius * mod_div;

	float4 Sum = 0;

	int	y;

	// Add up radius+1 before write first output
	for (y = 0; y < nRealBlurRadius; y++)
	{
		Sum = Sum +   convert_float4( accum[index] );

		index += width;
	}

	dst[index_Dst] = as_uint( convert_uchar4_sat( Sum / divisor ) );
	index_Dst += width;

	// Add up another radius rows to get to (and write) first whole block height averages
	for(y = 1; y < nRealBlurRadius; y++)
	{
		Sum = Sum +  convert_float4( accum[index] );
		index += width;

		divisor += mod_div;
		dst[index_Dst] = as_uint( convert_uchar4_sat( Sum / divisor ) );
		index_Dst += width;
	}

	// Continue adding and now subtracting rows and writing full block height averages, including last full height
	for ( ; y <= height - nRealBlurRadius; y++)
	{
		Sum = Sum +  convert_float4( accum[index] );
		index += width;

		Sum = Sum -  convert_float4( accum[index_Top] );
		index_Top += width;

		dst[index_Dst] = as_uint( convert_uchar4_sat( Sum / divisor ) );
		index_Dst += width;
	}

	// subtract rows for all remaining blocks
	for ( ; y < height; y++)
	{
		Sum = Sum -  convert_float4( accum[index_Top] );
		index_Top += width;

		divisor -= mod_div;

		dst[index_Dst] = as_uint( convert_uchar4_sat( Sum / divisor ) );
		index_Dst += width;
	}
}


//		pre-calculate "blurRadius" before call, so that the blur diameter is less than or equal to the width and height of buffers!
__kernel void Blur_Vert_UCBuffer2(__global  uchar4* src, __global  ushort4* accum, int width, int height, int blurRadius)
{
	int	 h = get_global_id(0);

	if(h >= width)		// not needed if default work group size or pad buffer - but may do extra columns
		return;

	int index = h;
	int index_Top = h;
	int index_Dst = h;
	uint4 Sum = 0;
	int nRealBlurRadius = blurRadius;
	nRealBlurRadius = nRealBlurRadius + 1;

	int y;

	// Add up radius+1 before write first output
	for (y = 0; y < nRealBlurRadius; y++)
	{
		Sum = Sum +   convert_uint4( src[index] );

		index += width;
	}

	accum[index_Dst] = convert_ushort4( Sum >> 1 );
	index_Dst += width;

	// Add up another radius rows to get to (and write) first whole block height averages
	for(y = 1; y < nRealBlurRadius; y++)
	{
		Sum = Sum +  convert_uint4( src[index] );
		index += width;

		accum[index_Dst] = convert_ushort4( Sum >> 1 );
		index_Dst += width;
	}

	// Continue adding and now subtracting rows and writing full block height averages, including last full height
	for ( ; y <= height - nRealBlurRadius; y++)
	{
		Sum = Sum +  convert_uint4( src[index] );
		index += width;

		Sum = Sum -  convert_uint4( src[index_Top] );
		index_Top += width;

		accum[index_Dst] = convert_ushort4( Sum >> 1 );
		index_Dst += width;
	}

	// subtract rows for all remaining blocks
	for ( ; y < height; y++)
	{
		Sum = Sum -  convert_uint4( src[index_Top] );
		index_Top += width;

		accum[index_Dst] = convert_ushort4( Sum >> 1 );
		index_Dst += width;
	}
}


//		pre-calculate "blurRadius" so that the blur diameter is less than or equal to the width and height of buffers!
__kernel void Blur_Vert_USBuffer2(__global  ushort4*  accum, __global  uint*   dst, int width, int height, int blurRadius)
{

	int	 h = get_global_id(0);

	if(h >= width)		// not needed if default work group size or pad buffer - but may do extra columns
		return;

	int index = h;
	int index_Top = h;
	int index_Dst = h;
	int nRealBlurRadius = blurRadius;
	nRealBlurRadius = nRealBlurRadius + 1;

	float	divisor;
	float	mod_div;

	mod_div = (float) ( (h < nRealBlurRadius) ? (h+nRealBlurRadius) :
									( (h > (width - nRealBlurRadius)) ? (width - (h+1) + nRealBlurRadius) : (2 * nRealBlurRadius - 1)  ) );

	mod_div /= 2.0f;
	divisor = (float) nRealBlurRadius * mod_div;
	float4 Sum = 0;
	int y;

	// Add up radius+1 before write first output
	for (y = 0; y < nRealBlurRadius; y++)
	{
		Sum = Sum +   convert_float4( accum[index] );
		index += width;
	}

	dst[index_Dst] = as_uint( convert_uchar4_sat( Sum / divisor ) );
	index_Dst += width;

	// Add up another radius rows to get to (and write) first whole block height averages
	for(y = 1; y < nRealBlurRadius; y++)
	{
		Sum = Sum +  convert_float4( accum[index] );
		index += width;

		divisor += mod_div;
		dst[index_Dst] = as_uint( convert_uchar4_sat( Sum / divisor ) );
		index_Dst += width;
	}

	// Continue adding and now subtracting rows and writing full block height averages, including last full height
	for ( ; y <= height - nRealBlurRadius; y++)
	{
		Sum = Sum +  convert_float4( accum[index] );
		index += width;

		Sum = Sum -  convert_float4( accum[index_Top] );
		index_Top += width;

		dst[index_Dst] = as_uint( convert_uchar4_sat( Sum / divisor ) );
		index_Dst += width;
	}

	// subtract rows for all remaining blocks
	for ( ; y < height; y++)
	{
		Sum = Sum -  convert_float4( accum[index_Top] );
		index_Top += width;

		divisor -= mod_div;

		dst[index_Dst] = as_uint( convert_uchar4_sat( Sum / divisor ) );
		index_Dst += width;
	}
}

	// Assume transposing by loading 8x8 block of uints, storing to SLM
__attribute__(( reqd_work_group_size( 16, 16, 1) ))
__kernel	void	Transpose_uc4( __global uint * src,  __global uint * dst,  int width, int height )
{
	__local	uint	tile[16][16];

	int	gx = get_global_id(0);
	int	gy = get_global_id(1);
	int	lx = get_local_id(0);
	int	ly = get_local_id(1);

	int	sIndex = gx + gy * width;

	tile[lx][ly] = src[sIndex];

	barrier( CLK_LOCAL_MEM_FENCE );

	int	bx = (gx & ~0x0f) + ly;	// block x and y
	int	by = (gy & ~0x0f) + lx;

	if( ((by) < height) && ( (bx) < width ) )
	{
		int	dIndex = (by) + (bx ) * height;

		dst[dIndex] = tile[ly][lx];
	}

	return;
}

__kernel	void	Transpose_uc4_8x8( __global uint * src,  __global uint * dst,  int width, int height )
{
	__local	uint	tile[8][8];

	int	gx = get_global_id(0);
	int	gy = get_global_id(1);
	int	lx = get_local_id(0);
	int	ly = get_local_id(1);

	int	sIndex = gx + gy * width;

	tile[lx][ly] = src[sIndex];

	barrier( CLK_LOCAL_MEM_FENCE );

	int	bx = (gx & ~0x07) + ly;	// block x and y
	int	by = (gy & ~0x07) + lx;

	if( ((by) < height) && ( (bx) < width ) )
	{
		int	dIndex = (by) + (bx) * height;

		dst[dIndex] = tile[ly][lx];
	}

	return;
}


	// Assume transposing by loading 8x8 block of uints, storing to SLM
__attribute__(( reqd_work_group_size( 16, 16, 1) ))
__kernel	void	Transpose_us4( __global uint2 * src,  __global uint2 * dst,  int width, int height )
{
	__local	uint2	tile[16][16];

	int	gx = get_global_id(0);
	int	gy = get_global_id(1);
	int	lx = get_local_id(0);
	int	ly = get_local_id(1);

	int	sIndex = gx + gy * width;

	tile[lx][ly] = src[sIndex];

	barrier( CLK_LOCAL_MEM_FENCE );

	int	bx = (gx & ~0x0f) + ly;	// block x and y
	int	by = (gy & ~0x0f) + lx;

	if( ((by) < height) && ( (bx) < width ) )
	{
		int	dIndex = (by) + (bx ) * height;

		dst[dIndex] = tile[ly][lx];
	}

	return;
}

__kernel	void	Transpose_us4_8x8( __global uint2 * src,  __global uint2 * dst,  int width, int height )
{
	__local	uint2	tile[8][8];

	int	gx = get_global_id(0);
	int	gy = get_global_id(1);
	int	lx = get_local_id(0);
	int	ly = get_local_id(1);

	int	sIndex = gx + gy * width;

	tile[lx][ly] = src[sIndex];

	barrier( CLK_LOCAL_MEM_FENCE );

	int	bx = (gx & ~0x07) + ly;	// block x and y
	int	by = (gy & ~0x07) + lx;

	if( ((by) < height) && ( (bx) < width ) )
	{
		int	dIndex = (by) + (bx) * height;

		dst[dIndex] = tile[ly][lx];
	}

	return;
}


//		pre-calculate "blurRadius" so that the blur diameter is less than or equal to the width and height of buffers!
__kernel void Blur_Horizontal_Gray_Buffer(__read_only image2d_t src, __global uint* accum, int width, int height, int blurRadius)
{
	size_t	 v = get_global_id(0);

	if( v >= height )	return;	// avoid reading extra rows due to global size not an exact multiple of local size

	int index;
	int index_Dst;
	int index_Left;

	int2 coord = {0, v};
	int2 coord_left = coord;

	int	nRealBlurRadius = blurRadius;

	nRealBlurRadius = nRealBlurRadius + 1;

	uint SumGray = 0;
	uint4 tempSrc = {0, 0, 0, 0};
	uint4 tempResult = {0, 0, 0, 0};

	index = 0;
	index_Left = index;
	index_Dst = v * width;

	int x;

	// sum up 1st radius + 1 pixels to get to first write
	for (x = 0; x < nRealBlurRadius; x++)
	{
		coord = (int2)(index, v);
		coord.x = index++;
		tempSrc = read_imageui(src, imageSampler, coord);
		//coord.x++;

		SumGray = SumGray + tempSrc.x;

		//index++;
	}

	accum[index_Dst++] = SumGray;


	// sum another radius pixels writing sums to get to and write first full width
	for(x = 1; x < nRealBlurRadius; x++)
	{
		coord = (int2)(index, v);
		coord.x = index++;
		tempSrc = read_imageui(src, imageSampler, coord);
		//coord.x++;

		SumGray = SumGray + tempSrc.x;

		accum[index_Dst++] = SumGray;
	}

	// sum and subtract pixels from 2nd full width to and including last
	for ( ; x <= width-nRealBlurRadius; x++)
	{
		coord = (int2)(index, v);
		coord.x = index++;
		tempSrc = read_imageui(src, imageSampler, coord);
		////coord.x++;

		SumGray = SumGray + tempSrc.x;

		coord_left = (int2)(index_Left, v);
		coord_left.x = index_Left++;
		tempSrc = read_imageui(src, imageSampler, coord_left);
		////coord_left.x++;

		SumGray = SumGray - tempSrc.x;

		accum[index_Dst++] = SumGray;
	}

	// subtract pixels for all remaining reduced width blocks
	for ( ; x < width; x++)
	{
		coord_left = (int2)(index_Left, v);
		coord_left.x = index_Left++;
		tempSrc = read_imageui(src, imageSampler, coord_left);
		////coord_left.x++;

		SumGray = SumGray - tempSrc.x;

		accum[index_Dst++] = SumGray;
	}
}

//		pre-calculate "blurRadius" so that the blur diameter is less than or equal to the width and height of buffers!
__kernel void Blur_Vertical_Gray_Buffer(__global uint* accum, __write_only image2d_t dst, int width, int height, int blurRadius)
{
	size_t	 h = get_global_id(0);

	if(h >= width)		// not needed if default work group size or pad buffer - but may do extra columns
		return;

	int index = h;
	int index_Top = h;
	int index_Dst = 0;//h;

	int2 coord = {h, 0};

	int	nRealBlurRadius = blurRadius;

	nRealBlurRadius = nRealBlurRadius + 1;

	uint	divisor;
	uint	mod_div;

	mod_div = (h < nRealBlurRadius) ? (h+nRealBlurRadius) :
									( (h > (width - nRealBlurRadius)) ? (width - (h+1) + nRealBlurRadius) : (2 * nRealBlurRadius - 1)  );


	divisor = nRealBlurRadius * mod_div;

	uint SumGray = 0;
	uint4 tempSrc;			// = {0, 0, 0, 0};
	uint4 tempResult;		// = {0, 0, 0, 0};

	int	y;

	// Add up radius+1 before write first output
	for (y = 0; y < nRealBlurRadius; y++)
	{
		SumGray = SumGray +   accum[index];

		index += width;
	}

	tempResult.x = ( SumGray / divisor );

	write_imageui(dst, coord, tempResult);
	coord.y++;

	// Add up another radius rows to get to (and write) first whole block height averages
	for(y = 1; y < nRealBlurRadius; y++)
	{
		SumGray = SumGray +  accum[index];

		index += width;

		divisor += mod_div;
		tempResult.x = ( SumGray / divisor );

		write_imageui(dst, coord, tempResult);
		coord.y++;
	}


//	float	fRecip = 1.0f / (float)divisor;

	// Continue adding and now subtracting rows and writing full block height averages, including last full height
	for ( ; y <= height - nRealBlurRadius; y++)
	{
		SumGray = SumGray +  accum[index];
		index += width;

		SumGray = SumGray -  accum[index_Top];
		index_Top += width;

		//tempResult.x = (int)( SumGray * fRecip );
		tempResult.x = ( SumGray / divisor );

		write_imageui(dst, coord, tempResult);
		coord.y++;
	}

	// subtract rows for all remaining blocks
	for ( ; y < height; y++)
	{
		SumGray = SumGray - accum[index_Top];
		index_Top += width;

		divisor -= mod_div;

		tempResult.x = ( SumGray / divisor );

		write_imageui(dst, coord, tempResult);
		coord.y++;
	}
}


__kernel void BlendRegion_Box_NoInverseBuf(__global uchar4 * src, __global uchar4 * back, __global uchar4 * dst, int width, int height,
											int LeftBound, int RightBound, int TopBound, int BottomBound, float Gradient)
{
	int w = get_global_id(0);
	int h = get_global_id(1);
	int index = w + h * width;

	if(w >= LeftBound && h >= TopBound && w < RightBound && h < BottomBound)
	{

		int distance = min(min(w-LeftBound, RightBound-1-w), min(h - TopBound, BottomBound-1 -h));
		float sat;

		if (distance < Gradient)
		{
			float4	tempBack = convert_float4( back[index] );
			float4	tempSrc = convert_float4( src[index] );

			// the gradient part
			sat = (float)distance / Gradient;
			tempBack.x = tempSrc.x + sat * (tempBack.x - tempSrc.x);
			tempBack.y = tempSrc.y + sat * (tempBack.y - tempSrc.y);
			tempBack.z = tempSrc.z + sat * (tempBack.z - tempSrc.z);
			tempBack.w = 255.0f;

			dst[index] = convert_uchar4_sat( tempBack );
		}
		else
		{
			uchar4 temp = back[index];
			temp.w = 255;
			dst[index] = temp;
		}
	}
	else
	{
		uchar4 temp = src[index];
		temp.w = 255;

		dst[index] = temp;
	}
}

__kernel void BlendRegion_Circle_NoInverseBuf(__global uint * src, __global uint * back, __global uint * dst, int width, int height,
												int LeftBound, int RightBound, int TopBound, int BottomBound, float Gradient)
{
	int w = get_global_id(0);
	int h = get_global_id(1);
	int index = w + h * width;

	if(w >= LeftBound && h >= TopBound && w < RightBound && h < BottomBound)
	{
		int sqrWidth = ((RightBound - LeftBound)  * (RightBound - LeftBound)) >> 2 ;
		int sqrHeight = ((BottomBound - TopBound) * (BottomBound - TopBound)) >> 2 ;

		int newY = h - (TopBound + ((BottomBound - TopBound) >> 1));
		int newX = w - (LeftBound + ((RightBound - LeftBound) >> 1));

		float t = (float)(newX * newX) / (float)sqrWidth + (float)(newY * newY) / (float)sqrHeight;
		float sat;

		if(t <= 1.0f && t > 1.0f - Gradient)
		{
			float4	tempSrc, tempBack;

			tempSrc  = convert_float4( as_uchar4( src[index]  ) );
			tempBack = convert_float4( as_uchar4( back[index] ) );

			// the gradient part
			sat = (1.0 - t) / Gradient;

			tempBack.x = tempSrc.x + sat * (tempBack.x - tempSrc.x);
			tempBack.y = tempSrc.y + sat * (tempBack.y - tempSrc.y);
			tempBack.z = tempSrc.z + sat * (tempBack.z - tempSrc.z);
			tempBack.w = 255;

			dst[index] = as_uint( convert_uchar4_sat( tempBack ) );
		}
		else if(t <= 1.0f - Gradient)
		{
			//sat = 1.0f;
			uint	temp = back[index];
			temp |= 0xFF000000;			// alpha set to 255

			dst[index] = temp;
		}
		else
		{
			//sat = 0.0f;
			uint	temp = src[index];
			temp |= 0xFF000000;			// alpha set to 255

			dst[index] = temp;
		}
	}
	else
	{
		uint	temp = src[index];
		temp |= 0xFF000000;			// alpha set to 255

		dst[index] = temp;
	}
}

__kernel void BlendRegion_Box_InverseBuf(__global uchar4 * src, __global uchar4 * back, __global uchar4 * dst, int width, int height,
											int LeftBound, int RightBound, int TopBound, int BottomBound, float Gradient)
{
	int w = get_global_id(0);
	int h = get_global_id(1);
	int index = w + h * width;

	if(w >= LeftBound && h >= TopBound && w < RightBound && h < BottomBound)
	{
		int distance = min(min(w-LeftBound, RightBound-1-w), min(h - TopBound, BottomBound-1 -h));
		float sat;

		if (distance < Gradient)
		{
			float4	tempBack = convert_float4( src[index] );
			float4	tempSrc = convert_float4( back[index] );

			// the gradient part
			sat = (float)distance / Gradient;

			tempBack.x = tempSrc.x + sat * (tempBack.x - tempSrc.x);
			tempBack.y = tempSrc.y + sat * (tempBack.y - tempSrc.y);
			tempBack.z = tempSrc.z + sat * (tempBack.z - tempSrc.z);
			tempBack.w = 255.0f;

			dst[index] = convert_uchar4_sat( tempBack );
		}
		else
		{
			uchar4 temp = src[index];
			temp.w = 255;
			dst[index] = temp;
		}
	}
	else
	{
		uchar4 temp = back[index];
		temp.w = 255;
		dst[index] = temp;
	}
}

__kernel void BlendRegion_Circle_InverseBuf(__global uint * src, __global uint * back, __global uint * dst, int width, int height,
												int LeftBound, int RightBound, int TopBound, int BottomBound, float Gradient)
{
	int w = get_global_id(0);
	int h = get_global_id(1);
	int index = w + h * width;

	if(w >= LeftBound && h >= TopBound && w < RightBound && h < BottomBound)
	{
		int sqrWidth = ((RightBound - LeftBound)  * (RightBound - LeftBound)) >> 2 ;
		int sqrHeight = ((BottomBound - TopBound) * (BottomBound - TopBound)) >> 2 ;

		int newY = h - (TopBound + ((BottomBound - TopBound) >> 1));
		int newX = w - (LeftBound + ((RightBound - LeftBound) >> 1));

		float t = (float)(newX * newX) / (float)sqrWidth + (float)(newY * newY) / (float)sqrHeight;
		float sat;

		if(t <= 1.0f && t > 1.0f - Gradient)
		{
			float4	tempSrc  = convert_float4( as_uchar4( back[index]  ) );
			float4	tempBack = convert_float4( as_uchar4( src[index] ) );

			// the gradient part
			sat = (1.0 - t) / Gradient;

			tempBack.x = tempSrc.x + sat * (tempBack.x - tempSrc.x);
			tempBack.y = tempSrc.y + sat * (tempBack.y - tempSrc.y);
			tempBack.z = tempSrc.z + sat * (tempBack.z - tempSrc.z);
			tempBack.w = 255;

			dst[index] = as_uint( convert_uchar4_sat( tempBack ) );
		}
		else
		{
			//	 sat == 1.0f : 0.0f;
			uint	temp = (t <= 1.0f - Gradient) ?  src[index] : back[index];
			temp |= 0xFF000000;			// alpha set to 255

			dst[index] = temp;
		}
	}
	else
	{
		uint	temp = back[index];
		temp |= 0xFF000000;			// alpha set to 255

		dst[index] = temp;
	}
}


// buildOptions=
// RUN: %occ-cli %s --cl-options="-I%cwd -I%S " %cfg_path --cl-device=%cl_device 2>&1
