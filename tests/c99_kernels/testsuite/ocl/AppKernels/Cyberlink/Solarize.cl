
__kernel void Solarize_Global(__global const uchar4* src, __global uchar4* dst, int width, int height,
unsigned char paramThreshold, unsigned char getAlphaType)
{
	int index = get_global_id(0);

	uchar4 tempSrc = src[index];
	uchar4 tempDst;

	tempDst.x = (tempSrc.x >= paramThreshold)? (255 - tempSrc.x) : tempSrc.x;	// B

	tempDst.y = (tempSrc.y >= paramThreshold)? (255 - tempSrc.y) : tempSrc.y;	// G

	tempDst.z = (tempSrc.z >= paramThreshold)? (255 - tempSrc.z) : tempSrc.z;	// R

	if(getAlphaType == 1)
		tempDst.w = tempSrc.w;
	else if(getAlphaType == 2)
		tempDst.w = 255;

	dst[index] = tempDst;
}


// buildOptions=
// RUN: %occ-cli %s --cl-options="-I%cwd -I%S " %cfg_path --cl-device=%cl_device 2>&1
