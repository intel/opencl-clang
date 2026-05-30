//-----------------------------------------------------------------------------
#define	LUMA_RGB( r, g, b )( 0.25f * (r) + 0.625f * (g) + 0.125f * (b) )
#define	LUMA( clr )( 0.25f * (clr).x + 0.625f * (clr).y + 0.125f * (clr).z )

float luma( __read_only image2d_t img, int2 pos );
float lumaC( __global float4 const * pSrc, uint nRowPixels, int2 pos );
float lumaP( __global float const * pSrc, uint nRowPixels, uint nPlanePixels, int2 pos );
void loadLumaLDS(__local float *pixels, __global float const * restrict src, const int lrp,
				 const uint rowPixels, const uint nPlanePixels, const int size,
				 const int pad, const int globalWidth, const int globalHeight,
				 const int groupId, const int workGroupSize);

//-----------------------------------------------------------------------------
float lumaP( __global float const * pSrc, uint nRowPixels, uint nPlanePixels, int2 pos )
{
	float	r = pSrc[pos.x + pos.y * nRowPixels];
	float	g = pSrc[pos.x + pos.y * nRowPixels + nPlanePixels];
	float	b = pSrc[pos.x + pos.y * nRowPixels + 2 * nPlanePixels];

	return LUMA_RGB( r, g, b );
}

//-----------------------------------------------------------------------------
void loadLumaLDS(__local float *pixels, __global float const * restrict src, const int lrp,
				 const uint rowPixels, const uint nPlanePixels, const int size,
				 const int pad, const int globalWidth, const int globalHeight,
				 const int groupId, const int workGroupSize)
{
	const int lsize = lrp * lrp;
	int srcx = get_group_id(0) * size - pad;
	int srcy = get_group_id(1) * size - pad;
    int loadOffset = groupId;

	while (loadOffset < lsize)
	{
		int x = srcx + (loadOffset % lrp);
		int y = srcy + (loadOffset / lrp);
		x = (x < 0) ? -x : x;
		x = (x >= globalWidth) ? (2 * (globalWidth - 1) - x) : x;
		y = (y < 0) ? -y : y;
		y = (y >= globalHeight) ? (2 * (globalHeight - 1) - y) : y;

//		pixels[loadOffset] = src[x + y * rowPixels];
		pixels[loadOffset] = lumaP( src, rowPixels, nPlanePixels, (int2)( x,  y ) );
		loadOffset += workGroupSize;
	}
}

//-----------------------------------------------------------------------------
#define	KERNEL_SIZE	16				//	Size of the 2D kernel in pixels
#define PAD	2
#define LRP (KERNEL_SIZE + 2 * PAD)	//	local row pixels

//-----------------------------------------------------------------------------
__kernel __attribute__((reqd_work_group_size(16, 16, 1)))
void rgbSharpen_PlanarLds( __global float * pDst,
						   __global float const * restrict pSrc,
						   uint nRowPixels, uint nPlanePixels,
						   uint nWidth, uint nHeight,
						   int nMip, float fSharpness, int nSensitivity,
						   const unsigned int destFormat, const float fWhite )
{
	__local float pixels[LRP * LRP];
	__local float blurr[LRP * KERNEL_SIZE];

	const int2	localPos = (int2)( get_local_id(0), get_local_id(1) );
	const int2	pos = (int2)( get_global_id(0), get_global_id(1) );
	const int	nWorkGroupSize = KERNEL_SIZE * KERNEL_SIZE;
	//	convert 2D positions into 1D indices
	const int	groupIdx = localPos.x + localPos.y * KERNEL_SIZE;

	loadLumaLDS( pixels, pSrc, LRP, nRowPixels, nPlanePixels, KERNEL_SIZE, PAD, nWidth, nHeight, groupIdx, nWorkGroupSize );

	barrier(CLK_LOCAL_MEM_FENCE);

	//	save the original color
	float	r = pSrc[pos.x + pos.y * nRowPixels];
	float	g = pSrc[pos.x + pos.y * nRowPixels + nPlanePixels];
	float	b = pSrc[pos.x + pos.y * nRowPixels + 2 * nPlanePixels];

	//	perform a reduction by separating the 2D kernel into two passes of a 1D kernel
	//	moves us from a 20x20 kernel to 20x16
	//	1D Vertical Kernel
	//	1
	//	2
	//	4
	//	2
	//	1

	//	1D index into pixels
	int	loadOff = groupIdx;
	const int	lsize = LRP * KERNEL_SIZE;

	while ( loadOff < lsize )
	{
		float fSum;
		int	x = (loadOff % LRP);
		int y = PAD + (loadOff / LRP);
		int pixOff = x + y * LRP;

		fSum = pixels[pixOff - 2 * LRP] + 2.f * ( pixels[pixOff - LRP] + pixels[pixOff + LRP] ) + 4.f * pixels[pixOff] + pixels[pixOff + 2 * LRP];
		blurr[loadOff] = fSum;

		loadOff += nWorkGroupSize;
	}

	barrier(CLK_LOCAL_MEM_FENCE);

	//	blurr[] now contains the results of the 1D Vertical kernel
	//	apply the 1D Horizontal kernel & sharpen
	const int blurrOff = localPos.x + PAD + localPos.y * LRP;

	//	save the original luma
	float	lumaOrig = LUMA_RGB( r, g, b );
	float	lumaBlur = 0.f;
	float	fMipDiv = 1.f / ( 1 << nMip );
	float	fSS = ( nSensitivity * 128.f ) / 65535.f;
	float	fCutoff = fSS * 0.5f;
	float	fInvCutoff = 1.f / fCutoff;

	lumaBlur = blurr[blurrOff - 2] + 2.f * ( blurr[blurrOff - 1] + blurr[blurrOff + 1] ) + 4.f * blurr[blurrOff] + blurr[blurrOff + 2];
	lumaBlur = lumaBlur * 0.01;

	//	subtract blurr from original luma
	float	fSharp = lumaOrig - lumaBlur;
	float	fAbsDif, fTmp;

	//	apply strength to difference
	fSharp *= fSharpness;

	//	get the absolute value
	fAbsDif = fabs( fSharp );

	//	do cutoff here...
	//	calculate the diff when it's between the cutoff & ss
	fTmp = ( ( fAbsDif - fCutoff ) * fSharp ) * fInvCutoff;

	//	if adiff < cutoff ... vTmp = 0 else vTmp remains as above
	fTmp = fAbsDif < fCutoff ? 0.f : fTmp;

	//	if adiff < ss ... vDif = vTmp else vDif remains the same
	fSharp = fAbsDif < fSS ? fTmp : fSharp;

	fSharp *= fMipDiv;
	fSharp += nMip > 0 ? fSharp * 0.5f : 0.f;

	//	we now have the sharpened luma, apply it to each color channel
	//	add the sharpened luminance change to the original color
	r += fSharp;
	g += fSharp;
	b += fSharp;

	//	clamp to 0 (don't want any negative values)
	r = max( r, 0.f );
	g = max( g, 0.f );
	b = max( b, 0.f );

	//	store to output image
	//	only output valid pixels

	if ( pos.x < (int)nWidth && pos.y < (int)nHeight )
	{
		if (destFormat == 0)
		{
			pDst[pos.x + pos.y * nRowPixels]                    = r;
			pDst[pos.x + pos.y * nRowPixels + nPlanePixels]     = g;
			pDst[pos.x + pos.y * nRowPixels + 2 * nPlanePixels] = b;
		}
		else
		{
			__global unsigned short int *pShortDst = (__global unsigned short int *)(pDst);

			int	ri, gi, bi;

			//	clamp to the ushort range [0..65535]
			ri = clamp( (int)( r * fWhite + 0.5f ), 0, 65535 );
			gi = clamp( (int)( g * fWhite + 0.5f ), 0, 65535 );
			bi = clamp( (int)( b * fWhite + 0.5f ), 0, 65535 );

			pShortDst[pos.x + pos.y * nRowPixels]                    = (ushort)(ri);
			pShortDst[pos.x + pos.y * nRowPixels + nPlanePixels]     = (ushort)(gi);
			pShortDst[pos.x + pos.y * nRowPixels + 2 * nPlanePixels] = (ushort)(bi);
		}
	}
}

//-----------------------------------------------------------------------------
__kernel void rgbSharpen_Planar( __global float * pDst,
								 __global float const * pSrc,
								 uint nRowPixels, uint nPlanePixels,
								 int nMip, float fSharpness, int nSensitivity,
								 const unsigned int destFormat, const float fWhite )

{
	int2	pos = (int2)( get_global_id(0), get_global_id(1) );

	//	save the original color
	float	r = pSrc[pos.x + pos.y * nRowPixels];
	float	g = pSrc[pos.x + pos.y * nRowPixels + nPlanePixels];
	float	b = pSrc[pos.x + pos.y * nRowPixels + 2 * nPlanePixels];

	//	pixels in the pad get coppied through
	if ( pos.x < 2 || pos.y < 2 || pos.x >= (int)get_global_size(0) - 2 || pos.y >= (int)get_global_size(1) - 2 )
	{
		pDst[pos.x + pos.y * nRowPixels]                    = r;
		pDst[pos.x + pos.y * nRowPixels + nPlanePixels]     = g;
		pDst[pos.x + pos.y * nRowPixels + 2 * nPlanePixels] = b;
		return;
	}

	//	save the original luma
	float	lumaOrig = LUMA_RGB( r, g, b );
	float	lumaBlur = 0.f;
	float	fMipDiv = 1.f / ( 1 << nMip );
	float	fSS = ( nSensitivity * 128.f ) / 65535.f;
	float	fCutoff = fSS * 0.5f;
	float	fInvCutoff = 1.f / fCutoff;

	//	convert each color to luminance and apply the following kernel:
	//	1  2  4  2  1
	//	2  4  8  4  2
	//	4  8 16  8  4
	//	2  4  8  4  2
	//	1  2  4  2  1

	lumaBlur += lumaP( pSrc, nRowPixels, nPlanePixels, pos + (int2)( -2, -2 ) ) + 2.f * lumaP( pSrc, nRowPixels, nPlanePixels, pos + (int2)( -1, -2 ) ) +
		4.f * lumaP( pSrc, nRowPixels, nPlanePixels, pos + (int2)( 0, -2 ) ) + 2.f * lumaP( pSrc, nRowPixels, nPlanePixels, pos + (int2)( 1, -2 ) ) +
		lumaP( pSrc, nRowPixels, nPlanePixels, pos + (int2)( 2, -2 ) );

	lumaBlur += 2.f * lumaP( pSrc, nRowPixels, nPlanePixels, pos + (int2)( -2, -1 ) ) + 4.f * lumaP( pSrc, nRowPixels, nPlanePixels, pos + (int2)( -1, -1 ) ) +
		8.f * lumaP( pSrc, nRowPixels, nPlanePixels, pos + (int2)( 0, -1 ) ) + 4.f * lumaP( pSrc, nRowPixels, nPlanePixels, pos + (int2)( 1, -1 ) ) +
		2.f * lumaP( pSrc, nRowPixels, nPlanePixels, pos + (int2)( 2, -1 ) );

	lumaBlur += 4.f * lumaP( pSrc, nRowPixels, nPlanePixels, pos + (int2)( -2, 0 ) ) + 8.f * lumaP( pSrc, nRowPixels, nPlanePixels, pos + (int2)( -1, 0 ) ) +
		16.f * lumaOrig + 8.f * lumaP( pSrc, nRowPixels, nPlanePixels, pos + (int2)( 1, 0 ) ) +
		4.f * lumaP( pSrc, nRowPixels, nPlanePixels, pos + (int2)( 2, 0 ) );

	lumaBlur += 2.f * lumaP( pSrc, nRowPixels, nPlanePixels, pos + (int2)( -2, 1 ) ) + 4.f * lumaP( pSrc, nRowPixels, nPlanePixels, pos + (int2)( -1, 1 ) ) +
		8.f * lumaP( pSrc, nRowPixels, nPlanePixels, pos + (int2)( 0, 1 ) ) + 4.f * lumaP( pSrc, nRowPixels, nPlanePixels, pos + (int2)( 1, 1 ) ) +
		2.f * lumaP( pSrc, nRowPixels, nPlanePixels, pos + (int2)( 2, 1 ) );

	lumaBlur += lumaP( pSrc, nRowPixels, nPlanePixels, pos + (int2)( -2, 2 ) ) + 2.f * lumaP( pSrc, nRowPixels, nPlanePixels, pos + (int2)( -1, 2 ) ) +
		4.f * lumaP( pSrc, nRowPixels, nPlanePixels, pos + (int2)( 0, 2 ) ) + 2.f * lumaP( pSrc, nRowPixels, nPlanePixels, pos + (int2)( 1, 2 ) ) +
		lumaP( pSrc, nRowPixels, nPlanePixels, pos + (int2)( 2, 2 ) );

	lumaBlur = lumaBlur * 0.01;

	//	subtract blurr from original luma
	float	fSharp = lumaOrig - lumaBlur;
	float	fAbsDif, fTmp;

	//	apply strength to difference
	fSharp *= fSharpness;

	//	get the absolute value
	fAbsDif = fabs( fSharp );

	//	do cutoff here...
	//	calculate the diff when it's between the cutoff & ss
	fTmp = ( ( fAbsDif - fCutoff ) * fSharp ) * fInvCutoff;

	//	if adiff < cutoff ... vTmp = 0 else vTmp remains as above
	fTmp = fAbsDif < fCutoff ? 0.f : fTmp;

	//	if adiff < ss ... vDif = vTmp else vDif remains the same
	fSharp = fAbsDif < fSS ? fTmp : fSharp;

	fSharp *= fMipDiv;
	fSharp += nMip > 0 ? fSharp * 0.5f : 0.f;

	//	we now have the sharpened luma, apply it to each color channel
	//	add the sharpened luminance change to the original color
	r += fSharp;
	g += fSharp;
	b += fSharp;

	//	clamp to 0 (don't want any negative values)
	r = max( r, 0.f );
	g = max( g, 0.f );
	b = max( b, 0.f );

	//	store to output image
	if (destFormat == 0)
	{
		pDst[pos.x + pos.y * nRowPixels]                    = r;
		pDst[pos.x + pos.y * nRowPixels + nPlanePixels]     = g;
		pDst[pos.x + pos.y * nRowPixels + 2 * nPlanePixels] = b;
	}
	else
	{
		__global unsigned short int *pShortDst = (__global unsigned short int *)(pDst);

		int	ri, gi, bi;

		//	clamp to the ushort range [0..65535]
		ri = clamp( (int)( r * fWhite + 0.5f ), 0, 65535 );
		gi = clamp( (int)( g * fWhite + 0.5f ), 0, 65535 );
		bi = clamp( (int)( b * fWhite + 0.5f ), 0, 65535 );

		pShortDst[pos.x + pos.y * nRowPixels]                    = (ushort)(ri);
		pShortDst[pos.x + pos.y * nRowPixels + nPlanePixels]     = (ushort)(gi);
		pShortDst[pos.x + pos.y * nRowPixels + 2 * nPlanePixels] = (ushort)(bi);
	}
}

//-----------------------------------------------------------------------------
float lumaC( __global float4 const * pSrc, uint nRowPixels, int2 pos )
{
	float4	clr = pSrc[pos.x + pos.y * nRowPixels / 4];

	return LUMA( clr );
}

//-----------------------------------------------------------------------------
__kernel void rgbSharpen_Chunky( __global float4 * pDst,
								 __global float4 const * pSrc,
								 uint nRowPixels, uint nPlanePixels,
								 int nMip, float fSharpness, int nSensitivity )
{
	int2	pos = (int2)( get_global_id(0), get_global_id(1) );

	//	save the original color
	float4	clr = pSrc[pos.x + pos.y * nRowPixels / 4];

	//	pixels in the pad get coppied through
	if ( pos.x < 2 || pos.y < 2 || pos.x >= (int)get_global_size(0) - 2 || pos.y >= (int)get_global_size(1) - 2 )
	{
		pDst[pos.x + pos.y * nRowPixels / 4] = clr;
		return;
	}

	//	save the original luma
	float	lumaOrig = LUMA( clr );
	float	lumaBlur = 0.f;
	float	fMipDiv = 1.f / ( 1 << nMip );
	float	fSS = ( nSensitivity * 128.f ) / 65535.f;
	float	fCutoff = fSS * 0.5f;
	float	fInvCutoff = 1.f / fCutoff;

	//	convert each color to luminance and apply the following kernel:
	//	1  2  4  2  1
	//	2  4  8  4  2
	//	4  8 16  8  4
	//	2  4  8  4  2
	//	1  2  4  2  1

	lumaBlur += lumaC( pSrc, nRowPixels, pos + (int2)( -2, -2 ) ) + 2.f * lumaC( pSrc, nRowPixels, pos + (int2)( -1, -2 ) ) +
		4.f * lumaC( pSrc, nRowPixels, pos + (int2)( 0, -2 ) ) + 2.f * lumaC( pSrc, nRowPixels, pos + (int2)( 1, -2 ) ) +
		lumaC( pSrc, nRowPixels, pos + (int2)( 2, -2 ) );

	lumaBlur += 2.f * lumaC( pSrc, nRowPixels, pos + (int2)( -2, -1 ) ) + 4.f * lumaC( pSrc, nRowPixels, pos + (int2)( -1, -1 ) ) +
		8.f * lumaC( pSrc, nRowPixels, pos + (int2)( 0, -1 ) ) + 4.f * lumaC( pSrc, nRowPixels, pos + (int2)( 1, -1 ) ) +
		2.f * lumaC( pSrc, nRowPixels, pos + (int2)( 2, -1 ) );

	lumaBlur += 4.f * lumaC( pSrc, nRowPixels, pos + (int2)( -2, 0 ) ) + 8.f * lumaC( pSrc, nRowPixels, pos + (int2)( -1, 0 ) ) +
		16.f * lumaOrig + 8.f * lumaC( pSrc, nRowPixels, pos + (int2)( 1, 0 ) ) +
		4.f * lumaC( pSrc, nRowPixels, pos + (int2)( 2, 0 ) );

	lumaBlur += 2.f * lumaC( pSrc, nRowPixels, pos + (int2)( -2, 1 ) ) + 4.f * lumaC( pSrc, nRowPixels, pos + (int2)( -1, 1 ) ) +
		8.f * lumaC( pSrc, nRowPixels, pos + (int2)( 0, 1 ) ) + 4.f * lumaC( pSrc, nRowPixels, pos + (int2)( 1, 1 ) ) +
		2.f * lumaC( pSrc, nRowPixels, pos + (int2)( 2, 1 ) );

	lumaBlur += lumaC( pSrc, nRowPixels, pos + (int2)( -2, 2 ) ) + 2.f * lumaC( pSrc, nRowPixels, pos + (int2)( -1, 2 ) ) +
		4.f * lumaC( pSrc, nRowPixels, pos + (int2)( 0, 2 ) ) + 2.f * lumaC( pSrc, nRowPixels, pos + (int2)( 1, 2 ) ) +
		lumaC( pSrc, nRowPixels, pos + (int2)( 2, 2 ) );

	lumaBlur = lumaBlur * 0.01;

	//	subtract blurr from original luma
	float	fSharp = lumaOrig - lumaBlur;
	float	fAbsDif, fTmp;

	//	apply strength to difference
	fSharp *= fSharpness;

	//	get the absolute value
	fAbsDif = fabs( fSharp );

	//	do cutoff here...
	//	calculate the diff when it's between the cutoff & ss
	fTmp = ( ( fAbsDif - fCutoff ) * fSharp ) * fInvCutoff;

	//	if adiff < cutoff ... vTmp = 0 else vTmp remains as above
	fTmp = fAbsDif < fCutoff ? 0.f : fTmp;

	//	if adiff < ss ... vDif = vTmp else vDif remains the same
	fSharp = fAbsDif < fSS ? fTmp : fSharp;

	fSharp *= fMipDiv;
	fSharp += nMip > 0 ? fSharp * 0.5f : 0.f;

	//	we now have the sharpened luma, apply it to each color channel
	//	add the sharpened luminance change to the original color
	clr.xyz += fSharp;

	//	clamp to 0 (don't want any negative values)
	clr = max( clr, 0.f );
	//	clr = min( clr, 1.f );

	//	store to output image
	pDst[pos.x + pos.y * nRowPixels / 4] = clr;
}

//-----------------------------------------------------------------------------
__constant sampler_t imageSampler = CLK_NORMALIZED_COORDS_FALSE | CLK_ADDRESS_CLAMP | CLK_FILTER_NEAREST;


//-----------------------------------------------------------------------------
float luma( __read_only image2d_t img, int2 pos )
{
	float4	clr = read_imagef( img, imageSampler, pos );

	//	From the SharpenFilter
	//	quasi luminance (probably a lot faster with little visual difference)
	//	.25 * r + .625 * g + .125 * b
	float	f = LUMA( clr );

	return f;
}

//-----------------------------------------------------------------------------
__kernel void rgbSharpen_Image2D( __write_only image2d_t dstImg,
								  __read_only image2d_t srcImg,
								  int nMip, float fSharpness, int nSensitivity )
{
	int2	pos = (int2)( get_global_id(0), get_global_id(1) );

	//	save the original color
	float4	clr = read_imagef( srcImg, imageSampler, pos );

	//	pixels in the pad get coppied through
	if ( pos.x < 2 || pos.y < 2 || pos.x >= (int)get_global_size(0) - 2 || pos.y >= (int)get_global_size(1) - 2 )
	{
		write_imagef( dstImg, pos, clr );
		return;
	}

	//	save the original luma
	float	lumaOrig = LUMA( clr );
	float	lumaBlur = 0.f;
	float	fMipDiv = 1.f / ( 1 << nMip );
	float	fSS = ( nSensitivity * 128.f ) / 65535.f;
	float	fCutoff = fSS * 0.5f;
	float	fInvCutoff = 1.f / fCutoff;

	//	convert each color to luminance and apply the following kernel:
	//	1  2  4  2  1
	//	2  4  8  4  2
	//	4  8 16  8  4
	//	2  4  8  4  2
	//	1  2  4  2  1

	lumaBlur += luma( srcImg, pos + (int2)( -2, -2 ) ) + 2.f * luma( srcImg, pos + (int2)( -1, -2 ) ) +
		4.f * luma( srcImg, pos + (int2)( 0, -2 ) ) + 2.f * luma( srcImg, pos + (int2)( 1, -2 ) ) +
		luma( srcImg, pos + (int2)( 2, -2 ) );

	lumaBlur += 2.f * luma( srcImg, pos + (int2)( -2, -1 ) ) + 4.f * luma( srcImg, pos + (int2)( -1, -1 ) ) +
		8.f * luma( srcImg, pos + (int2)( 0, -1 ) ) + 4.f * luma( srcImg, pos + (int2)( 1, -1 ) ) +
		2.f * luma( srcImg, pos + (int2)( 2, -1 ) );

	lumaBlur += 4.f * luma( srcImg, pos + (int2)( -2, 0 ) ) + 8.f * luma( srcImg, pos + (int2)( -1, 0 ) ) +
		16.f * lumaOrig + 8.f * luma( srcImg, pos + (int2)( 1, 0 ) ) +
		4.f * luma( srcImg, pos + (int2)( 2, 0 ) );

	lumaBlur += 2.f * luma( srcImg, pos + (int2)( -2, 1 ) ) + 4.f * luma( srcImg, pos + (int2)( -1, 1 ) ) +
		8.f * luma( srcImg, pos + (int2)( 0, 1 ) ) + 4.f * luma( srcImg, pos + (int2)( 1, 1 ) ) +
		2.f * luma( srcImg, pos + (int2)( 2, 1 ) );

	lumaBlur += luma( srcImg, pos + (int2)( -2, 2 ) ) + 2.f * luma( srcImg, pos + (int2)( -1, 2 ) ) +
		4.f * luma( srcImg, pos + (int2)( 0, 2 ) ) + 2.f * luma( srcImg, pos + (int2)( 1, 2 ) ) +
		luma( srcImg, pos + (int2)( 2, 2 ) );

	lumaBlur = lumaBlur * 0.01;

	//	subtract blurr from original luma
	float	fSharp = lumaOrig - lumaBlur;
	float	fAbsDif, fTmp;

	//	apply strength to difference
	fSharp *= fSharpness;

	//	get the absolute value
	fAbsDif = fabs( fSharp );

	//	do cutoff here...
	//	calculate the diff when it's between the cutoff & ss
	fTmp = ( ( fAbsDif - fCutoff ) * fSharp ) * fInvCutoff;

	//	if adiff < cutoff ... vTmp = 0 else vTmp remains as above
	fTmp = fAbsDif < fCutoff ? 0.f : fTmp;

	//	if adiff < ss ... vDif = vTmp else vDif remains the same
	fSharp = fAbsDif < fSS ? fTmp : fSharp;

	fSharp *= fMipDiv;
	fSharp += nMip > 0 ? fSharp * 0.5f : 0.f;

	//	we now have the sharpened luma, apply it to each color channel
	//	add the sharpened luminance change to the original color
	clr.xyz += fSharp;

	//	clamp to 0 (don't want any negative values)
	clr = max( clr, 0.f );
//	clr = min( clr, 1.f );

	//	store to output image
	write_imagef( dstImg, pos, clr );
}

//-----------------------------------------------------------------------------


// buildOptions=
// RUN: %occ-cli %s --cl-options="-I%cwd -I%S " %cfg_path --cl-device=%cl_device 2>&1
