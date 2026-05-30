
__kernel void XRay_Global(__global const uchar4* src, __global uchar4* dst, int width, int height,
unsigned char degree, unsigned char maskType, float gradientDepth, unsigned char bInverse, int nLeftBound, int nRightBound,
int nTopBound, int nBottomBound, int nRegionW, int nRegionH, unsigned char bEffectOnFullFrame, unsigned char getAlphaType)
{
	int i = get_global_id(0);
	int j = get_global_id(1);
	int index = j * width + i;

	unsigned char a, b, c;

	uchar4 tempSrc = src[index];
	uchar4 tempDst;
	uchar4 tempBuf = 0;

 	if(!bInverse)
	{
			if(bEffectOnFullFrame)
			{
					if( j >= nTopBound && j < nBottomBound )
					{
							if( i >= nLeftBound && i < nRightBound)
							{
									a = tempSrc.x ^ 0xff;
 									b = tempSrc.y ^ 0xff;
 									c = tempSrc.z ^ 0xff;

 									tempDst.x = tempSrc.x + (((a - tempSrc.x) * degree) >> 8);
 									tempDst.y = tempSrc.y + (((b - tempSrc.y) * degree) >> 8);
 									tempDst.z = tempSrc.z + (((c - tempSrc.z) * degree) >> 8);
							}
					}
			}
			else
			{
					tempDst = tempSrc;

					if( nLeftBound >= nRightBound || nTopBound >= nBottomBound )
					{
						return;
					}

					if( j >= nTopBound && j < nBottomBound )
					{
							if( i >= nLeftBound && i < nRightBound)
							{
									a = tempSrc.x ^ 0xff;
 									b = tempSrc.y ^ 0xff;
 									c = tempSrc.z ^ 0xff;

 									tempDst.x = tempSrc.x + (((a - tempSrc.x) * degree) >> 8);
 									tempDst.y = tempSrc.y + (((b - tempSrc.y) * degree) >> 8);
 									tempDst.z = tempSrc.z + (((c - tempSrc.z) * degree) >> 8);

 									tempBuf = tempSrc;
							}
					}
			}
	}
	else // inverse effect area
	{
			if (bEffectOnFullFrame)
			{
					tempDst = tempSrc;
			}
			else
			{
					a = tempSrc.x ^ 0xff;
 					b = tempSrc.y ^ 0xff;
 					c = tempSrc.z ^ 0xff;

 					tempDst.x = tempSrc.x + (((a - tempSrc.x) * degree) >> 8);
 					tempDst.y = tempSrc.y + (((b - tempSrc.y) * degree) >> 8);
 					tempDst.z = tempSrc.z + (((c - tempSrc.z) * degree) >> 8);

					if( j >= nTopBound && j < nBottomBound )
					{
							if( i >= nLeftBound && i < nRightBound)
							{
									tempBuf = tempDst;
									tempDst = tempSrc;
							}
					}
			}
	}

	tempDst.w = (getAlphaType == 1)? tempSrc.w : tempDst.w;
    tempDst.w = (getAlphaType == 2)? 255 : tempDst.w;

	// Blending
	if(!bEffectOnFullFrame)
	{
			int sat = 0;

			if(maskType == 0) // 0 = box
			{
					int nSemiminorAxis =(min(nRegionH, nRegionW)) /2.0 ;
					float fDepth = gradientDepth * nSemiminorAxis;
					int distance = 0;

					if( j >= nTopBound && j < nBottomBound )
					{
							if( i >= nLeftBound && i < nRightBound)
							{
									distance = min( min(i-nLeftBound, nRightBound-1-i), min(j-nTopBound, nBottomBound-1-j) );

									if (distance < fDepth)
									{
											// the gradient part
											sat = (distance/fDepth)*256;

 											tempDst.z = ( sat*tempDst.z + (256-sat)*tempBuf.z ) >> 8;
											tempDst.y = ( sat*tempDst.y + (256-sat)*tempBuf.y ) >> 8;
											tempDst.x = ( sat*tempDst.x + (256-sat)*tempBuf.x ) >> 8;
									}
									else
									{
											//the inner part
									}
							}
					}

			}
			else if(maskType == 1) // 1 = circle
			{
					int sqrWidth = (nRegionW  * nRegionW) >> 2;
					int sqrHeight = (nRegionH * nRegionH) >> 2;
					int newX = 0;
					int newY = 0;
					float t = 0;

					if( j >= nTopBound && j < nBottomBound )
					{
							if( i >= nLeftBound && i < nRightBound)
							{
									newY = j - ( nTopBound + (nRegionH >> 1) );
									newX = i - ( nLeftBound + (nRegionW >> 1) );
									t = (newX*newX)/(float)sqrWidth + (newY*newY)/(float)sqrHeight;

									if(t > 1) // outside the ellipse
									{
											tempDst = tempBuf;
									}

									else if(t <= 1 && t > 1- gradientDepth)
									{
											// the gradient part
											sat = (1-t)/gradientDepth*256;

											tempDst.z = ( sat*tempDst.z + (256-sat)*tempBuf.z ) >> 8;
											tempDst.y = ( sat*tempDst.y + (256-sat)*tempBuf.y ) >> 8;
											tempDst.x = ( sat*tempDst.x + (256-sat)*tempBuf.x ) >> 8;
									}
									else if(t <= 1- gradientDepth)
									{
											//the inner part
									}
							}
					}
			}
	}

	dst[index] = tempDst;
}


// buildOptions=
// RUN: %occ-cli %s --cl-options="-I%cwd -I%S " %cfg_path --cl-device=%cl_device 2>&1
