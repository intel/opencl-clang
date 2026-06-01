// 2D  - alphaType 0 - do not handle alpha
__kernel //__attribute(( reqd_work_group_size(8,8,1)))
 void Laser_alpha0_Global(__global const uint* src, __global uint4* dst, int width, //int height,
									float fcurRad, int  halfWidth, int halfHeight )
{
	int x4 = get_global_id(0);
	int x = x4 <<2;
	int y = get_global_id(1);
	int index  = y * width + x;
	int index4 = y * (width >> 2) + x4;

	float fWidth = (float)width;
	uint4 result;

	// First sample
	float xc = (float)(x - halfWidth);
	float yc = (float)(y - halfHeight);
	float ycSq = (float)(yc * yc);

	float radius = sqrt( mad( xc, xc, ycSq ) );
	float curMultInvRadius = fcurRad / radius;

	// Can NOT use "mad()" here - need to trunc negative values toward zero before add and make them positive!
	// Else get an off-by-one error for all negative values
	float srcX =  trunc( xc * curMultInvRadius ) + halfWidth;
	float srcY =  trunc( yc * curMultInvRadius ) + halfHeight;

	int srcIndex = (int)( mad( srcY, fWidth,  srcX ) );
	srcIndex = (radius > fcurRad ) ? srcIndex : index;

	result.x  = src[srcIndex];

	// 2nd sample
	xc += 1.0f;

	radius = sqrt( mad( xc, xc, ycSq ) );
	curMultInvRadius = fcurRad / radius;

	srcX =  trunc( xc * curMultInvRadius ) + halfWidth;
	srcY =  trunc( yc * curMultInvRadius ) + halfHeight;

	srcIndex = (radius > fcurRad ) ? (int) mad( srcY, fWidth,  srcX ) : index + 1;
	result.y = src[srcIndex];

	// 3rd sample
	xc += 1.0f;

	radius = sqrt( mad( xc, xc, ycSq ) );
	curMultInvRadius = fcurRad / radius;

	srcX =  trunc( xc * curMultInvRadius ) + halfWidth;
	srcY =  trunc( yc * curMultInvRadius ) + halfHeight;

	srcIndex = (radius > fcurRad ) ? (int) mad( srcY, fWidth,  srcX ) : index +2;
	result.z = src[srcIndex];

	// 4th sample
	xc += 1.0f;

	radius = sqrt( mad( xc, xc, ycSq ) );
	curMultInvRadius = fcurRad / radius;

	srcX =  trunc( xc * curMultInvRadius ) + halfWidth;
	srcY =  trunc( yc * curMultInvRadius ) + halfHeight;

	srcIndex = (radius > fcurRad ) ? (int) mad( srcY, fWidth,  srcX ) : index+3;
	result.w = src[srcIndex];

	// dst alpha matches what loaded in result
	dst[index4] = result;
}

// 2D  - alphaType 1 - use source alpha
__kernel //__attribute(( reqd_work_group_size(8,8,1)))
 void Laser_alpha1_Global(__global const uint* src, __global uint4* dst, int width, //int height,
									float fcurRad, int  halfWidth, int halfHeight )
{
	int x4 = get_global_id(0);
	int x = x4 <<2;
	int y = get_global_id(1);
	int index  = y * width + x;
	int index4 = y * (width >> 2) + x4;

	float fWidth = (float)width;
	uint4 result;

	// First sample
	float xc = (float)(x - halfWidth);
	float yc = (float)(y - halfHeight);
	float	ycSq = (float)(yc * yc);

	float	radius = sqrt( mad( xc, xc, ycSq ) );
	float	curMultInvRadius = fcurRad / radius;

	// Can NOT use "mad()" here - need to trunc negative values toward zero before add and make them positive!
	// Else get an off-by-one error for all negative values
	float	srcX =  trunc( xc * curMultInvRadius ) + halfWidth;
	float	srcY =  trunc( yc * curMultInvRadius ) + halfHeight;

	int srcIndex = (int)(  mad( srcY, fWidth,  srcX )  );
	srcIndex = (radius > fcurRad ) ? srcIndex : index;

	// use source alpha
	result.x  = (src[srcIndex] & 0x00ffffff) | (src[index] & 0xFF000000);

	// 2nd sample
	xc += 1.0f;

	radius = sqrt( mad( xc, xc, ycSq ) );
	curMultInvRadius = fcurRad / radius;

	srcX =  trunc( xc * curMultInvRadius ) + halfWidth;
	srcY =  trunc( yc * curMultInvRadius ) + halfHeight;

	srcIndex = (radius > fcurRad ) ? (int) mad( srcY, fWidth,  srcX ) : index + 1;
	// use source alpha
	result.y = (src[srcIndex] & 0x00ffffff) | (src[index+1] & 0xFF000000);

	// 3rd sample
	xc += 1.0f;

	radius = sqrt( mad( xc, xc, ycSq ) );
	curMultInvRadius = fcurRad / radius;

	srcX =  trunc( xc * curMultInvRadius ) + halfWidth;
	srcY =  trunc( yc * curMultInvRadius ) + halfHeight;

	srcIndex = (radius > fcurRad ) ? (int) mad( srcY, fWidth,  srcX ) : index +2;
	// use source alpha
	result.z = (src[srcIndex] & 0x00ffffff) | (src[index+2] & 0xFF000000);

	// 4th sample
	xc += 1.0f;

	radius = sqrt( mad( xc, xc, ycSq ) );
	curMultInvRadius = fcurRad / radius;

	srcX =  trunc( xc * curMultInvRadius ) + halfWidth;
	srcY =  trunc( yc * curMultInvRadius ) + halfHeight;

	srcIndex = (radius > fcurRad ) ? (int) mad( srcY, fWidth,  srcX ) : index+3;

	// use source alpha
	result.w = (src[srcIndex] & 0x00ffffff) | (src[index+3] & 0xFF000000);

	dst[index4] = result;
}

// 2D  - alphaType 2 - set alpha to 0xff
__kernel //__attribute(( reqd_work_group_size(8,8,1)))
 void Laser_alpha2_Global(__global const uint* src, __global uint4 * dst,    int width, //int height,
									float fcurRad, int  halfWidth, int halfHeight )
{
	int x4 = get_global_id(0);
	int x = x4 <<2;
	int y = get_global_id(1);
	int index  = y * width + x;
	int index4 = y * (width >> 2) + x4;

	float fWidth = (float)width;
	// First sample
	float	xc = (float)(x - halfWidth);
	float	yc = (float)(y - halfHeight);
	float	ycSq = (float)(yc * yc);

	float	radius = sqrt( mad( xc, xc, ycSq ) );
	float	curMultInvRadius = fcurRad / radius;

	// Can NOT use "mad()" here - need to trunc negative values toward zero before add and make them positive!
	// Else get an off-by-one error for all negative values
	float	srcX =  trunc( xc * curMultInvRadius ) + halfWidth;
	float	srcY =  trunc( yc * curMultInvRadius ) + halfHeight;

	int srcIndex = (int)( mad( srcY, fWidth,  srcX ) );
	srcIndex = (radius > fcurRad ) ? srcIndex : index;

	uint4 result;
	result.x  = src[srcIndex];

	// 2nd sample
	xc += 1.0f;

	radius = sqrt( mad( xc, xc, ycSq ) );
	curMultInvRadius = fcurRad / radius;

	srcX =  trunc( xc * curMultInvRadius ) + halfWidth;
	srcY =  trunc( yc * curMultInvRadius ) + halfHeight;

	srcIndex = (radius > fcurRad ) ? (int) mad( srcY, fWidth,  srcX ) : index + 1;
	result.y = src[srcIndex];

	// 3rd sample
	xc += 1.0f;

	radius = sqrt( mad( xc, xc, ycSq ) );
	curMultInvRadius = fcurRad / radius;

	srcX =  trunc( xc * curMultInvRadius ) + halfWidth;
	srcY =  trunc( yc * curMultInvRadius ) + halfHeight;

	srcIndex = (radius > fcurRad ) ? (int) mad( srcY, fWidth,  srcX ) : index +2;
	result.z = src[srcIndex];

	// 4th sample
	xc += 1.0f;

	radius = sqrt( mad( xc, xc, ycSq ) );
	curMultInvRadius = fcurRad / radius;

	srcX =  trunc( xc * curMultInvRadius ) + halfWidth;
	srcY =  trunc( yc * curMultInvRadius ) + halfHeight;

	srcIndex = (radius > fcurRad ) ? (int) mad( srcY, fWidth,  srcX ) : index+3;
	result.w = src[srcIndex];

	// force alpha to 0xff
	result = result | 0xff000000;

	dst[index4] = result;
}

//1D - alphaType 0 - do not handle alpha
__kernel void Laser_1Dinput_Alpha0_Global(__global const uchar4* src, __global uchar4* dst, int width, int height,
											__global const int* nRadiusTbl, __global const int* nInverseTbl, int currRadius,
											int  halfWidth, int halfHeight, __global const int* nYOffset)
{
	int x = get_global_id(0);
	int y = get_global_id(1);
	int index = y * width + x;

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
}

//1D  - alphaType 1 - use source alpha
__kernel void Laser_1Dinput_Alpha1_Global(__global const uchar4* src, __global uchar4* dst, int width, int height,
											__global const int* nRadiusTbl, __global const int* nInverseTbl, int currRadius,
											int  halfWidth, int halfHeight, __global const int* nYOffset)
{
	int x = get_global_id(0);
	int y = get_global_id(1);
	int index = y * width + x;

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

	// use source alpha
	dst[index].w = src[index].w;
}

//1D  - alphaType 2 - set alpha to 0xff
__kernel void Laser_1Dinput_Alpha2_Global(__global const uchar4* src, __global uchar4* dst, int width, int height,
											__global const int* nRadiusTbl, __global const int* nInverseTbl, int currRadius,
											int  halfWidth, int halfHeight, __global const int* nYOffset)
{
	int x = get_global_id(0);
	int y = get_global_id(1);
	int index = y * width + x;

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

	// force alpha to 0xff
	dst[index].w = 255;
}


// buildOptions=
// RUN: %occ-cli %s --cl-options="-I%cwd -I%S " %cfg_path --cl-device=%cl_device 2>&1
