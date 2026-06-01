
__kernel	void	GridCopy( __global const uint4 *src, __global uint4 *dst, int width, int height, unsigned int getAlphaType )
{
	int	index = get_global_id(0);
	uint4	tmpDst = src[index];

	if( getAlphaType == 2 )
		tmpDst |= (uint4) 0xFF000000;

	dst[index] = tmpDst;
}

// 2D iteration
// Assumptions:		Will not be called if depth == 0 - copy instead.
//					GridWidth minimum is 2, no need to test for zero - true in C impl.
//					global size is divided by (gridWidth+depth),(gridHeight+depth), rounded up
//					bColor is RGB reversed to BGR by the host, to match the reversal in original
//					bColor.alpha == 0;  --  must be set by host, so can OR with src color alpha
// if getAlphaType != 2, alpha is from source, as in original source

__kernel void Grid_Global(__global const uint* src, __global uint* dst, int width, int height,
int gridWidth, int gridHeight, int depth, int bColor, unsigned char getAlphaType)
{
	int x = get_global_id(0);
	int y = get_global_id(1);

	int	xStep = gridWidth + depth;
	int	yStep = gridHeight + depth;

	x *=  xStep;
	y *=  yStep;

	int		xEdge = min( x + gridWidth, width);
	int		yEdge = min( y + gridHeight, height);

	int	index;

/*
	// Copy inner area
	for( int j = y; j < yEdge; j++ )
	{
		index =  j * width + x;
		for( int i = x; i < xEdge; i++ )
		{
			uint	tempDst = src[index];

			if( getAlphaType == 2 )
				tempDst |= 0xFF000000;		// wipe alpha to 0xFF

			dst[index] = tempDst;
			index++;
		}
	}
*/

	int	xLast = min( xEdge + depth, width );
	int	yLast = min( yEdge + depth, height );

	// vertical bar
	for( int j = y; j < yLast; j++ )
	{
		index =  j * width + xEdge;

		for( int i = xEdge; i < xLast; i++ )
		{
			uint	tempDst = bColor;	// bColor presumed to have 0xFF for alpha

			if( getAlphaType != 2 )
			{
				tempDst &= src[index] | 0x00FFFFFF;	// preserve src alpha
			}

			dst[index] = tempDst;
			index++;
		}
	}

	// horizontal bar
	for( int j = yEdge; j < yLast; j++ )
	{
		index = j * width + x;

		for( int i = x; i < xLast; i++ )
		{
			uint	tempDst = bColor;	// bColor presumed to have 0xFF for alpha

			if( getAlphaType != 2 )
			{
				tempDst &= src[index] | 0x00FFFFFF;	// preserve alpha
			}

			dst[index] = tempDst;
			index++;
		}
	}
}

////////////////////////////////////////////////////////////////////////////
// Original
////////////////////////////////////////////////////////////////////////////

/*
__kernel void Grid_Global_Original(__global const uchar4* src, __global uchar4* dst, int width, int height,
int gridWidth, int gridHeight, int depth, int bColor, unsigned char getAlphaType)
{
	int x = get_global_id(0);
	int y = get_global_id(1);
	int index = y * width + x;

	uchar4 tempSrc = src[index];
	uchar4 tempDst;

	unsigned char R = bColor & 0x000000ff;
	unsigned char G = (bColor & 0x0000ff00) >> 8;
	unsigned char B = (bColor & 0x00ff0000) >> 16;
	int range;

	tempDst = tempSrc;

	if( depth > 0 )
	{
		if( gridWidth > 0 )
		{
			range = x%(gridWidth+depth);
			if( gridWidth <= range && range < (gridWidth+depth) )
			{
				tempDst.x = B;
				tempDst.y = G;
				tempDst.z = R;
			}
		}
		if( gridHeight > 0 )
		{
			range = y%(gridHeight+depth);
			if( gridHeight <= range && range < (gridHeight+depth) )
			{
				tempDst.x = B;
				tempDst.y = G;
				tempDst.z = R;
			}
		}
	}

	tempDst.w = (getAlphaType == 1)? tempSrc.w : tempDst.w;
    tempDst.w = (getAlphaType == 2)? 255 : tempDst.w;

	dst[index] = tempDst;
}
*/

// buildOptions=
// RUN: %occ-cli %s --cl-options="-I%cwd -I%S " %cfg_path --cl-device=%cl_device 2>&1
