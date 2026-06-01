
__kernel void ContinuousShooting_Global(__global const uchar4* src, int nSrcWidth, int nSrcHeight, int nSrcStirde,
__global uchar4* dst, int nDstWidth, int nDstHeight, int nDstStride, int dwColorAdj, int dstStartIndex, unsigned char getAlphaType)
{
	int index = get_global_id(0);

	int j = index / nSrcWidth;
	int i = index % nSrcWidth;

	int nDstPadding = nDstStride - nDstWidth;

	unsigned char AdjR = dwColorAdj & 0x000000ff;
	unsigned char AdjG = (dwColorAdj & 0x0000ff00) >> 8;
	unsigned char AdjB = (dwColorAdj & 0x00ff0000) >> 16;

	if( (nSrcWidth == nDstWidth) && (nSrcHeight == nDstHeight) )
	{
		dst[index] = src[index];
	}
	else
	{
		if( (j>=0) && (j<nDstHeight) && (i>=0) && (i<nDstWidth) )
		{
			int nFXStep = (( nSrcWidth << 16 ) - 1 )  / nDstWidth;
			int nFYStep = (( nSrcHeight << 16 ) - 1 ) / nDstHeight;

			int nFX = 0, nFY = 0;
			int fxX, fxY;

			uchar4 prgbP_lb, prgbP_rb, prgbP_lt, prgbP_rt;
			uchar4 ptempRGB1, ptempRGB2, pTempBilinear;

			// j loop
			nFY = j * nFYStep;
			fxY = nFY & 0x0000ffff;

			int srcStartIndex = ( nFY >> 16 ) * nSrcWidth;// + j * nDstPadding;

			// i loop
			nFX = i * nFXStep;
			srcStartIndex +=  ( nFX >> 16 );

			prgbP_lb = src[srcStartIndex];
			prgbP_rb = src[srcStartIndex+1];
			prgbP_lt = src[srcStartIndex+nSrcWidth];
			prgbP_rt = src[srcStartIndex+nSrcWidth+1];

			fxX = nFX & 0x0000ffff;

			ptempRGB1.x = prgbP_lb.x + ((( prgbP_rb.x - prgbP_lb.x ) * fxX) >> 16);
			ptempRGB1.y = prgbP_lb.y + ((( prgbP_rb.y - prgbP_lb.y ) * fxX) >> 16);
			ptempRGB1.z = prgbP_lb.z + ((( prgbP_rb.z - prgbP_lb.z ) * fxX) >> 16);

			ptempRGB2.x = prgbP_lt.x + ((( prgbP_rt.x - prgbP_lt.x ) * fxX) >> 16);
			ptempRGB2.y = prgbP_lt.y + ((( prgbP_rt.y - prgbP_lt.y ) * fxX) >> 16);
			ptempRGB2.z = prgbP_lt.z + ((( prgbP_rt.z - prgbP_lt.z ) * fxX) >> 16);

			pTempBilinear.x = ptempRGB1.x + ((( ptempRGB2.x - ptempRGB1.x ) * fxY) >> 16);
			pTempBilinear.y = ptempRGB1.y + ((( ptempRGB2.y - ptempRGB1.y ) * fxY) >> 16);
			pTempBilinear.z = ptempRGB1.z + ((( ptempRGB2.z - ptempRGB1.z ) * fxY) >> 16);

			int4 tempBilinear;
			tempBilinear.x = pTempBilinear.x + AdjB;
			tempBilinear.y = pTempBilinear.y + AdjG;
			tempBilinear.z = pTempBilinear.z + AdjR;

			dstStartIndex += j * nSrcWidth + i;
			dst[dstStartIndex].x = (tempBilinear.x > 255)? 255 :  tempBilinear.x;
			dst[dstStartIndex].y = (tempBilinear.y > 255)? 255 :  tempBilinear.y;
			dst[dstStartIndex].z = (tempBilinear.z > 255)? 255 :  tempBilinear.z;
		}
	}
}// kernel end


// buildOptions=
// RUN: %occ-cli %s --cl-options="-I%cwd -I%S " %cfg_path --cl-device=%cl_device 2>&1
