
__kernel void TVSimulator_Global(__global const uchar4* src, __global uchar4* dst, int width, int height, unsigned char getAlphaType)
{
	int index = get_global_id(0);

	int y = index / width;
	int x = index - width * y;

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

	tempDst.w = (getAlphaType == 1) ? tempSrc.w : tempDst.w;
   	tempDst.w = (getAlphaType == 2) ? 255 : tempDst.w;

	dst[index] = tempDst;
}



// ASSUMES WIDTH IS MULTIPLE OF 4!!!
__kernel void TVSimulator_Global0(__global const uint4* src, __global uint4* dst, int width, int height )
{
	int x = get_global_id(0);
	int y = get_global_id(1);
	int	width4 = width >> 2;

	y = 3*y;
	int index = y*width4+x;

	uint4 tempSrc = src[index];
	uint4 tempDst;

	uint4 temp1 = 0x0ff;
	uint4 temp2 = 2 * (tempSrc & 0x0ff);
	uint4	blue = min( temp1, temp2 );
	tempSrc = (tempSrc & ~0x0ff) | blue;
	dst[index] = tempSrc;

	y++;
	if( y < height )
	{
		index = y*width4+x;
		tempSrc = src[index];

		temp1 = 0x0ff00;
		temp2 = 2 * (tempSrc  & 0x0ff00);
		uint4	green = min( temp1, temp2 );
		tempSrc = (tempSrc & ~0x0ff00) | green;
		dst[index] = tempSrc;
	}

	y++;
	if( y < height )
	{
		index = y*width4+x;
		tempSrc = src[index];

		temp1 = 0x0ff0000;
		temp2 = 2 * ((tempSrc) & 0x0ff0000);
		uint4	red = min( temp1, temp2 );
		tempSrc = (tempSrc & ~0x0ff0000) | red;
		dst[index] = tempSrc;
	}

}


__kernel void TVSimulator_Global1(__global const uint4* src, __global uint4* dst, int width, int height)
{
	int x = get_global_id(0);
	int y = get_global_id(1);
	int	width4 = width >> 2;

	y = 3*y;

	int index = y*width4+x;

	uint4 tempSrc = src[index];
	uint4 tempDst;

	uint4 temp1 = 0x0ff;
	uint4 temp2 = 2 * (tempSrc & 0x0ff);
	uint4	blue = min( temp1, temp2 );
	tempSrc = (tempSrc & ~0x0ff) | blue;
	dst[index] = tempSrc;

	y++;
	if( y < height )
	{
		index = y*width4+x;
		tempSrc = src[index];

		temp1 = 0x0ff00;
		temp2 = 2 * (tempSrc  & 0x0ff00);
		uint4	green = min( temp1, temp2 );
		tempSrc = (tempSrc & ~0x0ff00) | green;
		dst[index] = tempSrc;
	}

	y++;
	if( y < height )
	{
		index = y*width4+x;
		tempSrc = src[index];

		temp1 = 0x0ff0000;
		temp2 = 2 * ((tempSrc) & 0x0ff0000);
		uint4	red = min( temp1, temp2 );
		tempSrc = (tempSrc & ~0x0ff0000) | red;
		dst[index] = tempSrc;
	}

}


__kernel void TVSimulator_Global2(__global const uint4* src, __global uint4* dst, int width, int height)
{
	int x = get_global_id(0);
	int y = get_global_id(1);

	int	width4 = width >> 2;

	y = 3*y;

	int index = y*width4 + x;

	uint4 tempSrc = src[index];
	uint4 tempDst;

	uint4 temp1 = 0x0ff;
	uint4 temp2 = 2 * (tempSrc & 0x0ff);
	uint4	blue = min( temp1, temp2 );
	tempSrc = (tempSrc & ~0x0ff) | blue;
	tempSrc = tempSrc | 0xff000000;	// alpha set to 255
	dst[index] = tempSrc;

	y++;
	if( y < height )
	{
		index = y*width4 + x;
		tempSrc = src[index];

		temp1 = 0x0ff00;
		temp2 = 2 * (tempSrc  & 0x0ff00);
		uint4	green = min( temp1, temp2 );
		tempSrc = (tempSrc & ~0x0ff00) | green;
		tempSrc = tempSrc | 0xff000000;	// alpha set to 255
		dst[index] = tempSrc;
	}

	y++;
	if( y < height )
	{
		index = y*width4 + x;
		tempSrc = src[index];

		temp1 = 0x0ff0000;
		temp2 = 2 * ((tempSrc) & 0x0ff0000);
		uint4	red = min( temp1, temp2 );
		tempSrc = (tempSrc & ~0x0ff0000) | red;
		tempSrc = tempSrc | 0xff000000;	// alpha set to 255
		dst[index] = tempSrc;
	}

}

// buildOptions=
// RUN: %occ-cli %s --cl-options="-I%cwd -I%S " %cfg_path --cl-device=%cl_device 2>&1
