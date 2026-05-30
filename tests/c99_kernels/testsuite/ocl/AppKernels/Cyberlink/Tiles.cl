

#define MATH_PI		    3.1415926535897932384626433832795f
// 2D iteration
__kernel void Tiles_Global(__global const uchar4* src, __global uchar4* dst, int width, int height,
int blockWidth, int blockHeight, float fPercentage, float radius, unsigned int getAlphaType)
{
	//int index = get_global_id(0);
	//int jOriginalCoord = index / width;
	//int iOriginalCoord = index % width;

	int iOriginalCoord = get_global_id(0);
	int jOriginalCoord = get_global_id(1);
	int index = iOriginalCoord + jOriginalCoord*width;

	//--------------------
	//| 1 | 2 | 3 | 4 |
	//|-----------------|
	//| 5 | 6 | 7 | 8 |
	//|-----------------|

	int iBlockNum = (iOriginalCoord/blockWidth)+1;
	int jBlockNum = (jOriginalCoord/blockHeight)+1;
	int iCounter;

	if( 0==(width%blockWidth) )
		iCounter = (jBlockNum-1)*((width/blockWidth)) + iBlockNum;
	else
		iCounter = (jBlockNum-1)*((width/blockWidth)+1) + iBlockNum;

	int w = blockWidth * (iBlockNum-1);
	int h = blockHeight * (jBlockNum-1);

	float t = fPercentage * (2.0f - fPercentage);	// Non-linear progress change.
	float angle = MATH_PI * 13.0f / 16.0f * (iCounter);

	float StartX = w + radius * cos(angle);
	float StartY = h + radius * sin(angle);

	int nw = (StartX + (w - StartX) * t);
	int nh = (StartY + (h - StartY) * t);

	int i = iOriginalCoord % blockWidth;
	int j = jOriginalCoord % blockHeight;

	int oldx = w + i;
	int oldy = h + j;
	int newx = nw + i;
	int newy = nh + j;

	if( newx<0 || newy< 0 || newx>=width || newy>= height || oldx<0 || oldy< 0 || oldx>=width || oldy>= height )
		return;

	int newIndex = nh*width + nw + j*width + i;

	uchar4 tempSrc = src[index];
	uchar4 tempDst;
	uchar4 tempHigh = 255;
	uchar4 tempLow = 0;

	if( i==0 || j==0 )
	{
		tempDst.x = max( 0, min(tempSrc.x+50, 255) );
		tempDst.y = max( 0, min(tempSrc.y+50, 255) );
		tempDst.z = max( 0, min(tempSrc.z+50, 255) );
	}
	else if( i==(blockWidth-1) || j==(blockHeight-1) || oldx==0||oldy==0||oldx==width-1||oldy==height-1)
	{
		tempDst.x = max( 0, min(tempSrc.x-50, 255) );
		tempDst.y = max( 0, min(tempSrc.y-50, 255) );
		tempDst.z = max( 0, min(tempSrc.z-50, 255) );
	}
	else
	{
		tempDst.x = tempSrc.x;
		tempDst.y = tempSrc.y;
		tempDst.z = tempSrc.z;
	}

	if(getAlphaType == 1)
		tempDst.w = tempSrc.w;
	else if(getAlphaType == 2)
		tempDst.w = 255;

	dst[newIndex] = tempDst;
}//kernel end

#if 0
// 1D iteration
__kernel void Tiles_Global(__global const uchar4* src, __global uchar4* dst, int width, int height,
int blockWidth, int blockHeight, float fPercentage, float radius, unsigned char getAlphaType)
{
	int index = get_global_id(0);

	int jOriginalCoord = index / width;
	int iOriginalCoord = index % width;

	//--------------------
	//| 1 | 2 | 3 | 4 |
	//|-----------------|
	//| 5 | 6 | 7 | 8 |
	//|-----------------|

	int iBlockNum = (iOriginalCoord/blockWidth)+1;
	int jBlockNum = (jOriginalCoord/blockHeight)+1;
	int iCounter;

	if( 0==(width%blockWidth) )
		iCounter = (jBlockNum-1)*((width/blockWidth)) + iBlockNum;
	else
		iCounter = (jBlockNum-1)*((width/blockWidth)+1) + iBlockNum;

	int w = blockWidth * (iBlockNum-1);
	int h = blockHeight * (jBlockNum-1);

	float t = fPercentage * (2.0f - fPercentage);	// Non-linear progress change.
	float angle = MATH_PI * 13.0f / 16.0f * (iCounter);

	float StartX = w + radius * cos(angle);
	float StartY = h + radius * sin(angle);

	int nw = (StartX + (w - StartX) * t);
	int nh = (StartY + (h - StartY) * t);

	int i = iOriginalCoord % blockWidth;
	int j = jOriginalCoord % blockHeight;

	int oldx = w + i;
	int oldy = h + j;
	int newx = nw + i;
	int newy = nh + j;

	if( newx<0 || newy< 0 || newx>=width || newy>= height || oldx<0 || oldy< 0 || oldx>=width || oldy>= height )
		return;

	int newIndex = nh*width + nw + j*width + i;

	uchar4 tempSrc = src[index];
	uchar4 tempDst;
	uchar4 tempHigh = 255;
	uchar4 tempLow = 0;

	if( i==0 || j==0 )
	{
		tempDst.x = max( 0, min(tempSrc.x+50, 255) );
		tempDst.y = max( 0, min(tempSrc.y+50, 255) );
		tempDst.z = max( 0, min(tempSrc.z+50, 255) );
	}
	else if( i==(blockWidth-1) || j==(blockHeight-1) || oldx==0||oldy==0||oldx==width-1||oldy==height-1)
	{
		tempDst.x = max( 0, min(tempSrc.x-50, 255) );
		tempDst.y = max( 0, min(tempSrc.y-50, 255) );
		tempDst.z = max( 0, min(tempSrc.z-50, 255) );
	}
	else
	{
		tempDst.x = tempSrc.x;
		tempDst.y = tempSrc.y;
		tempDst.z = tempSrc.z;
	}

	if(getAlphaType == 1)
		tempDst.w = tempSrc.w;
	else if(getAlphaType == 2)
		tempDst.w = 255;

	dst[newIndex] = tempDst;
}//kernel end
#endif


// buildOptions=
// RUN: %occ-cli %s --cl-options="-I%cwd -I%S " %cfg_path --cl-device=%cl_device 2>&1
