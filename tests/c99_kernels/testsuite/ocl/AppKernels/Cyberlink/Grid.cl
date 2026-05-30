// 2D iteration
__kernel void Grid_Global(__global const uchar4* src, __global uchar4* dst, int width, int height,
int gridWidth, int gridHeight, int depth, int bColor, unsigned char getAlphaType)
{
//	int index = get_global_id(0);
//	int y = index / width;
//	int x = index % width;

	int x = get_global_id(0);
	int y = get_global_id(1);
	int index = y*width+x;


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

	if(getAlphaType == 1)
		tempDst.w = tempSrc.w;
	else if(getAlphaType == 2)
		tempDst.w = 255;

	dst[index] = tempDst;

}//kernel end

#if 0
// 1D iteration
__kernel void Grid_Global(__global const uchar4* src, __global uchar4* dst, int width, int height,
int gridWidth, int gridHeight, int depth, int bColor, unsigned char getAlphaType)
{
	int index = get_global_id(0);

	int y = index / width;
	int x = index % width;

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

	if(getAlphaType == 1)
		tempDst.w = tempSrc.w;
	else if(getAlphaType == 2)
		tempDst.w = 255;

	dst[index] = tempDst;

}//kernel end
#endif


// buildOptions=
// RUN: %occ-cli %s --cl-options="-I%cwd -I%S " %cfg_path --cl-device=%cl_device 2>&1
