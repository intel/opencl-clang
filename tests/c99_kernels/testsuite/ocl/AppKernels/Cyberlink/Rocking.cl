// 2D iteration
__kernel void Rocking_Global(__global const uchar4* src, __global uchar4* dst, int width, int height, int nEnlargeRate, int nDirection, unsigned char getAlphaType)
{
	int i = get_global_id(0);
	int j = get_global_id(1);
	int index = j*width+i;

	uchar4 tempSrc = src[index];
	uchar4 tempDst = dst[index];
	uchar4 prgbP_lb, prgbP_rb, prgbP_lt, prgbP_rt;
	uchar4 tempRGB1;
	uchar4 tempRGB2;
	uchar4 temp;

	if(100 == nEnlargeRate)
	{
		tempDst.w = (tempDst.w + tempSrc.w)/2;
		tempDst.x = (tempDst.x + tempSrc.x)/2;
		tempDst.y = (tempDst.y + tempSrc.y)/2;
		tempDst.z = (tempDst.z + tempSrc.z)/2;
	}
	else if( (100 < nEnlargeRate) && (200 >= nEnlargeRate) )
	{
		int nSWidth  = width  * 100 / nEnlargeRate;
		int nSHeight = height * 100 / nEnlargeRate;

		int nStartX, nStartY;

		if ( 0 == nDirection )
		{
			// Stretch to Left-top
			nStartX = width - nSWidth - 1;
			nStartY = ( height - nSHeight - 1 ) & 0xFFFFFFFE;	// Make sure the start Y is even number
																							// For interlaced mode
		}
		else if ( 1 == nDirection )
		{
			// Stretch to Right-top
			nStartX = 0;
			nStartY = ( height - nSHeight - 1 ) & 0xFFFFFFFE;	// Make sure the start Y is even number
																									// For interlaced mode
		}
		else if ( 2 == nDirection )
		{
			// Stretch to Right-bottom
			nStartX = 0;
			nStartY = 0;
		}
		else if ( 3 == nDirection )
		{
			// Stretch to Left-bottom
			nStartX = width - nSWidth - 1;
			nStartY = 0;
		}
		else
		{
			// Stretch from Center
			nStartX = ( width - nSWidth ) / 2;
			nStartY = (( height - nSHeight ) / 2 ) & 0xFFFFFFFE;	// Make sure the start Y is even number
																								// For interlaced mode
		}

		int srcStartIndex = nStartY * width + nStartX;

		int nFXStep = ( nSWidth << 16 )  / width;
		int nFYStep = ( nSHeight << 16 ) / height;

		int nFX = 0, nFY = 0;
		int fxX, fxY;

		// j loop
		nFY = j * nFYStep;
		srcStartIndex +=  ( nFY >> 16 ) * width;

		fxY = nFY & 0x0000ffff;

		// i loop
		nFX = i * nFXStep;
		srcStartIndex +=  ( nFX >> 16 );

		prgbP_lb = src[srcStartIndex];
		prgbP_rb = src[srcStartIndex+1];
		prgbP_lt = src[srcStartIndex+width];
		prgbP_rt = src[srcStartIndex+width+1];

		fxX = nFX & 0x0000ffff;

		tempRGB1.x = prgbP_lb.x + ((( prgbP_rb.x - prgbP_lb.x ) * fxX) >> 16);
		tempRGB1.y = prgbP_lb.y + ((( prgbP_rb.y - prgbP_lb.y ) * fxX) >> 16);
		tempRGB1.z = prgbP_lb.z + ((( prgbP_rb.z - prgbP_lb.z ) * fxX) >> 16);

		tempRGB2.x = prgbP_lt.x + ((( prgbP_rt.x - prgbP_lt.x ) * fxX) >> 16);
		tempRGB2.y = prgbP_lt.y + ((( prgbP_rt.y - prgbP_lt.y ) * fxX) >> 16);
		tempRGB2.z = prgbP_lt.z + ((( prgbP_rt.z - prgbP_lt.z ) * fxX) >> 16);

		temp.x = tempRGB1.x + ((( tempRGB2.x - tempRGB1.x ) * fxY) >> 16);
		temp.y = tempRGB1.y + ((( tempRGB2.y - tempRGB1.y ) * fxY) >> 16);
		temp.z = tempRGB1.z + ((( tempRGB2.z - tempRGB1.z ) * fxY) >> 16);

		tempDst.x = (temp.x + tempDst.x) >> 1;
		tempDst.y = (temp.y + tempDst.y) >> 1;
		tempDst.z = (temp.z + tempDst.z) >> 1;
	}

// 	if(getAlphaType == 1)
// 		tempDst.w = tempSrc.w;
// 	else if(getAlphaType == 2)
// 		tempDst.w = 255;

	dst[index] = tempDst;

}//kernel end

#if 0
// 1D iteration
__kernel void Rocking_Global(__global const uchar4* src, __global uchar4* dst, int width, int height, int nEnlargeRate, int nDirection, unsigned char getAlphaType)
{
	int index = get_global_id(0);

	int j = index / width;
	int i = index % width;

	uchar4 tempSrc = src[index];
	uchar4 tempDst = dst[index];
	uchar4 prgbP_lb, prgbP_rb, prgbP_lt, prgbP_rt;
	uchar4 tempRGB1;
	uchar4 tempRGB2;
	uchar4 temp;

	if(100 == nEnlargeRate)
	{
		tempDst.w = (tempDst.w + tempSrc.w)/2;
		tempDst.x = (tempDst.x + tempSrc.x)/2;
		tempDst.y = (tempDst.y + tempSrc.y)/2;
		tempDst.z = (tempDst.z + tempSrc.z)/2;
	}
	else if( (100 < nEnlargeRate) && (200 >= nEnlargeRate) )
	{
		int nSWidth  = width  * 100 / nEnlargeRate;
		int nSHeight = height * 100 / nEnlargeRate;

		int nStartX, nStartY;

		if ( 0 == nDirection )
		{
			// Stretch to Left-top
			nStartX = width - nSWidth - 1;
			nStartY = ( height - nSHeight - 1 ) & 0xFFFFFFFE;	// Make sure the start Y is even number
																							// For interlaced mode
		}
		else if ( 1 == nDirection )
		{
			// Stretch to Right-top
			nStartX = 0;
			nStartY = ( height - nSHeight - 1 ) & 0xFFFFFFFE;	// Make sure the start Y is even number
																									// For interlaced mode
		}
		else if ( 2 == nDirection )
		{
			// Stretch to Right-bottom
			nStartX = 0;
			nStartY = 0;
		}
		else if ( 3 == nDirection )
		{
			// Stretch to Left-bottom
			nStartX = width - nSWidth - 1;
			nStartY = 0;
		}
		else
		{
			// Stretch from Center
			nStartX = ( width - nSWidth ) / 2;
			nStartY = (( height - nSHeight ) / 2 ) & 0xFFFFFFFE;	// Make sure the start Y is even number
																								// For interlaced mode
		}

		int srcStartIndex = nStartY * width + nStartX;

		int nFXStep = ( nSWidth << 16 )  / width;
		int nFYStep = ( nSHeight << 16 ) / height;

		int nFX = 0, nFY = 0;
		int fxX, fxY;

		// j loop
		nFY = j * nFYStep;
		srcStartIndex +=  ( nFY >> 16 ) * width;

		fxY = nFY & 0x0000ffff;

		// i loop
		nFX = i * nFXStep;
		srcStartIndex +=  ( nFX >> 16 );

		prgbP_lb = src[srcStartIndex];
		prgbP_rb = src[srcStartIndex+1];
		prgbP_lt = src[srcStartIndex+width];
		prgbP_rt = src[srcStartIndex+width+1];

		fxX = nFX & 0x0000ffff;

		tempRGB1.x = prgbP_lb.x + ((( prgbP_rb.x - prgbP_lb.x ) * fxX) >> 16);
		tempRGB1.y = prgbP_lb.y + ((( prgbP_rb.y - prgbP_lb.y ) * fxX) >> 16);
		tempRGB1.z = prgbP_lb.z + ((( prgbP_rb.z - prgbP_lb.z ) * fxX) >> 16);

		tempRGB2.x = prgbP_lt.x + ((( prgbP_rt.x - prgbP_lt.x ) * fxX) >> 16);
		tempRGB2.y = prgbP_lt.y + ((( prgbP_rt.y - prgbP_lt.y ) * fxX) >> 16);
		tempRGB2.z = prgbP_lt.z + ((( prgbP_rt.z - prgbP_lt.z ) * fxX) >> 16);

		temp.x = tempRGB1.x + ((( tempRGB2.x - tempRGB1.x ) * fxY) >> 16);
		temp.y = tempRGB1.y + ((( tempRGB2.y - tempRGB1.y ) * fxY) >> 16);
		temp.z = tempRGB1.z + ((( tempRGB2.z - tempRGB1.z ) * fxY) >> 16);

		tempDst.x = (temp.x + tempDst.x) >> 1;
		tempDst.y = (temp.y + tempDst.y) >> 1;
		tempDst.z = (temp.z + tempDst.z) >> 1;
	}

// 	if(getAlphaType == 1)
// 		tempDst.w = tempSrc.w;
// 	else if(getAlphaType == 2)
// 		tempDst.w = 255;

	dst[index] = tempDst;

}//kernel end
#endif


// buildOptions=
// RUN: %occ-cli %s --cl-options="-I%cwd -I%S " %cfg_path --cl-device=%cl_device 2>&1
