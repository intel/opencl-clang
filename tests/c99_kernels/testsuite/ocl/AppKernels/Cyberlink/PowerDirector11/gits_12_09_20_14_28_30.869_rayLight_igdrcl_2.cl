
__constant sampler_t imageSampler = CLK_NORMALIZED_COORDS_FALSE | CLK_ADDRESS_CLAMP | CLK_FILTER_NEAREST;

__kernel void LightRay_Global(__read_only image2d_t src, __write_only image2d_t dst,
			      __global const int * ScaleX, __global const int *ScaleY,
			      local int* LocalScaleX, local int* LocalScaleY,
			      int width, int height, int CenterX, int CenterY, int degree)
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

		LocalID += group_size;
	}

	barrier(CLK_LOCAL_MEM_FENCE);


	int2 coord = (int2)(get_global_id(0), get_global_id(1));

	int xShift = 0;
	int yShift = 0;
	uint4 SumARGB = {0, 0, 0, 0};
	uint4 tempSrc;


	int Reciprocal = 65536 / degree;

	for(int iLayerCount=0; iLayerCount<degree; iLayerCount++ )
	{

		xShift = ((((int)get_global_id(0) - CenterX) * (int)LocalScaleX[iLayerCount]) >> 16) + CenterX;
		yShift = ((((int)get_global_id(1) - CenterY) * (int)LocalScaleY[iLayerCount]) >> 16) + CenterY;

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

	write_imageui(dst, coord, SumARGB);
}

__kernel void LightRay_Global_SourceAlpha(__read_only image2d_t src, __write_only image2d_t dst,
			      __global const int * ScaleX, __global const int *ScaleY,
			      local int* LocalScaleX, local int* LocalScaleY,
			      int width, int height, int CenterX, int CenterY, int degree)
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

		LocalID += group_size;
	}

	barrier(CLK_LOCAL_MEM_FENCE);


	int2 coord = (int2)(get_global_id(0), get_global_id(1));

	int xShift = 0;
	int yShift = 0;
	uint4 SumARGB = {0, 0, 0, 0};
	uint4 tempSrc;


	int Reciprocal = 65536 / degree;

	for(int iLayerCount=0; iLayerCount<degree; iLayerCount++ )
	{

		xShift = ((((int)get_global_id(0) - CenterX) * (int)LocalScaleX[iLayerCount]) >> 16) + CenterX;
		yShift = ((((int)get_global_id(1) - CenterY) * (int)LocalScaleY[iLayerCount]) >> 16) + CenterY;

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

	tempSrc = read_imageui(src, imageSampler, coord);
	SumARGB.w = tempSrc.w;

	write_imageui(dst, coord, SumARGB);
}

__kernel void LightRay_Global_FullAlpha(__read_only image2d_t src, __write_only image2d_t dst,
			      __global const int * ScaleX, __global const int *ScaleY,
			      local int* LocalScaleX, local int* LocalScaleY,
			      int width, int height, int CenterX, int CenterY, int degree)
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

		LocalID += group_size;
	}

	barrier(CLK_LOCAL_MEM_FENCE);


	int2 coord = (int2)(get_global_id(0), get_global_id(1));

	int xShift = 0;
	int yShift = 0;
	uint4 SumARGB = {0, 0, 0, 0};
	uint4 tempSrc;


	int Reciprocal = 65536 / degree;

	for(int iLayerCount=0; iLayerCount<degree; iLayerCount++ )
	{

		xShift = ((((int)get_global_id(0) - CenterX) * (int)LocalScaleX[iLayerCount]) >> 16) + CenterX;
		yShift = ((((int)get_global_id(1) - CenterY) * (int)LocalScaleY[iLayerCount]) >> 16) + CenterY;

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

	tempSrc = read_imageui(src, imageSampler, coord);
	SumARGB.w = 255;

	write_imageui(dst, coord, SumARGB);
}

////////////////////////////////////////////////////////////
// Original
///////////////////////////////////////////////////////////
/*
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
*/

// buildOptions=
// RUN: %occ-cli %s --cl-options="-I%cwd -I%S " %cfg_path --cl-device=%cl_device 2>&1
