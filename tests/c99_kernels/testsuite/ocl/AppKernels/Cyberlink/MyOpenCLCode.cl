
#if 0
// saves about 3% (GT) to 7% (CPU) to do 2-D iteration.

__kernel void BlackAndWhite_Global(__global const uchar4* src, __global uchar4* dst, int width, int height,
float fSaturation, unsigned char maskType, float fGradientDepth, unsigned char bInverse, int nLeftBound, int nRightBound,
int nTopBound, int nBottomBound, int nRegionW, int nRegionH, unsigned char bEffectOnFullFrame, unsigned char getAlphaType)
{

	int index = get_global_id(0);


	int j = index / width;
	int i = index % width;

	uint4 tempSrc = convert_uint4(src[index]);
	uint4 tempBuf = 0;
	uint4 tempDst;

	unsigned int grayvalue = (1053 * tempSrc.z + 2064 * tempSrc.y  + 401 * tempSrc.x + 67584) >> 12;

	int nSaturation = fSaturation*4096;

 	if(!bInverse)
	{
			if(bEffectOnFullFrame)
			{
					tempDst.x =  grayvalue + (((tempSrc.x - grayvalue) * nSaturation) >> 12);
					tempDst.y =  grayvalue + (((tempSrc.y - grayvalue) * nSaturation) >> 12);
					tempDst.z =  grayvalue + (((tempSrc.z - grayvalue) * nSaturation) >> 12);
			}
			else
			{
					tempDst = tempSrc;
					//dst[index] = convert_uchar4(tempSrc);

					if( nLeftBound >= nRightBound || nTopBound >= nBottomBound )
					{
						return;
					}

					if( j >= nTopBound && j < nBottomBound )
					{
							if( i >= nLeftBound && i < nRightBound)
							{
									tempDst.x =  grayvalue + (((tempSrc.x - grayvalue) * nSaturation) >> 12);
									tempDst.y =  grayvalue + (((tempSrc.y - grayvalue) * nSaturation) >> 12);
									tempDst.z =  grayvalue + (((tempSrc.z - grayvalue) * nSaturation) >> 12);

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
					tempDst.x =  grayvalue + (((tempSrc.x - grayvalue) * nSaturation) >> 12);
					tempDst.y =  grayvalue + (((tempSrc.y - grayvalue) * nSaturation) >> 12);
					tempDst.z =  grayvalue + (((tempSrc.z - grayvalue) * nSaturation) >> 12);

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

	if(getAlphaType == 1)
		tempDst.w = tempSrc.w;
	else if(getAlphaType == 2)
		tempDst.w = 255;

	// Blender
	if(!bEffectOnFullFrame)
	{
			int sat = 0;

			if(maskType == 0) // 0 = box
			{
					int nSemiminorAxis =(min(nRegionH, nRegionW)) /2.0 ;
					float fDepth = fGradientDepth * nSemiminorAxis;
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

									else if(t <= 1 && t > 1- fGradientDepth)
									{
											// the gradient part
											sat = (1-t)/fGradientDepth*256;

											tempDst.z = ( sat*tempDst.z + (256-sat)*tempBuf.z ) >> 8;
											tempDst.y = ( sat*tempDst.y + (256-sat)*tempBuf.y ) >> 8;
											tempDst.x = ( sat*tempDst.x + (256-sat)*tempBuf.x ) >> 8;
									}
									else if(t <= 1- fGradientDepth)
									{
											//the inner part
									}
							}
					}
			}
	}

	dst[index] = convert_uchar4(tempDst);

}//kernel end

#else
// 2D version
__kernel void BlackAndWhite_Global(__global const uchar4* src, __global uchar4* dst, int width, int height,
float fSaturation, unsigned char maskType, float fGradientDepth, unsigned char bInverse, int nLeftBound, int nRightBound,
int nTopBound, int nBottomBound, int nRegionW, int nRegionH, unsigned char bEffectOnFullFrame, unsigned char getAlphaType)
{

	int j = get_global_id(1);
	int i = get_global_id(0);

	int offset = j*width+i;

	uint4 tempSrc = convert_uint4(src[offset]);
	uint4 tempBuf = 0;
	uint4 tempDst;

	unsigned int grayvalue = (1053 * tempSrc.z + 2064 * tempSrc.y  + 401 * tempSrc.x + 67584) >> 12;

	int nSaturation = fSaturation*4096;

 	if(!bInverse)
	{
			if(bEffectOnFullFrame)
			{
					tempDst.x =  grayvalue + (((tempSrc.x - grayvalue) * nSaturation) >> 12);
					tempDst.y =  grayvalue + (((tempSrc.y - grayvalue) * nSaturation) >> 12);
					tempDst.z =  grayvalue + (((tempSrc.z - grayvalue) * nSaturation) >> 12);
			}

			else
			{
					tempDst = tempSrc;
					//dst[index] = convert_uchar4(tempSrc);

					if( nLeftBound >= nRightBound || nTopBound >= nBottomBound )
					{
						return;
					}

					if( j >= nTopBound && j < nBottomBound )
					{
							if( i >= nLeftBound && i < nRightBound)
							{
									tempDst.x =  grayvalue + (((tempSrc.x - grayvalue) * nSaturation) >> 12);
									tempDst.y =  grayvalue + (((tempSrc.y - grayvalue) * nSaturation) >> 12);
									tempDst.z =  grayvalue + (((tempSrc.z - grayvalue) * nSaturation) >> 12);

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
					tempDst.x =  grayvalue + (((tempSrc.x - grayvalue) * nSaturation) >> 12);
					tempDst.y =  grayvalue + (((tempSrc.y - grayvalue) * nSaturation) >> 12);
					tempDst.z =  grayvalue + (((tempSrc.z - grayvalue) * nSaturation) >> 12);

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



	if(getAlphaType == 1)
		tempDst.w = tempSrc.w;
	else if(getAlphaType == 2)
		tempDst.w = 255;

	// Blender
	if(!bEffectOnFullFrame)
	{
			int sat = 0;

			if(maskType == 0) // 0 = box
			{
					int nSemiminorAxis =(min(nRegionH, nRegionW)) /2.0 ;
					float fDepth = fGradientDepth * nSemiminorAxis;
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

									else if(t <= 1 && t > 1- fGradientDepth)
									{
											// the gradient part
											sat = (1-t)/fGradientDepth*256;

											tempDst.z = ( sat*tempDst.z + (256-sat)*tempBuf.z ) >> 8;
											tempDst.y = ( sat*tempDst.y + (256-sat)*tempBuf.y ) >> 8;
											tempDst.x = ( sat*tempDst.x + (256-sat)*tempBuf.x ) >> 8;
									}
									else if(t <= 1- fGradientDepth)
									{
											//the inner part
									}
							}
					}
			}
	}


	dst[offset] = convert_uchar4(tempDst);

}//kernel end
#endif


// buildOptions=
// RUN: %occ-cli %s --cl-options="-I%cwd -I%S " %cfg_path --cl-device=%cl_device 2>&1
