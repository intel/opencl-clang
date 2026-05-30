//-----------------------------------------------------------------------------
#define	CLIP_MIN 1.f
#define EPS_ZERO 0.001f

float3 rgbToHsv_Hr( const float3 rgb, const float fRange );
float3 hsvToRgb( float3 hsv );

//-----------------------------------------------------------------------------
float3 rgbToHsv_Hr( const float3 rgb, const float fRange )
{
	float	minOrig, maxOrig, delta;
	float	minClip, maxClip;
	float	h, s, v;
	float3	rgbClip;

	//	values clamped to 0..1
	rgbClip = min( rgb, CLIP_MIN );

	//	max & min of original values
	minOrig = min( min( rgb.x, rgb.y ), rgb.z );
	maxOrig = max( max( rgb.x, rgb.y ), rgb.z );

	//	max & min of clipped values
	minClip = min( min( rgbClip.x, rgbClip.y ), rgbClip.z );
	maxClip = max( max( rgbClip.x, rgbClip.y ), rgbClip.z );

	//	calculate V
	v = ( maxOrig - 1.f ) * fRange;
	v = v * v + 1.f;

	delta = maxClip - minClip;

	if ( maxClip > EPS_ZERO )
		s = delta / maxClip;
	else
	{
		s = 0.f;
		h = 0.f;
		return (float3)( h, s, v );
	}

	if ( fabs( delta ) <= EPS_ZERO )
	{
		h = 0.f;
		s = 0.f;
	}
	else if ( rgbClip.x == maxClip )
		h = 6.f + ( rgbClip.y - rgbClip.z ) / delta;			// between yellow & magenta
	else if ( rgbClip.y == maxClip )
		h = 2.f + ( rgbClip.z - rgbClip.x ) / delta;	// between cyan & yellow
	else
		h = 4.f + ( rgbClip.x - rgbClip.y ) / delta;	// between magenta & cyan

//	h *= 60.f;				// degrees

	//	hue will be from [0..6)
	if ( h < 0.f )
		h += 6.f;
	if ( h >= 6.f )
		h -= 6.f;

	return (float3)( h, s, v );
}

//-----------------------------------------------------------------------------
float3 hsvToRgb( float3 hsv )
{
	int		i;
	float	f, p, q, t;
	float	r, g, b;

	//	if s == 0
//	if ( hsv.y < EPS_ZERO )
	if ( hsv.y == 0.f )
	{
		//	achromatic (grey) - V
		return (float3)( hsv.z );
	}

//	hsv.x /= 60.f;

	//	integer part of hue puts us in sector 0 to 5
	i = (int)floor( hsv.x );

	// factorial part of h
	f = hsv.x - i;

	p = hsv.z * ( 1.f - hsv.y );
	q = hsv.z * ( 1.f - hsv.y * f );
	t = hsv.z * ( 1.f - hsv.y * ( 1.f - f ) );

	switch ( i )
	{
		case 0:
			r = hsv.z;
			g = t;
			b = p;
			break;

		case 1:
			r = q;
			g = hsv.z;
			b = p;
			break;

		case 2:
			r = p;
			g = hsv.z;
			b = t;
			break;

		case 3:
			r = p;
			g = q;
			b = hsv.z;
			break;

		case 4:
			r = t;
			g = p;
			b = hsv.z;
			break;

		default:
		case 5:
			r = hsv.z;
			g = p;
			b = q;
			break;
	}

	return (float3)( r, g, b );
}

//-----------------------------------------------------------------------------
__kernel void highlights_Planar( __global float * pDst,
								 __global float const * pSrc,
								 uint nRowPixels, uint nPlanePixels,
								 const float fRange )
{
	float3	rgb, hsv;
	int2	pos = (int2)( get_global_id(0), get_global_id(1) );

	rgb.x = pSrc[pos.x + pos.y * nRowPixels];
	rgb.y = pSrc[pos.x + pos.y * nRowPixels + nPlanePixels];
	rgb.z = pSrc[pos.x + pos.y * nRowPixels + 2 * nPlanePixels];

	//	if all components are below the threshold then do nothing
	if ( rgb.x <= CLIP_MIN && rgb.y <= CLIP_MIN && rgb.z <= CLIP_MIN )
	{
		//	copy into the destination image
		pDst[pos.x + pos.y * nRowPixels]                    = rgb.x;
		pDst[pos.x + pos.y * nRowPixels + nPlanePixels]     = rgb.y;
		pDst[pos.x + pos.y * nRowPixels + 2 * nPlanePixels] = rgb.z;
		return;
	}

	//	convert to HSV using our special highlight RGB to HSV conversion
	hsv = rgbToHsv_Hr( rgb, fRange );

	//	convert back to RGB
	rgb = hsvToRgb( hsv );

	//	store to the destination image
	pDst[pos.x + pos.y * nRowPixels]                    = rgb.x;
	pDst[pos.x + pos.y * nRowPixels + nPlanePixels]     = rgb.y;
	pDst[pos.x + pos.y * nRowPixels + 2 * nPlanePixels] = rgb.z;
}

//-----------------------------------------------------------------------------
__kernel void highlights_Chunky( __global float4 * pDst,
								 __global float4 const * pSrc,
								 uint nRowPixels, uint nPlanePixels,
								 const float fRange )
{
	int2	pos = (int2)( get_global_id(0), get_global_id(1) );

	//	read the original color
	float4	clr = pSrc[pos.x + pos.y * nRowPixels / 4];
	float3	rgb, hsv;

	rgb = clr.xyz;

	//	if all components are below the threshold then do nothing
	if ( rgb.x <= CLIP_MIN && rgb.y <= CLIP_MIN && rgb.z <= CLIP_MIN )
	{
		//	copy into the destination image
		pDst[pos.x + pos.y * nRowPixels / 4] = clr;
		return;
	}

	//	convert to HSV using our special highlight RGB to HSV conversion
	hsv = rgbToHsv_Hr( rgb, fRange );

	//	convert back to RGB
	rgb = hsvToRgb( hsv );

	//	store to the destination image
	clr.xyz = rgb;
	pDst[pos.x + pos.y * nRowPixels / 4] = clr;
}

//-----------------------------------------------------------------------------
__constant sampler_t imageSampler = CLK_NORMALIZED_COORDS_FALSE | CLK_ADDRESS_CLAMP | CLK_FILTER_NEAREST;

//-----------------------------------------------------------------------------
__kernel void rgbSharpen_Image2D( __write_only image2d_t dstImg,
								  __read_only image2d_t srcImg,
								  const float fRange )
{
	int2	pos = (int2)( get_global_id(0), get_global_id(1) );

	//	read the original color
	float4	clr = read_imagef( srcImg, imageSampler, pos );
	float3	rgb, hsv;

	rgb = clr.xyz;

	//	if all components are below the threshold then do nothing
	if ( rgb.x <= CLIP_MIN && rgb.y <= CLIP_MIN && rgb.z <= CLIP_MIN )
	{
		//	copy into the destination image
		write_imagef( dstImg, pos, clr );
		return;
	}

	//	convert to HSV using our special highlight RGB to HSV conversion
	hsv = rgbToHsv_Hr( rgb, fRange );

	//	convert back to RGB
	rgb = hsvToRgb( hsv );

	//	store to the destination image
	clr.xyz = rgb;
	write_imagef( dstImg, pos, clr );
}

//-----------------------------------------------------------------------------


// buildOptions=
// RUN: %occ-cli %s --cl-options="-I%cwd -I%S " %cfg_path --cl-device=%cl_device 2>&1
