
__kernel void Tiles_Global(__global const uchar4* src, __global uchar4* dst, int width, int height,
int blockWidth, int blockHeight, int SrcStartX, int SrcStartY, int DstStartX, int DstStartY, unsigned char getAlphaType)
{
	int index = get_global_id(0);

	int j = index / blockWidth;
	int i = index - blockWidth * j;

	int OriX = SrcStartX + i;
	int OriY = SrcStartY + j;
	int NewX = DstStartX + i;
	int NewY = DstStartY + j;

	if( NewX < 0 || NewY < 0 || NewX >= width || NewY >= height || OriX < 0 || OriY < 0 || OriX >= width || OriY >= height )
		return;

	int OriIndex = OriY * width + OriX;
	int NewIndex = NewY * width + NewX;

	uchar4 tempSrc = src[OriIndex];
	uchar4 tempDst;

	if( i == 0 || j == 0 )
	{
		tempDst.x = max( 0, min(tempSrc.x + 50, 255) );
		tempDst.y = max( 0, min(tempSrc.y + 50, 255) );
		tempDst.z = max( 0, min(tempSrc.z + 50, 255) );
	}
	else if( i == (blockWidth - 1) || j == (blockHeight - 1) || OriX == 0 || OriY == 0 || OriX == (width - 1) || OriY == (height - 1) )
	{
		tempDst.x = max( 0, min(tempSrc.x - 50, 255) );
		tempDst.y = max( 0, min(tempSrc.y - 50, 255) );
		tempDst.z = max( 0, min(tempSrc.z - 50, 255) );
	}
	else
	{
		tempDst.x = tempSrc.x;
		tempDst.y = tempSrc.y;
		tempDst.z = tempSrc.z;
	}

	// tempDst.w = (getAlphaType == 1)? tempSrc.w : tempDst.w;
    // tempDst.w = (getAlphaType == 2)? 255 : tempDst.w;
	tempDst.w =  tempSrc.w ;
	dst[NewIndex] = tempDst;
}


// buildOptions=
// RUN: %occ-cli %s --cl-options="-I%cwd -I%S " %cfg_path --cl-device=%cl_device 2>&1
