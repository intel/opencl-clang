__constant sampler_t imageSampler = CLK_NORMALIZED_COORDS_FALSE | CLK_ADDRESS_CLAMP | CLK_FILTER_NEAREST;

__kernel void Radialblur_Global(__read_only image2d_t src, __write_only image2d_t dst,
				__global const uint* ScaleX, __global const uint* ScaleY, __global const uint* OffsetY,
				local uint* LocalScaleX, local uint* LocalScaleY, local uint* LocalOffsetY,
				 int width, int height, int degree, int reciprocal, unsigned char getAlphaType)
{
	int RADIAL_BLUR_MAX_DEGREE = 50;
	// use LocalMemory
	int Lid0 = get_local_id(0);
	int Lid1 = get_local_id(1);
	int Lsize0 = get_local_size(0);
	int Lsize1 = get_local_size(1);

	// copy GlobalMemory to LocalMemory
	int group_size = Lsize0 * Lsize1;
	int LocalID = Lid1 * Lsize0 + Lid0;

	while(LocalID < RADIAL_BLUR_MAX_DEGREE){
		LocalScaleX[LocalID] = ScaleX[LocalID];
		LocalScaleY[LocalID] = ScaleY[LocalID];
		LocalOffsetY[LocalID] = OffsetY[LocalID];

		LocalID += group_size;
	}

	barrier(CLK_LOCAL_MEM_FENCE);


	int2 coord = (int2)(get_global_id(0), get_global_id(1));

	int xShift = 0;
	int yShift = 0;
	uint4 SumARGB = {0, 0, 0, 0};
	uint4 tempSrc;

	for(int iLayerCount=0; iLayerCount<degree; iLayerCount++ )
	{
		yShift = ((get_global_id(1) + LocalOffsetY[iLayerCount]) * LocalScaleY[iLayerCount] ) >> 16;
		xShift = ((get_global_id(0) + iLayerCount) * LocalScaleX[iLayerCount]) >> 16;

		coord = (int2)(xShift, yShift);
		tempSrc = read_imageui(src, imageSampler, coord);


		SumARGB += tempSrc;
	}

	SumARGB = (SumARGB * reciprocal) >> 16;

	coord = (int2)(get_global_id(0), get_global_id(1));

	if(getAlphaType == 1)
	{
		tempSrc = read_imageui(src, imageSampler, coord);
		SumARGB.w = tempSrc.w;
	}
	else if(getAlphaType == 2)
	{
		tempSrc = read_imageui(src, imageSampler, coord);
		SumARGB.w = 255;
	}

	write_imageui(dst, coord, SumARGB);
}

// buildOptions=
// RUN: %occ-cli %s --cl-options="-I%cwd -I%S " %cfg_path --cl-device=%cl_device 2>&1
