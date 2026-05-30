__constant sampler_t imageSampler_Top = CLK_NORMALIZED_COORDS_FALSE | CLK_ADDRESS_CLAMP | CLK_FILTER_NEAREST;
__constant sampler_t imageSampler_Bottom = CLK_NORMALIZED_COORDS_FALSE | CLK_ADDRESS_CLAMP | CLK_FILTER_NEAREST;
__constant sampler_t imageSampler_Left = CLK_NORMALIZED_COORDS_FALSE | CLK_ADDRESS_CLAMP | CLK_FILTER_NEAREST;
__constant sampler_t imageSampler_Right = CLK_NORMALIZED_COORDS_FALSE | CLK_ADDRESS_CLAMP | CLK_FILTER_NEAREST;


__kernel void ColorEdge_Kernel(__global uchar4 * src, __global uchar4 *  dst, int width, int height)
{
	int x = get_global_id(0);
	int y = get_global_id(1);

	int index = width * y + x;

	float4 tempSrc_Top;
	float4 tempSrc_Bottom;
	float4 tempSrc_Left;
	float4 tempSrc_Right;
	float4 tempDst;

	tempDst = 0;

	if(x >= 1 && y >= 1 && x < (width-1) && y < (height-1))
	{
		//coord = (int2)(x + 1, y);
		tempSrc_Right = convert_float4( src[ index + 1 ]  );

		//coord = (int2)(x - 1, y);
		tempSrc_Left = convert_float4( src[ index - 1 ]  );

		//coord = (int2)(x, y + 1);
		tempSrc_Bottom = convert_float4( src[ index + width ]  );

		//coord = (int2)(x, y - 1);
		tempSrc_Top = convert_float4( src[ index - width ]  );

		float4	der_x = tempSrc_Right - tempSrc_Left;
		float4	der_y = tempSrc_Bottom - tempSrc_Top;

		tempDst = sqrt(  mad( der_x, der_x, mad( der_y, der_y, (float4)0.0f ) ));		//der_x * der_x + der_y * der_y);
		tempDst.w = dst[index].w;
	}

	// limit to storing in range
	if( (x < width)   &&   (y < height) )
	{
		dst[index] = convert_uchar4_sat( tempDst );
	}
}


__kernel void ColorEdge_MaximumPixel(__global uchar4 * src,  __global uint* MaximumTable, int bufSize )
{
	size_t globalSize = get_global_size(0);
	size_t offset = get_global_id(0);

	int index = (int)offset;
	int step = (int)globalSize;

	uchar4	nMaximumValue = 0;

	while( index < bufSize )
	{
		nMaximumValue = max( nMaximumValue, src[index] );

		index += step;
	}

	// MaximumPixel.x = nMaximumValue;
	uint MaximumPixel = (uint)( max( max( nMaximumValue.x, nMaximumValue.y ), nMaximumValue.z ) );

	MaximumTable[offset] = MaximumPixel;
}


//constant	uint16	position = { 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15 };
__kernel void ColorEdge_MaxKernel(__global uint16* MaximumTable, int TableSize )//, __global float* Max)
{
	uint16 nMaximumValue = 0;
	int tabsize = TableSize / 16;	// require buffer allocated a multiple of 16
	for(uint i = 0; i < tabsize; i++)
	{
		nMaximumValue = max( nMaximumValue, ( MaximumTable[i] & (uint16)0x0ff) );
	}

	// mechanism to select existing data - may read past end of buffer...
	//uint extra = TableSize - 16*tabsize;
	//nMaximumValue = max( nMaximumValue, select( 0, MaximumTable[tabsize], ( position < extra ) ) );

	nMaximumValue.s01234567 = max( nMaximumValue.s01234567, nMaximumValue.s89abcdef);
	nMaximumValue.s0123 = max( nMaximumValue.s0123, nMaximumValue.s4567);
	nMaximumValue.s01 = max( nMaximumValue.s01, nMaximumValue.s23);

	nMaximumValue.s0 = max( nMaximumValue.s0, nMaximumValue.s1);

	//  want multiplier (float) for Normalize kernel (below) - pass back in the same buffer since this kernel isn't threaded
	MaximumTable[0].s0 = as_uint( 255.0f / (float)nMaximumValue.s0 );
}


__kernel void ColorEdge_Normalize(__global uchar4 * src,  __global uchar4 *  dst, __global float * Max, int width, int height)
{
	int w = get_global_id(0);
	int h = get_global_id(1);

	w = min( w, width-1 );
	h = min( h, height-1 );

	int index = w + h * width;

	float Ratio = Max[0];

	float4 tempValue = 0;

	tempValue = convert_float4( src[index] );

	tempValue.x = (tempValue.x * Ratio);
	tempValue.y = (tempValue.y * Ratio);
	tempValue.z = (tempValue.z * Ratio);

	dst[index] = convert_uchar4_sat( tempValue );
}

///////////////////////////////////////////////////////////////////////////
// Original
///////////////////////////////////////////////////////////////////////////
/*
__kernel void ColorEdge_Original(__read_only image2d_t src, __write_only image2d_t dst, int width, int height)
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

__kernel void MaximumPixel_Original(__read_only image2d_t src, __write_only image2d_t dst, __global uchar4* MaximumTable, int width, int height, int block_size, int TableSize)
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

__kernel void SumKernel_Original(__global uchar4* MaximumTable, int TableSize, __global float* Mean)
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

__kernel void Normalize_Original(__read_only image2d_t src, __global float* Mean, __write_only image2d_t dst, int width, int height)
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
*/

// buildOptions=
// RUN: %occ-cli %s --cl-options="-I%cwd -I%S " %cfg_path --cl-device=%cl_device 2>&1
