#define MAX_PIXEL		65535		// 2^16 - 1
#define EXPVALUE		5909							// TONE_MAX_TABLE_SIZE/ log(TONE_MAX_TABLE_SIZE)
#define nMAX_ProPhotoRGB		65535
#define	MAX_SRGB64		65535
#define	GRADIENT_RADIUS_LOOP	3
#define	RECIP_GRADIENT_RADIUS_LOOP	0.333333333f

constant	sampler_t	sample_linear	=	CLK_NORMALIZED_COORDS_FALSE |
								CLK_ADDRESS_CLAMP_TO_EDGE   |
								CLK_FILTER_LINEAR ;

constant	sampler_t	sample_nearest	=	CLK_NORMALIZED_COORDS_FALSE |
								CLK_ADDRESS_CLAMP_TO_EDGE   |
								CLK_FILTER_NEAREST ;

constant	float	cRound65 = (0.5f * 1.0f / 65535.0f);

// For 8 bit or 16 bit input images, OpenCL will map 0.0 to 1.0 to full range
//	and can just multiply by 255.


////// NOTE:   ALL image2d_t kernels assume width may not be multiple of local size - but height is.
//////			Easiest approach is to use 1 as the Y local size, something like 16 for X,
//////				and set global X to width rounded up to next multiple of 16.
//////			Each such kernel tests the x coordinate before doing any processing or writes.

constant float3	 RGBTToLightWeight = (float3)( 0.3333333f,  0.3333334f,  0.3333333f );

#define ROUND_INT( dValue ) ((int)(dValue + 0.5f))



// New version using buffer for lumiDst


kernel	void GetLuminance( global const ushort4* pixelSrc,  global int  *lumiDst, int nWidth, int nHeight, global int *pnMaskMapping, int nBoundary)
{
	int	x = get_global_id(0);
	int		y = get_global_id(1);
	if( x >= nWidth || y >= nHeight)
		return;

	int index = y* nWidth + x;

	ushort4 f4In = pixelSrc[index];

		//	m_pnMaskMapping[i] = ROUND_INT( (pow( (double)i / nMaxValue, 0.55 ) * nMaxValue) );
	lumiDst[index] = pnMaskMapping[min((int)( RGBTToLightWeight.s2 * f4In.s0 + RGBTToLightWeight.s1 * f4In.s1 + RGBTToLightWeight.s0 * f4In.s2 ), nBoundary)];

}

// 5-3-2013, New implementation using buffer
kernel void	GradientMask1(global int *LumiIn,  global int *BlurIn,  global float * pfMask, int nWidth, int nHeight, int stride, int bFirstPass )
{
	int		x = get_global_id(0);
	int		y = get_global_id(1);

	if( x >= nWidth || y <= nHeight)
		return;

	// Assumes local_size(1) is an exact divisor of actual image height - possibly "1" - so can just test X bounds
	//if( x < nWidth )
	//{
		//int		y = get_global_id(1);
		int	index = x + y * stride;
		float	fMask;

		int Lumi = LumiIn[index];
		int Blur = BlurIn[index];

		fMask = (bFirstPass == 1) ? 0.0f : pfMask[index];	// first pass accumulation is 0.0, subsequently read from table

		//fMask  += ( pfLogTable[ u4Lumi.s0 ] - pfLogTable[ u4Blur.s0 ] ) / (float)(GRADIENT_RADIUS_LOOP);

		//  		pfLogTable[i] = log( (float)i+1 );
		//	Using direct calculation is a bit faster and should be accurate enough
		fMask  += ( native_log( (float)Lumi + 1.0f ) - native_log( (float)Blur + 1.0f) ) * RECIP_GRADIENT_RADIUS_LOOP;

		pfMask[index] = fMask;
	//}
}


// read through pfMask and find max and min.
//	Pass in a 1D buffer
//	Parallelism by having global size == group size - must be 1024 or less!
//	Pass in the actual data size as nSize
//	Collapse after barrier to single min and max, to return
kernel	void	MaxMin( global float * pfMask,  int nSize,   global float * pfMaxMin )
{
	int	start = get_local_id(0);
	int	step = get_local_size(0);

	local	float	fMins[1024];
	local	float	fMaxs[1024];

	float	fMin, fMax;

	int	index;

if( start < nSize)
{
	fMin = min( fMin, pfMask[start] );
	fMax = max( fMax, pfMask[start] );

	for( index = start + step; index < nSize; index += step )
	{
		fMin = min( fMin, pfMask[index] );
		fMax = max( fMax, pfMask[index] );
	}

	fMins[start] = fMin;
	fMaxs[start] = fMax;
}

barrier( CLK_LOCAL_MEM_FENCE);

	if( start == 0 )	// responsible for collecting final min/max
	{
		for( index = 0; index < step; index++ )
		{
			fMin = min( fMin, fMins[index] );
			fMax = max( fMax, fMaxs[index] );
		}

		pfMaxMin[0] = fMax;
		pfMaxMin[1] = fMin;
	}

	return;

}

// 2nd inner loop - must implement code from outside loops on host side.
//kernel	void	GradientMask2( global float * pfMask, global ushort * GradientMask, int nWidth, global int * pnMaskMapping, int nBoundary, float fGradientMin )
kernel	void	GradientMask2( global float * pfMask, global ushort * GradientMask, int nWidth, int nBoundary, float fGradientMin )
{
	int		x = get_global_id(0);

	if( x < nWidth )
	{
		int		y = get_global_id(1);

// can't do max and min of whole array this way - need another kernel - see MaxMin above - call it separately before this kernel
//			if (!bNormal)
//			{
//				if (fMax < pfMask[index])
//					fMax = pfMask[index];
//				else if (fMin > fMpfMaskask[index])
//					fMin = pfMask[index];
//			}

		int		nTemp;
		int		index = x + y * nWidth;
		float	fMask;

		fMask = pfMask[index];

		//if ( fMask >= 0)
		//	fMask = 0.0f;
		//else
		//	fMask = min( fMask / fGradientMin, 1.0f );
		// No performance difference using above and below
		fMask = min( fMask, 0.0f );
		fMask = min( fMask / fGradientMin,  1.0f );


		//nTemp = (int)( 0.5f + (nBoundary * fMask) );
		//GradientMask[index] = pnMaskMapping[ nTemp ];

		// Since... //			pnMaskMapping[i] = ROUND_INT( (pow( (float)i / nBoundary, 0.55f ) * nBoundary) );
		// Direct calculation is cheaper //
			//GradientMask[index]  = ROUND_INT( (pow( fMask, 0.55f ) * nBoundary) );
		GradientMask[index]  = ROUND_INT( (native_powr( fMask, 0.55f ) * nBoundary) );
	}
}



// 5-3-2013, new version, using buffer (integer32) for all cl_mem ================================
__kernel void Blur_Horizontal_Gray(global const int *src, global int*dst, int width, int height, int stride, int blurRadius)
{
	int h = get_global_id(0);
	int index = 0;
	int index_Dst = 0;
	int index_Left = 0;
	int src_index;
	int dst_index;
	int h_stride = h*stride;

	if(h >= height)
		return;

	int nRadiusPlus = blurRadius + 1;

	int SumGray = 0;
	int tempSrc;
	int tempResult;
	int num = 0;

	index = 0;
	index_Dst = 0;
	index_Left = 0;
	int x = 0;

	for (x = 0; x < nRadiusPlus; ++x)
	{
		src_index = h_stride + index;  // Note: can change to src_index++
		tempSrc = src[src_index];
		SumGray += tempSrc;
		index++;
	}

	num = nRadiusPlus;
	tempResult = SumGray;// / num;		// Do the divide in vertical pass, avoid potential loss of precision

	dst_index = h_stride + index_Dst;
	dst[dst_index] = tempResult;
	index_Dst++;

	src_index = h_stride + index;  // Note: can change to src_index++
	for(x = 1; x < nRadiusPlus; ++x)
	{
		tempSrc = src[src_index];
		SumGray += tempSrc;

		index++;
		src_index++;

		num += 1;
		tempResult = SumGray;// / num;

		dst_index = h_stride + index_Dst;
		dst[dst_index] = tempResult;
		index_Dst++;
	}

	dst_index = h_stride + index_Dst;	// can change to dst_index++;
	for (x = nRadiusPlus; x < width-blurRadius; ++x)
	{
		src_index = h_stride + index;
		SumGray += src[src_index];
		index++;

		src_index = h_stride + index_Left;
		SumGray -= src[src_index];
		index_Left++;

		dst[dst_index] = SumGray;
		index_Dst++;
		dst_index++;
	}

	for (x = width - blurRadius; x < width; ++x)
	{
		src_index = h_stride + index_Left;
		tempSrc = src[src_index];

		SumGray -= tempSrc;
		index_Left++;

		num -= 1;

		dst_index = h_stride + index_Dst;	// can change to dst_index++;
		dst[dst_index] = SumGray;

		index_Dst++;
	}
}

__kernel void Blur_Vertical_Gray(global const int *src, global int*dst, int width, int height, int stride, int blurRadius)
{
	int w = get_global_id(0);
	int index = 0;
	int src_index;
	int dst_index;
	int index_Dst = 0;
	int index_Top = 0;

	if(w >= width)
		return;

// Assume blurRadius is not too large (never happens for GetGradientMask)
//	int nBound = width < height ? width : height;
	int nRadiusPlus = blurRadius + 1;
//	if((nRadiusPlus * 2 + 1) > nBound)
//		nRadiusPlus = (nBound - 1) / 2;

	int	nBlurDiam = nRadiusPlus + blurRadius;

	// determine the width summed in Blur_Horizontal_Gray for this column
	int	wTop = w + nRadiusPlus;
	int	wBot = blurRadius + width - w;
	int	wCnt = min( nBlurDiam, min( wTop, wBot) );

	int SumGray = 0;
	int tempSrc;
	int tempResult;
	int num = 0;
	int weighting;

	src_index = stride*index + w;
	for (int y = 0; y < nRadiusPlus; ++y)
	{
		SumGray += src[src_index];
		index++;
		src_index += stride;
	}

	num = nRadiusPlus;
	weighting = num * wCnt;
	tempResult = SumGray / weighting;

	dst[w] = tempResult;
	index_Dst++;

	// top
	for(int x = 1; x < nRadiusPlus; ++x)
	{
		src_index = stride*index + w;
		SumGray += src[src_index];

		index++;
		num += 1;

		weighting = num * wCnt;
		tempResult = SumGray / weighting;

		dst_index = stride*index_Dst + w;
		dst[dst_index] = tempResult;
		index_Dst++;
	}

	// middle
	//	weighting = num * wCnt;
	dst_index = stride*index_Dst + w;
	for (int x = nRadiusPlus; x < height - blurRadius; ++x)
	{
		src_index = stride*index + w;  // change to src_index += stride
		SumGray += src[src_index];
		index++;

		src_index = stride*index_Top + w;  // change to src_index += stride
		SumGray -= src[src_index];

		index_Top++;
		tempResult = SumGray / weighting;
		dst[dst_index] = tempResult;

		index_Dst++;
		dst_index += stride;
	}

	// bottom
	dst_index = stride*index_Dst + w;
	for (int x = height - blurRadius; x < height; ++x)
	{
		src_index = stride*index_Top + w;  // change to src_index += stride
		tempSrc = src[src_index];

		SumGray -= tempSrc;

		index_Top++;
		num -= 1;

		weighting = num * wCnt;

		tempResult = SumGray / weighting;
		dst[dst_index] = tempResult;

		index_Dst++;
		dst_index += stride;
	}
}

// 6-21-2013 version, Blur_Horizontal_Gray was broken into 3 kernels:
// Blur_Horizontal_Gray_border, Blur_Horizontal_Gray_sub_sum, Blur_Horizontal_Gray_center
kernel void Blur_Horizontal_Gray_sub_sum(global const int *src, global int*dst, int width, int height, int num_block, int num_pix_per_block)
{
	int block_index = get_global_id(0);
	int h = get_global_id(1);

	if(h >= height || block_index >= num_block)
		return;

	int src_index = h*width + block_index*num_pix_per_block + 1;
	int dst_index = h*num_block + block_index;


	int SumGray = 0;
	for(int i = 0; i < num_pix_per_block; i++)
	{
		SumGray += src[src_index];
		src_index++;
	}

	dst[dst_index] = SumGray;

}

// process num_pix_per_block pixels for each work-item
kernel void Blur_Horizontal_Gray_center(global const int *src, global const int *src_sum, global int*dst, int width, int height, int num_pix_per_block, int num_block, int num_block_src_sum, int nRadius_plus)
{
	int block_index = get_global_id(0);
	int h = get_global_id(1);

	if(h >= height || block_index >= num_block)  // num_block = width/num_pix_per_block in host code
		return;

	int src_index_left = h*width + block_index*num_pix_per_block + 1;
	int src_index = src_index_left;
	int dst_index = src_index + nRadius_plus - 1;
	int src_len = 2*nRadius_plus - 1;

	int src_sum_index = h*num_block_src_sum + block_index;
	int num_sum = src_len/num_pix_per_block;
	int SumGray = 0;
	for(int i = 0; i < num_sum; i++){
		SumGray += src_sum[src_sum_index];
		src_sum_index++;
	}

	src_len -= num_sum*num_pix_per_block;

	src_index += num_pix_per_block*num_sum;
	for(int i = 0; i < src_len; i++){
		SumGray += src[src_index++];
	}

	dst[dst_index++] = SumGray;

	// do the next "num_pix_per_block"  pixel
	for(int i = 1; i < num_pix_per_block; i++){
		SumGray = SumGray + src[src_index++] - src[src_index_left++];
		dst[dst_index++] = SumGray;
	}

}


__kernel void Blur_Horizontal_Gray_border(global const int *src, global int*dst, int width, int height, int num_pix_right, int blurRadius)
{
	int h = get_global_id(0);
	if(h >= height)
		return;

	int src_index = h*width;
    int dst_index = h*width;

	int nRadiusPlus = blurRadius + 1;
	int SumGray = 0;

	// summation of src (from left most ) and store to dst[k], k = 0,1,. . ., nRadiusPlus - 1
	for (int x = 0; x < nRadiusPlus; ++x)
	{
		SumGray += src[src_index];
		src_index++;
	}
	dst[dst_index] = SumGray;
	dst_index++;

	for(int x = 1; x < nRadiusPlus; ++x)
	{
		SumGray += src[src_index];
		src_index++;
		dst[dst_index] = SumGray;
		dst_index++;
	}

	// calculate the last "num_pix_right" for dst[], eg
	// summation of src (from right most) and store to dst[k], k = w-1, w-2, . . . w - num_pix_right - 1
	src_index = h*width + width - 1;
	int src_right = src_index;
    dst_index = src_index;

	SumGray = 0;
	for (int x = 0; x < nRadiusPlus; ++x)
	{
		SumGray += src[src_index];
		src_index--;
	}
	dst[dst_index] = SumGray;
	dst_index--;

	for(int x = 1; x < nRadiusPlus; ++x)
	{
		SumGray += src[src_index];
		src_index--;
		dst[dst_index] = SumGray;
		dst_index--;
	}

	int remain_pix = num_pix_right - nRadiusPlus;

	for(int x = 0; x < remain_pix; ++x)
	{
		SumGray += src[src_index];
		src_index--;
		SumGray -= src[src_right];
		src_right--;

		dst[dst_index] = SumGray;
		dst_index--;
	}

}



// buildOptions=
// RUN: %occ-cli %s --cl-options="-I%cwd -I%S " %cfg_path --cl-device=%cl_device 2>&1
