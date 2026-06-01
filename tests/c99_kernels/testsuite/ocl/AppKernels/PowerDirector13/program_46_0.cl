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
		float mult = (0.025f - min(0.025f, (1.0f - relativeDiff))) / 0.025f;
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

///////////////////////////////////////////////////////////////////////////////////////////////
// Buffer
///////////////////////////////////////////////////////////////////////////////////////////////

kernel void RGBtoGray_Buffer( global  uint4 * src, global  uint4 * dst)
{
	size_t	offset = get_global_id(0);

	uint4 tempSrc = src[offset];

	uint4 blue =  ( tempSrc & (uint4)(0x0ff) );
	uint4 green = ( (tempSrc >>8) & (uint4)0x0ff );
	uint4 red =   ( (tempSrc >>16) & (uint4)0x0ff );
	uint4 alpha = ( (tempSrc >>24) & (uint4)0x0ff );

	uint4 tempDst = (( 1053 * red + 2064 * green +  401 * blue +  67584 ) >> 12);

	dst[offset] = min( ( tempDst ), (uint4)255 );
}

__kernel void YUVtoGray_Buffer( __global uint4 * src, __global  uint4 * dst)
{
	size_t offset = get_global_id(0);
	dst[offset] = (src[offset] >> 16) & 0x0ff;
}

__kernel void WoodCut_RGB_Buffer(__global uint4 * src, __global uint4 *  mask, __global uint4 *  dst)
{
	size_t	offset = get_global_id(0);

	float4 tempSrc;
	float4 tempMask;
	uint4 tempDst;
	uint4 Wood;

	tempSrc = convert_float4( src[offset] & 0xff );
	tempMask = convert_float4( mask[offset] & 0xff );

	float4 relativeDiff = tempSrc / tempMask;

	float4 mult = (0.025f - min((float4)0.025f, (1.0f - relativeDiff))) / 0.025f;

	Wood = select( (src[offset] & 0xff), convert_uint4( tempSrc * mult ), (relativeDiff < (float4)1.0f ) );

	Wood = select( Wood, 255, (Wood != 0) );

	Wood =  Wood | (Wood <<8) | (Wood<<16) | 0xFF000000;

	dst[offset] = Wood;
}

__kernel void WoodCut_YUV_Buffer(__global uint4 * src, __global uint4 * mask, __global uint4 * dst)
{
	size_t	offset = get_global_id(0);

	float4 tempSrc;
	float4 tempMask;
	uint4 tempDst;
	uint4 Wood;

	tempSrc = convert_float4( src[offset] );
	tempMask = convert_float4( mask[offset] );

	float4 relativeDiff = tempSrc / tempMask;

	float4 mult = (0.025f - min((float4)0.025f, (1.0f - relativeDiff))) / 0.025f;

	Wood = select( src[offset], convert_uint4( tempSrc * mult ), (relativeDiff < 1.0f) );

	uint4 White = 0xFFEB8080;
	uint4 Black = 0xFF108080;

	Wood = select( Black, White, (Wood != 0) );

	dst[offset] = Wood;
}

__kernel void WoodCut_CopyAlpha_Buffer(__global uchar4 *src, __global uchar4* dst)
{
    size_t index = get_global_id(0);
    dst[index].w = src[index].w;
}


// buildOptions=
// RUN: %occ-cli %s --cl-options="-I%cwd -I%S " %cfg_path --cl-device=%cl_device 2>&1
