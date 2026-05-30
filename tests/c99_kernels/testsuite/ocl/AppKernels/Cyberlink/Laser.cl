// 2D

#if 1
// 2D
__kernel void Laser_Global(__global const uchar4* src, __global uchar4* dst, int width, int height,
__global const int* nRadiusTbl, __global const int* nInverseTbl, int currRadius, int  halfWidth, int halfHeight,
__global const int* nYOffset, unsigned char getAlphaType)
{
	int x = get_global_id(0);
	int y = get_global_id(1);
	int index = y*width+x;
	int srcIndex;// = index;

	int radius = nRadiusTbl[index];

	//if(radius > currRadius)
	{
		int invRadius = nInverseTbl[radius];
		int currMultInvRadius = currRadius * invRadius;

		int srcX = ((x-halfWidth) * currMultInvRadius >> 19) + halfWidth;
		int srcY = ((y-halfHeight) * currMultInvRadius >> 19) + halfHeight;

		srcIndex = nYOffset[srcY] + srcX;
	}

	srcIndex = (radius > currRadius)? srcIndex : index;

	dst[index] = src[srcIndex];


	dst[index].w = (getAlphaType == 1)? src[index].w : (getAlphaType == 2)? 255 : dst[index].w;

}

#else

__kernel void Laser_Global(__global const uchar4* src, __global uchar4* dst, int width, int height,
__global const int* nRadiusTbl, __global const int* nInverseTbl, int currRadius, int  halfWidth, int halfHeight,
__global const int* nYOffset, unsigned char getAlphaType)
{
	int x = get_global_id(0);
	int y = get_global_id(1);
	int index = y*width+x;

	int radius = nRadiusTbl[index];

	if(radius > currRadius)
	{
		int invRadius = nInverseTbl[radius];
		int currMultInvRadius = currRadius * invRadius;

		int srcX = ((x-halfWidth) * currMultInvRadius >> 19) + halfWidth;
		int srcY = ((y-halfHeight) * currMultInvRadius >> 19) + halfHeight;

		int newIndex = nYOffset[srcY] + srcX;

		dst[index] = src[newIndex];
	}
	else
	{
		dst[index] = src[index];
	}

	if(getAlphaType == 1)
		dst[index].w = src[index].w;
	else if(getAlphaType == 2)
		dst[index].w = 255;
}

#endif

#if 0
__kernel void Laser_Global(__global const uchar4* src, __global uchar4* dst, int width, int height,
__global const int* nRadiusTbl, __global const int* nInverseTbl, int currRadius, int  halfWidth, int halfHeight,
__global const int* nYOffset, unsigned char getAlphaType)
{
	int index = get_global_id(0);

	int y = index / width;
	int x = index % width;

	int radius = nRadiusTbl[index];

	if(radius > currRadius)
	{
		int invRadius = nInverseTbl[radius];
		int currMultInvRadius = currRadius * invRadius;

		int srcX = ((x-halfWidth) * currMultInvRadius >> 19) + halfWidth;
		int srcY = ((y-halfHeight) * currMultInvRadius >> 19) + halfHeight;

		int newIndex = nYOffset[srcY] + srcX;

		dst[index] = src[newIndex];
	}
	else
	{
		dst[index] = src[index];
	}

	if(getAlphaType == 1)
		dst[index].w = src[index].w;
	else if(getAlphaType == 2)
		dst[index].w = 255;
}
#endif


// buildOptions=
// RUN: %occ-cli %s --cl-options="-I%cwd -I%S " %cfg_path --cl-device=%cl_device 2>&1
