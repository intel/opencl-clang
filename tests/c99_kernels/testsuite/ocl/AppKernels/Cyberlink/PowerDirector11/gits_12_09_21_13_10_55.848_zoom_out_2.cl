
__kernel void ZoomOut_Global(__global const uchar4* src, __global uchar4* dst, int width, int height,
int fxSrcXStart, int fxSrcYStart, int fxSrcStepX, int fxSrcStepY, int nNewWidth, int nNewHeight, unsigned int dwBackColor, unsigned char getAlphaType)
{
	int i = get_global_id(0);
	int j = get_global_id(1);
	int index = j * width + i;

	uchar4 Src_LB, Src_LT, Src_RB, Src_RT;

	int fxX, fxY;
	int new_x, new_y;
	int fraction_x, fraction_y;
	int new_index;
	uchar4 tempRGB1, tempRGB2, tempDst;

	tempDst.x = (dwBackColor & 0x000000ff);
 	tempDst.y = (dwBackColor & 0x0000ff00) >> 8;
 	tempDst.z = (dwBackColor & 0x00ff0000) >> 16;
 	tempDst.w = src[index].w;

	if( j >= nNewHeight &&  j < (height - nNewHeight) )
	{
			fxY = fxSrcYStart + j * fxSrcStepY;

			if( i >= nNewWidth && i < (width - nNewWidth) )
			{
					fxX = fxSrcXStart + i * fxSrcStepX;

					//-GetPixelColorBilinear_C
					new_x = fxX >> 16;
					new_y = fxY >> 16;

					fraction_x = fxX & 0x0000ffff;
					fraction_y = fxY & 0x0000ffff;

					new_index = new_y * width + new_x;

					// check boundary, prevent access violation
					if( new_index >= 0 )
					{
							Src_LB = src[new_index];

							//when meet boundary, we set out of boundary point to original point
							if(new_x + 1 != width)
							{
									Src_RB = src[new_index+1];

									if(new_y + 1 != height)
									{
											Src_LT = src[new_index+width];
											Src_RT = src[new_index+width+1];
									}
									else
									{
											Src_LT = Src_LB;
											Src_RT = Src_LB;
									}
							}
							else
							{
									Src_RB = Src_LB;

									if(new_y + 1 != height)
									{
											Src_LT = src[new_index+width];
											Src_RT = Src_LT;
									}
									else
									{
											Src_LT = Src_LB;
											Src_RT = Src_LB;
									}
							}
					}

					tempRGB1.x = ( (Src_LB.x << 16) + (Src_RB.x - Src_LB.x) * fraction_x ) >> 16;
					tempRGB1.y = ( (Src_LB.y << 16) + (Src_RB.y - Src_LB.y) * fraction_x ) >> 16;
					tempRGB1.z = ( (Src_LB.z << 16) + (Src_RB.z - Src_LB.z) * fraction_x ) >> 16;

					tempRGB2.x = ( (Src_LT.x << 16) + (Src_RT.x - Src_LT.x) * fraction_x ) >> 16;
					tempRGB2.y = ( (Src_LT.y << 16) + (Src_RT.y - Src_LT.y) * fraction_x ) >> 16;
					tempRGB2.z = ( (Src_LT.z << 16) + (Src_RT.z - Src_LT.z) * fraction_x ) >> 16;

					tempDst.x = ( (tempRGB1.x << 16) + (tempRGB2.x - tempRGB1.x) * fraction_y ) >> 16;
					tempDst.y = ( (tempRGB1.y << 16) + (tempRGB2.y - tempRGB1.y) * fraction_y ) >> 16;
					tempDst.z = ( (tempRGB1.z << 16) + (tempRGB2.z - tempRGB1.z) * fraction_y ) >> 16;
			}
	}

	tempDst.w = (getAlphaType == 1)? src[index].w : tempDst.w;
	tempDst.w = (getAlphaType == 2)? 255 : tempDst.w;

	dst[index] = tempDst;
}

// buildOptions=
// RUN: %occ-cli %s --cl-options="-I%cwd -I%S " %cfg_path --cl-device=%cl_device 2>&1
