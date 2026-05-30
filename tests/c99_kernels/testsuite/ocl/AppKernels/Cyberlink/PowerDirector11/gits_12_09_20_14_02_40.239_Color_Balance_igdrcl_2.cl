
#if 0

__kernel void ColorBalance_Global(__global const uchar4* src, __global uchar4* dst, int width, int height, int nRLevel, int nGLevel, int nBLevel,
unsigned char bGrayScale, unsigned char maskType, float fGradientDepth, unsigned char bInverse, int nLeftBound, int nRightBound,
int nTopBound, int nBottomBound, int nRegionW, int nRegionH, unsigned char bEffectOnFullFrame, unsigned char getAlphaType)
{
	int i = get_global_id(0);
	int j = get_global_id(1);
	int index = j*width+i;

	int red, green, blue, mix;

	uchar4 tempSrc = src[index];
	uchar4 tempDst;
	uchar4 tempBuf = 0;

 	if(!bInverse)
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
							red   = max( 0, min( 255, (tempSrc.z + nRLevel) ) );
							green = max( 0, min( 255, (tempSrc.y + nGLevel) ) );
							blue  = max( 0, min( 255, (tempSrc.x + nBLevel) ) );

							if (bGrayScale)
							{
								mix = (red + green + blue) / 3;
								tempDst.x = mix;
								tempDst.y = mix;
								tempDst.z = mix;
								tempBuf = tempSrc;
							}
							else
							{
								tempDst.x = blue;
								tempDst.y = green;
								tempDst.z = red;
								tempBuf = tempSrc;
							}
					}
			}
	}
	else // inverse effect area
	{
			red   = max( 0, min( 255, (tempSrc.z + nRLevel) ) );
			green = max( 0, min( 255, (tempSrc.y + nGLevel) ) );
			blue  = max( 0, min( 255, (tempSrc.x + nBLevel) ) );

			if (bGrayScale)
			{
				mix = (red + green + blue) / 3;
				tempDst.x = mix;
				tempDst.y = mix;
				tempDst.z = mix;
			}
			else
			{
				tempDst.x = blue;
				tempDst.y = green;
				tempDst.z = red;
			}

			if( j >= nTopBound && j < nBottomBound )
			{
					if( i >= nLeftBound && i < nRightBound)
					{
							tempBuf = tempDst;
							tempDst = tempSrc;
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

	dst[index] = tempDst;
}

#endif	// CUTTING OUT - USE REPLACEMENTS BELOW


// TRC_CHG - splitting out invariant kernels

__kernel void ColorBalance_NoInverse_Box(__global const uchar4* src, __global uchar4* dst, int width, int height, int nRLevel, int nGLevel, int nBLevel,
unsigned char bGrayScale, float fGradientDepth, int nLeftBound, int nRightBound, int nTopBound, int nBottomBound, int nRegionW, int nRegionH,
unsigned char getAlphaType)
{
	int i = get_global_id(0);
	int j = get_global_id(1);
	int index = j*width+i;

	int red, green, blue, mix;

	uchar4 tempSrc = src[index];
	uchar4 tempDst;
	uchar4 tempBuf = 0;

	tempDst = tempSrc;

	// MOVED THIS TEST OUTSIDE ALSO - skip kernel call.  Unclear this is correct though... C code copied orig.
	//if( nLeftBound >= nRightBound || nTopBound >= nBottomBound )
	//{
	//	return;
	//}


	if( j >= nTopBound && j < nBottomBound )
	{
			if( i >= nLeftBound && i < nRightBound)
			{
					red   = clamp( (tempSrc.z + nRLevel), 0, 255 );
					green = clamp( (tempSrc.y + nGLevel), 0, 255 );
					blue  = clamp( (tempSrc.x + nBLevel), 0, 255 );

					if (bGrayScale)
					{
						mix = (red + green + blue) / 3;
						tempDst.x = mix;
						tempDst.y = mix;
						tempDst.z = mix;
						tempBuf = tempSrc;
					}
					else
					{
						tempDst.x = blue;
						tempDst.y = green;
						tempDst.z = red;
						tempBuf = tempSrc;
					}
			}
	}

	// TRC_CHG - tempDst.w is default set to tempSrc.w, no need to assign
	//	tempDst.w = (getAlphaType == 1)? tempSrc.w : tempDst.w;
    tempDst.w = (getAlphaType == 2)? 255 : tempDst.w;

	// Blending
	int sat = 0;

	//if(maskType == 0) // 0 = box
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


	dst[index] = tempDst;
}


__kernel void ColorBalance_NoInverse_Circle(__global const uchar4* src, __global uchar4* dst, int width, int height, int nRLevel, int nGLevel, int nBLevel,
unsigned char bGrayScale, float fGradientDepth, int nLeftBound, int nRightBound, int nTopBound, int nBottomBound, int nRegionW, int nRegionH, unsigned char getAlphaType)
{
	int i = get_global_id(0);
	int j = get_global_id(1);
	int index = j*width+i;

	int red, green, blue, mix;

	uchar4 tempSrc = src[index];
	uchar4 tempDst;
	uchar4 tempBuf = 0;

	tempDst = tempSrc;

	// MOVED THIS TEST OUTSIDE ALSO - skip kernel call.  Unclear this is correct though... C code copied orig.
	//if( nLeftBound >= nRightBound || nTopBound >= nBottomBound )
	//{
	//	return;
	//}


	if( j >= nTopBound && j < nBottomBound )
	{
			if( i >= nLeftBound && i < nRightBound)
			{
					red   = clamp( (tempSrc.z + nRLevel), 0, 255 );
					green = clamp( (tempSrc.y + nGLevel), 0, 255 );
					blue  = clamp( (tempSrc.x + nBLevel), 0, 255 );

					if (bGrayScale)
					{
						mix = (red + green + blue) / 3;
						tempDst.x = mix;
						tempDst.y = mix;
						tempDst.z = mix;
						tempBuf = tempSrc;
					}
					else
					{
						tempDst.x = blue;
						tempDst.y = green;
						tempDst.z = red;
						tempBuf = tempSrc;
					}
			}
	}

	// TRC_CHG - tempDst.w is default set to tempSrc.w, no need to assign
	//	tempDst.w = (getAlphaType == 1)? tempSrc.w : tempDst.w;
    tempDst.w = (getAlphaType == 2)? 255 : tempDst.w;

	// Blending
	int sat = 0;

	// if(maskType == 1) // 1 = circle
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

	dst[index] = tempDst;
}


// NOTE: use this even if not marked bEffectOnFullFrame, if maskType is not 0 or 1
__kernel void ColorBalance_NoInverse_Full(__global const uchar4* src, __global uchar4* dst, int width, int height, int nRLevel, int nGLevel, int nBLevel,
unsigned char bGrayScale, float fGradientDepth, int nLeftBound, int nRightBound, int nTopBound, int nBottomBound, int nRegionW, int nRegionH, unsigned char getAlphaType)
{
	int i = get_global_id(0);
	int j = get_global_id(1);
	int index = j*width+i;

	int red, green, blue, mix;

	uchar4 tempSrc = src[index];
	uchar4 tempDst;


	tempDst = tempSrc;

	// MOVED THIS TEST OUTSIDE ALSO - skip kernel call.  Unclear this is correct though... C code copied orig.
	//if( nLeftBound >= nRightBound || nTopBound >= nBottomBound )
	//{
	//	return;
	//}

	if( j >= nTopBound && j < nBottomBound )
	{
			if( i >= nLeftBound && i < nRightBound)
			{
					red   = clamp( (tempSrc.z + nRLevel), 0, 255 );
					green = clamp( (tempSrc.y + nGLevel), 0, 255 );
					blue  = clamp( (tempSrc.x + nBLevel), 0, 255 );

					if (bGrayScale)
					{
						mix = (red + green + blue) / 3;
						tempDst.x = mix;
						tempDst.y = mix;
						tempDst.z = mix;
					}
					else
					{
						tempDst.x = blue;
						tempDst.y = green;
						tempDst.z = red;
					}
			}
	}


	// default to tempSrc.w
	// TRC_CHG - tempDst.w is default set to tempSrc.w, no need to assign
	//	tempDst.w = (getAlphaType == 1)? tempSrc.w : tempDst.w;

    tempDst.w = (getAlphaType == 2)? 255 : tempDst.w;


	dst[index] = tempDst;
}



__kernel void ColorBalance_Inverse_Box(__global const uchar4* src, __global uchar4* dst, int width, int height, int nRLevel, int nGLevel, int nBLevel,
unsigned char bGrayScale, float fGradientDepth, int nLeftBound, int nRightBound, int nTopBound, int nBottomBound, int nRegionW, int nRegionH, unsigned char getAlphaType)
{
	int i = get_global_id(0);
	int j = get_global_id(1);
	int index = j*width+i;

	int red, green, blue, mix;

	uchar4 tempSrc = src[index];
	uchar4 tempDst;
	uchar4 tempBuf = 0;

	// inverse effect area
	{
			red   = clamp( (tempSrc.z + nRLevel), 0, 255 );
			green = clamp( (tempSrc.y + nGLevel), 0, 255 );
			blue  = clamp( (tempSrc.x + nBLevel), 0, 255 );

			if (bGrayScale)
			{
				mix = (red + green + blue) / 3;
				tempDst.x = mix;
				tempDst.y = mix;
				tempDst.z = mix;
			}
			else
			{
				tempDst.x = blue;
				tempDst.y = green;
				tempDst.z = red;
			}

			if( j >= nTopBound && j < nBottomBound )
			{
					if( i >= nLeftBound && i < nRightBound)
					{
							tempBuf = tempDst;
							tempDst = tempSrc;
					}
			}
	}

	// TRC_CHG - tempDst.w is default set to tempSrc.w, no need to assign
	//	tempDst.w = (getAlphaType == 1)? tempSrc.w : tempDst.w;
    tempDst.w = (getAlphaType == 2)? 255 : tempDst.w;

	// Blending
	{
			int sat = 0;

			//if(maskType == 0) // 0 = box
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

	}

	dst[index] = tempDst;
}



__kernel void ColorBalance_Inverse_Circle(__global const uchar4* src, __global uchar4* dst, int width, int height, int nRLevel, int nGLevel, int nBLevel,
unsigned char bGrayScale, float fGradientDepth, int nLeftBound, int nRightBound, int nTopBound, int nBottomBound, int nRegionW, int nRegionH, unsigned char getAlphaType)
{
	int i = get_global_id(0);
	int j = get_global_id(1);
	int index = j*width+i;

	int red, green, blue, mix;

	uchar4 tempSrc = src[index];
	uchar4 tempDst;
	uchar4 tempBuf = 0;

	// inverse effect area
	{
			red   = clamp( (tempSrc.z + nRLevel), 0, 255 );
			green = clamp( (tempSrc.y + nGLevel), 0, 255 );
			blue  = clamp( (tempSrc.x + nBLevel), 0, 255 );

			if (bGrayScale)
			{
				mix = (red + green + blue) / 3;
				tempDst.x = mix;
				tempDst.y = mix;
				tempDst.z = mix;
			}
			else
			{
				tempDst.x = blue;
				tempDst.y = green;
				tempDst.z = red;
			}

			if( j >= nTopBound && j < nBottomBound )
			{
					if( i >= nLeftBound && i < nRightBound)
					{
							tempBuf = tempDst;
							tempDst = tempSrc;
					}
			}
	}

	// TRC_CHG - tempDst.w is default set to tempSrc.w, no need to assign
	//	tempDst.w = (getAlphaType == 1)? tempSrc.w : tempDst.w;
    tempDst.w = (getAlphaType == 2)? 255 : tempDst.w;

	// Blending
	{
			int sat = 0;


			// if(maskType == 1) // 1 = circle
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

	dst[index] = tempDst;
}


// NOTE: Use this even if NOT full, if maskType is not 0 or 1 (box or circle)
__kernel void ColorBalance_Inverse_Full(__global const uchar4* src, __global uchar4* dst, int width, int height, int nRLevel, int nGLevel, int nBLevel,
unsigned char bGrayScale, float fGradientDepth, int nLeftBound, int nRightBound, int nTopBound, int nBottomBound, int nRegionW, int nRegionH, unsigned char getAlphaType)
{
	int i = get_global_id(0);
	int j = get_global_id(1);
	int index = j*width+i;

	int red, green, blue, mix;

	uchar4 tempSrc = src[index];
	uchar4 tempDst;
	//uchar4 tempBuf = 0;

	// inverse effect area
	{
			red   = clamp( (tempSrc.z + nRLevel), 0, 255 );
			green = clamp( (tempSrc.y + nGLevel), 0, 255 );
			blue  = clamp( (tempSrc.x + nBLevel), 0, 255 );

			if (bGrayScale)
			{
				mix = (red + green + blue) / 3;
				tempDst.x = mix;
				tempDst.y = mix;
				tempDst.z = mix;
			}
			else
			{
				tempDst.x = blue;
				tempDst.y = green;
				tempDst.z = red;
			}

			if( j >= nTopBound && j < nBottomBound )
			{
					if( i >= nLeftBound && i < nRightBound)
					{
							//tempBuf = tempDst;
							tempDst = tempSrc;
					}
			}
	}

	// TRC_CHG - tempDst.w is default set to tempSrc.w, no need to assign
	//	tempDst.w = (getAlphaType == 1)? tempSrc.w : tempDst.w;
    tempDst.w = (getAlphaType == 2)? 255 : tempDst.w;


	dst[index] = tempDst;
}

// buildOptions=
// RUN: %occ-cli %s --cl-options="-I%cwd -I%S " %cfg_path --cl-device=%cl_device 2>&1
