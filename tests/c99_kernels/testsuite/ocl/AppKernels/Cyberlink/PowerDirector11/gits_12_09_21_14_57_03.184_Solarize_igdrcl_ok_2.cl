
#if 0
__kernel void Solarize_Global(__global const uchar4* src, __global uchar4* dst, int width, int height,
unsigned char paramThreshold, unsigned char getAlphaType)
{
	int index = get_global_id(0);

	uchar4 tempSrc = src[index];
	uchar4 tempDst;

	// This code plays games with unsigned saturation and signed wrap-around to eliminate conditionals
	//		Which happens to be very good for CPU openCL as well, BTW...

	uchar4 tempMask = sub_sat( add_sat( tempSrc, (255-paramThreshold) ), 254);	// 1 for in range, 0 for out
	tempMask -= (uchar4)1;					// 0 in range, ff out - wrapping around uchar
	tempMask = ~ tempMask;			// ff in range, 0 out

	tempDst = tempSrc ^ tempMask;
	tempDst.w = tempSrc.w;

		// TRC_CHG - since tempDst.w not set above, can default to tempSrc.w
		// tempDst.w = (getAlphaType == 1)? tempSrc.w : tempDst.w;
    tempDst.w = (getAlphaType == 2)? 255 : tempDst.w;

	dst[index] = tempDst;
}



#else

__kernel void Solarize_Global(__global const uchar4* src, __global uchar4* dst, int width, int height,
unsigned char paramThreshold, unsigned char getAlphaType)
{
	int index = get_global_id(0);

	uchar4 tempSrc = src[index];
	uchar4 tempDst;

	tempDst.x = (tempSrc.x >= paramThreshold)? (255 - tempSrc.x) : tempSrc.x;	// B

	tempDst.y = (tempSrc.y >= paramThreshold)? (255 - tempSrc.y) : tempSrc.y;	// G

	tempDst.z = (tempSrc.z >= paramThreshold)? (255 - tempSrc.z) : tempSrc.z;	// R

	tempDst.w = (getAlphaType == 1)? tempSrc.w : tempDst.w;
    tempDst.w = (getAlphaType == 2)? 255 : tempDst.w;

	dst[index] = tempDst;
}

#endif

// buildOptions=
// RUN: %occ-cli %s --cl-options="-I%cwd -I%S " %cfg_path --cl-device=%cl_device 2>&1
