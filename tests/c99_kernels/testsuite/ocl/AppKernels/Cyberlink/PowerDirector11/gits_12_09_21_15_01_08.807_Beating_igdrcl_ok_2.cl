
__kernel void Beating_Global(__global const uchar4* src, __global uchar4* dst, int width, int height, int nEnlargeRate, unsigned char getAlphaType)
{
	int index = get_global_id(0);

	int j = index / width;
	int i = index - width * j;

	uchar4 tempSrc = src[index];
	uchar4 tempDst;
	uchar4 prgbP_lb, prgbP_rb, prgbP_lt, prgbP_rt;
	uchar4 tempRGB1;
	uchar4 tempRGB2;

	if(100 == nEnlargeRate)
		tempDst = tempSrc;
	else if( (100 < nEnlargeRate) && (200 >= nEnlargeRate) )
	{
		int nSWidth  = width  * 100 / nEnlargeRate;
		int nSHeight = height * 100 / nEnlargeRate;

		int nStartX = ( width - nSWidth ) / 2;
		int nStartY = (( height - nSHeight ) / 2 ) & 0xFFFFFFFE;

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

		tempDst.x = tempRGB1.x + ((( tempRGB2.x - tempRGB1.x ) * fxY) >> 16);
		tempDst.y = tempRGB1.y + ((( tempRGB2.y - tempRGB1.y ) * fxY) >> 16);
		tempDst.z = tempRGB1.z + ((( tempRGB2.z - tempRGB1.z ) * fxY) >> 16);
	}

	tempDst.w = (getAlphaType == 1)? tempSrc.w : tempDst.w;
    tempDst.w = (getAlphaType == 2)? 255 : tempDst.w;

	dst[index] = tempDst;
}

// buildOptions=
// RUN: %occ-cli %s --cl-options="-I%cwd -I%S " %cfg_path --cl-device=%cl_device 2>&1
