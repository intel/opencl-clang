
// 2D iteration
__kernel void TVSimulator_Global(__global const uchar4* src, __global uchar4* dst, int width, int height, unsigned char getAlphaType)
{
	//int index = get_global_id(0);
	//int y = index / width;
	//int x = index % width;
	int x = get_global_id(0);
	int y = get_global_id(1);
	int index = y*width+x;

	uchar4 tempSrc = src[index];
	uchar4 tempDst;

	int condition = y % 3;

	if( 0 == condition )
	{
		tempDst.x = min( 2*tempSrc.x , 255 );
		tempDst.y = tempSrc.y;
		tempDst.z = tempSrc.z;
	}
	else if ( 1 == condition )
	{
		tempDst.x = tempSrc.x;
		tempDst.y = min( 2*tempSrc.y , 255 );
		tempDst.z = tempSrc.z;
	}
	else if( 2 == condition )
	{
		tempDst.x = tempSrc.x;
		tempDst.y = tempSrc.y;
		tempDst.z = min( 2*tempSrc.z , 255 );
	}

	if(getAlphaType == 1)
		tempDst.w = tempSrc.w;
	else if(getAlphaType == 2)
		tempDst.w = 255;

	dst[index] = tempDst;
}


#if 0
// 1D iteration
__kernel void TVSimulator_Global(__global const uchar4* src, __global uchar4* dst, int width, int height, unsigned char getAlphaType)
{
	int index = get_global_id(0);

	int y = index / width;
	int x = index % width;

	uchar4 tempSrc = src[index];
	uchar4 tempDst;

	int condition = y % 3;

	if( 0 == condition )
	{
		tempDst.x = min( 2*tempSrc.x , 255 );
		tempDst.y = tempSrc.y;
		tempDst.z = tempSrc.z;
	}
	else if ( 1 == condition )
	{
		tempDst.x = tempSrc.x;
		tempDst.y = min( 2*tempSrc.y , 255 );
		tempDst.z = tempSrc.z;
	}
	else if( 2 == condition )
	{
		tempDst.x = tempSrc.x;
		tempDst.y = tempSrc.y;
		tempDst.z = min( 2*tempSrc.z , 255 );
	}

	if(getAlphaType == 1)
		tempDst.w = tempSrc.w;
	else if(getAlphaType == 2)
		tempDst.w = 255;

	dst[index] = tempDst;
}
#endif


// buildOptions=
// RUN: %occ-cli %s --cl-options="-I%cwd -I%S " %cfg_path --cl-device=%cl_device 2>&1
