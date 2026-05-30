
__constant sampler_t imageSampler = CLK_NORMALIZED_COORDS_FALSE | CLK_ADDRESS_CLAMP | CLK_FILTER_NEAREST;

__kernel void Radialblur_Global(__read_only image2d_t src, __write_only image2d_t dst, __global const uint* ScaleX, __global const uint* ScaleY, __global const uint* OffsetY, int width, int height, int degree, int reciprocal, unsigned char getAlphaType)
{

	int2 coord = (int2)(get_global_id(0), get_global_id(1));

	int xShift = 0;
	int yShift = 0;
	uint4 SumARGB = {0, 0, 0, 0};
	uint4 tempSrc;

	for(int iLayerCount=0; iLayerCount<degree; iLayerCount++ )
	{
		yShift = ((get_global_id(1) + OffsetY[iLayerCount]) * ScaleY[iLayerCount] ) >> 16;
		xShift = ((get_global_id(0) + iLayerCount) * ScaleX[iLayerCount]) >> 16;

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

#if 0
__constant sampler_t ScaleXSampler = CLK_NORMALIZED_COORDS_FALSE | CLK_ADDRESS_CLAMP | CLK_FILTER_NEAREST;
__constant sampler_t ScaleYSampler = CLK_NORMALIZED_COORDS_FALSE | CLK_ADDRESS_CLAMP | CLK_FILTER_NEAREST;
__constant sampler_t OffsetYSampler = CLK_NORMALIZED_COORDS_FALSE | CLK_ADDRESS_CLAMP | CLK_FILTER_NEAREST;
__kernel void Radialblur_Global(__read_only image2d_t src, __write_only image2d_t dst, __read_only image2d_t ScaleX, __read_only image2d_t ScaleY, __read_only image2d_t OffsetY, int width, int height, int degree, int reciprocal, unsigned char getAlphaType)
{

	int2 coord = (int2)(get_global_id(0), get_global_id(1));

	int xShift = 0;
	int yShift = 0;
	uint4 SumARGB = {0, 0, 0, 0};
	uint4 tempSrc;

	for(int iLayerCount=0; iLayerCount<degree; iLayerCount++ )
	{
		coord = (int2)(iLayerCount, 0);
		yShift = ((get_global_id(1) + read_imageui(OffsetY, OffsetYSampler, coord).x) * read_imageui(ScaleY, ScaleYSampler, coord).x ) >> 16;
		xShift = ((get_global_id(0) + iLayerCount) * read_imageui(ScaleX, ScaleXSampler, coord).x) >> 16;

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
#endif


// buildOptions=
// RUN: %occ-cli %s --cl-options="-I%cwd -I%S " %cfg_path --cl-device=%cl_device 2>&1
