__constant sampler_t imageSampler = CLK_NORMALIZED_COORDS_FALSE | CLK_ADDRESS_CLAMP | CLK_FILTER_NEAREST;
__constant sampler_t imageSampler2 = CLK_NORMALIZED_COORDS_FALSE | CLK_ADDRESS_CLAMP | CLK_FILTER_NEAREST;

__kernel void RGBtoGray(__read_only image2d_t src, __write_only image2d_t dst)
{

	int2 coord = (int2)(get_global_id(0), get_global_id(1));

	uint4 tempSrc;
	uint4 tempDst;

	tempSrc = read_imageui(src, imageSampler, coord);

	tempDst.x = (( 1053 * (int)tempSrc.z + 2064 * (int)tempSrc.y +  401 * (int)tempSrc.x +  67584 ) >> 12);

	write_imageui(dst, coord, tempDst);
}

__kernel void YUVtoGray(__read_only image2d_t src, __write_only image2d_t dst)
{

	int2 coord = (int2)(get_global_id(0), get_global_id(1));

	uint4 tempSrc;
	uint4 tempDst;

	tempSrc = read_imageui(src, imageSampler, coord);

	tempDst.x = tempSrc.z;

	write_imageui(dst, coord, tempDst);
}

__kernel void WoodCut_RGB(__read_only image2d_t src, __read_only image2d_t mask, __write_only image2d_t dst)
{

	int2 coord = (int2)(get_global_id(0), get_global_id(1));

	uint4 tempSrc;
	uint4 tempMask;
	uint4 tempDst;
	uint Gray;

	tempSrc = read_imageui(src, imageSampler, coord);
	tempMask = read_imageui(mask, imageSampler2, coord);

	float relativeDiff = (float)(tempSrc.x) / (float)(tempMask.x);

	Gray = tempSrc.x;

	if(relativeDiff < 1.0f)
	{
		float mult = (0.025f - min(0.025f, (1.0f - relativeDiff))) / 0.025f;
		//float mult = (0.025 - min(0.025, (1.0 - relativeDiff))) / 0.025;
		Gray = (int)((float)(tempMask.x) * mult);
	}

	if(Gray != 0)
	{
		Gray = 255;
	}

	tempDst.x = Gray;
	tempDst.y = Gray;
	tempDst.z = Gray;
	tempDst.w = 255;


	write_imageui(dst, coord, tempDst);
}

__kernel void WoodCut_YUV(__read_only image2d_t src, __read_only image2d_t mask, __write_only image2d_t dst)
{

	int2 coord = (int2)(get_global_id(0), get_global_id(1));

	uint4 tempSrc;
	uint4 tempMask;
	uint4 tempDst;
	uint Gray;

	tempSrc = read_imageui(src, imageSampler, coord);
	tempMask = read_imageui(mask, imageSampler2, coord);

	float relativeDiff = (float)(tempSrc.x) / (float)(tempMask.x);

	Gray = tempSrc.x;

	if(relativeDiff < 1.0f)
	{
		float mult = (0.025 - min(0.025f, (1.0f - relativeDiff))) / 0.025f;
		//float mult = (0.025 - min(0.025, (1.0 - relativeDiff))) / 0.025;
		Gray = (int)((float)(tempMask.x) * mult);
	}

	if(Gray != 0)
	{
		tempDst.x = 128;
		tempDst.y = 128;
		tempDst.z = 235;
	}
	else
	{
		tempDst.x = 128;
		tempDst.y = 128;
		tempDst.z = 16;
	}

	tempDst.w = 255;

	write_imageui(dst, coord, tempDst);
}


// buildOptions=
// RUN: %occ-cli %s --cl-options="-I%cwd -I%S " %cfg_path --cl-device=%cl_device 2>&1
