
__kernel void ZoomIn_Global(__global const uchar4* src, __global uchar4* dst, int width, int height,
int fxSrcXStart, int fxSrcYStart, int fxSrcStepX, int fxSrcStepY, unsigned char getAlphaType)
{
	int i = get_global_id(0);
	int j = get_global_id(1);
	int index = j * width + i;

	int fxX = fxSrcXStart + i * fxSrcStepX;
	int fxY = fxSrcYStart + j * fxSrcStepY;

	uchar4 Src_LB, Src_LT, Src_RB, Src_RT;

	//-GetPixelColorBilinear_C
	int new_x = fxX >> 16;
	int new_y = fxY >> 16;

	int fraction_x = fxX & 0x0000ffff;
	int fraction_y = fxY & 0x0000ffff;

	int new_index = new_y * width + new_x;

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

	uchar4 tempRGB1, tempRGB2, tempDst;

	tempRGB1.x = ( (Src_LB.x << 16) + (Src_RB.x - Src_LB.x) * fraction_x ) >> 16;
	tempRGB1.y = ( (Src_LB.y << 16) + (Src_RB.y - Src_LB.y) * fraction_x ) >> 16;
	tempRGB1.z = ( (Src_LB.z << 16) + (Src_RB.z - Src_LB.z) * fraction_x ) >> 16;

	tempRGB2.x = ( (Src_LT.x << 16) + (Src_RT.x - Src_LT.x) * fraction_x ) >> 16;
	tempRGB2.y = ( (Src_LT.y << 16) + (Src_RT.y - Src_LT.y) * fraction_x ) >> 16;
	tempRGB2.z = ( (Src_LT.z << 16) + (Src_RT.z - Src_LT.z) * fraction_x ) >> 16;

	tempDst.x = ( (tempRGB1.x << 16) + (tempRGB2.x - tempRGB1.x) * fraction_y ) >> 16;
	tempDst.y = ( (tempRGB1.y << 16) + (tempRGB2.y - tempRGB1.y) * fraction_y ) >> 16;
	tempDst.z = ( (tempRGB1.z << 16) + (tempRGB2.z - tempRGB1.z) * fraction_y ) >> 16;

	tempDst.w = (getAlphaType == 1)? src[index].w : tempDst.w;
    tempDst.w = (getAlphaType == 2)? 255 : tempDst.w;

	dst[index] = tempDst;

}

// buildOptions=
// RUN: %occ-cli %s --cl-options="-I%cwd -I%S " %cfg_path --cl-device=%cl_device 2>&1
