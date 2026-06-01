
__constant sampler_t imageSampler = CLK_NORMALIZED_COORDS_FALSE | CLK_ADDRESS_CLAMP | CLK_FILTER_NEAREST;

__kernel void LightRay_Global(__read_only image2d_t src, __write_only image2d_t dst, __global const int * ScaleX, __global const int *ScaleY, int width, int height, int CenterX, int CenterY, int degree, unsigned char getAlphaType)
{

	int2 coord = (int2)(get_global_id(0), get_global_id(1));

	int xShift = 0;
	int yShift = 0;
	uint4 SumARGB = {0, 0, 0, 0};
	uint4 tempSrc;


	int Reciprocal = 65536 / degree;

	for(int iLayerCount=0; iLayerCount<degree; iLayerCount++ )
	{

		xShift = ((((int)get_global_id(0) - CenterX) * (int)ScaleX[iLayerCount]) >> 16) + CenterX;
		yShift = ((((int)get_global_id(1) - CenterY) * (int)ScaleY[iLayerCount]) >> 16) + CenterY;

		coord = (int2)(xShift, yShift);
		tempSrc = read_imageui(src, imageSampler, coord);

		SumARGB += tempSrc;
	}

	SumARGB = (SumARGB * Reciprocal) >> 16;

	coord = (int2)(get_global_id(0), get_global_id(1));
	tempSrc = read_imageui(src, imageSampler, coord);

	SumARGB.x = 255 - ( ( (255 - SumARGB.x) * (255 - tempSrc.x) )>>8 );
	SumARGB.y = 255 - ( ( (255 - SumARGB.y) * (255 - tempSrc.y) )>>8 );
	SumARGB.z = 255 - ( ( (255 - SumARGB.z) * (255 - tempSrc.z) )>>8 );

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
__kernel void LightRay_Global(__read_only image2d_t src, __write_only image2d_t dst, __read_only image2d_t ScaleX, __read_only image2d_t ScaleY, int width, int height, int CenterX, int CenterY, int degree, unsigned char getAlphaType)
{

	int2 coord = (int2)(get_global_id(0), get_global_id(1));

	int xShift = 0;
	int yShift = 0;
	uint4 SumARGB = {0, 0, 0, 0};
	uint4 tempSrc;


	int Reciprocal = 65536 / degree;

	for(int iLayerCount=0; iLayerCount<degree; iLayerCount++ )
	{

		coord = (int2)(iLayerCount, 0);
		xShift = ((((int)get_global_id(0) - CenterX) * (int)(read_imageui(ScaleX, ScaleXSampler, coord).x)) >> 16) + CenterX;
		yShift = ((((int)get_global_id(1) - CenterY) * (int)(read_imageui(ScaleY, ScaleYSampler, coord).x)) >> 16) + CenterY;

		coord = (int2)(xShift, yShift);
		tempSrc = read_imageui(src, imageSampler, coord);

		SumARGB += tempSrc;
	}

	SumARGB = (SumARGB * Reciprocal) >> 16;

	coord = (int2)(get_global_id(0), get_global_id(1));
	tempSrc = read_imageui(src, imageSampler, coord);

	SumARGB.x = 255 - ( ( (255 - SumARGB.x) * (255 - tempSrc.x) )>>8 );
	SumARGB.y = 255 - ( ( (255 - SumARGB.y) * (255 - tempSrc.y) )>>8 );
	SumARGB.z = 255 - ( ( (255 - SumARGB.z) * (255 - tempSrc.z) )>>8 );

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
