
__kernel void BlackAndWhite_AYUV(__global const uchar4* src, __global uchar4* dst, int width, int height,
int nSaturation, unsigned char maskType, float fGradientDepth, unsigned char bInverse, int nLeftBound, int nRightBound,
int nTopBound, int nBottomBound, int nRegionW, int nRegionH, unsigned char bEffectOnFullFrame, unsigned char getAlphaType)
{

	int index = get_global_id(0);

	int j = index / width;
	int i = index - width * j;

	uint4 tempSrc = convert_uint4(src[index]);
	uint4 tempBuf = 0;
	uint4 tempDst;

 	if(!bInverse)
	{
			if(bEffectOnFullFrame)
			{
					tempDst.x = (((tempSrc.x -128)*nSaturation)>>12)+128;
					tempDst.y = (((tempSrc.y -128)*nSaturation)>>12)+128;
					tempDst.z = tempSrc.z;
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
									tempDst.x = (((tempSrc.x -128)*nSaturation)>>12)+128;
									tempDst.y = (((tempSrc.y -128)*nSaturation)>>12)+128;
									tempDst.z = tempSrc.z;

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
					tempDst.x = (((tempSrc.x -128)*nSaturation)>>12)+128;
					tempDst.y = (((tempSrc.y -128)*nSaturation)>>12)+128;
					tempDst.z = tempSrc.z;

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
											tempDst.z = tempBuf.z;
											tempDst.y = tempBuf.y;
											tempDst.x = tempBuf.x;
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


// buildOptions=
// RUN: %occ-cli %s --cl-options="-I%cwd -I%S " %cfg_path --cl-device=%cl_device 2>&1
