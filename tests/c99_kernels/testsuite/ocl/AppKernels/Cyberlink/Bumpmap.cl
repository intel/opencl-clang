#if 1
// 2D version
__kernel void Bumpmap_Global(__global const uchar4* src, __global uchar4* dst, int width, int height,
int fxScale, int p1, int p2, unsigned char getAlphaType)
{
	//int index = get_global_id(0);

	//int y = index / width;
	//int x = index % width;
	int x = get_global_id(0);
	int y = get_global_id(1);
	int index = y*width+x;


	uchar4 tempSrc = src[index];
	uchar4 tempDst;
	int temp;

	if( 0 == y )
		tempDst = tempSrc;
	else if( (height-1) == y )
		tempDst = tempSrc;
	else
	{
		if( 0 == x )
			tempDst = tempSrc;
		else if( (width-1) == x )
			tempDst = tempSrc;
		else
		{
			temp = ( 1053*(src[index+p1].z - src[index+p2].z) + 2064*(src[index+p1].y - src[index+p2].y) + 401*(src[index+p1].x - src[index+p2].x) ) >> 12;

			temp = ( fxScale * temp ) >> 16;

			int R = (int)(tempSrc.z) + temp;
			if ( R > 255 )
				tempDst.z = 255;
			else if ( R < 0 )
				tempDst.z = 0;
			else
				tempDst.z = R;

			int G = (int)(tempSrc.y) + temp;
			if ( G > 255 )
				tempDst.y = 255;
			else if ( G < 0 )
				tempDst.y = 0;
			else
				tempDst.y = G;

			int B = (int)(tempSrc.x) + temp;
			if ( B > 255 )
				tempDst.x = 255;
			else if ( B < 0 )
				tempDst.x = 0;
			else
				tempDst.x = B;
		}
	}

	if(getAlphaType == 1)
		tempDst.w = tempSrc.w;
	else if(getAlphaType == 2)
		tempDst.w = 255;

	dst[index] = tempDst;

}//kernel end
#endif

#if 0
// 1D
__kernel void Bumpmap_Global(__global const uchar4* src, __global uchar4* dst, int width, int height,
int fxScale, int p1, int p2, unsigned char getAlphaType)
{
	int index = get_global_id(0);

	int y = index / width;
	int x = index % width;

	uchar4 tempSrc = src[index];
	uchar4 tempDst;
	int temp;

	if( 0 == y )
		tempDst = tempSrc;
	else if( (height-1) == y )
		tempDst = tempSrc;
	else
	{
		if( 0 == x )
			tempDst = tempSrc;
		else if( (width-1) == x )
			tempDst = tempSrc;
		else
		{
			temp = ( 1053*(src[index+p1].z - src[index+p2].z) + 2064*(src[index+p1].y - src[index+p2].y) + 401*(src[index+p1].x - src[index+p2].x) ) >> 12;

			temp = ( fxScale * temp ) >> 16;

			int R = (int)(tempSrc.z) + temp;
			if ( R > 255 )
				tempDst.z = 255;
			else if ( R < 0 )
				tempDst.z = 0;
			else
				tempDst.z = R;

			int G = (int)(tempSrc.y) + temp;
			if ( G > 255 )
				tempDst.y = 255;
			else if ( G < 0 )
				tempDst.y = 0;
			else
				tempDst.y = G;

			int B = (int)(tempSrc.x) + temp;
			if ( B > 255 )
				tempDst.x = 255;
			else if ( B < 0 )
				tempDst.x = 0;
			else
				tempDst.x = B;
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
