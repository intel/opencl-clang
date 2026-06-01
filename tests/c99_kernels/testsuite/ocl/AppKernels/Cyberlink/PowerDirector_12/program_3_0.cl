__constant sampler_t imageSampler = CLK_NORMALIZED_COORDS_FALSE | CLK_ADDRESS_CLAMP | CLK_FILTER_NEAREST;
__constant sampler_t imageSampler2 = CLK_NORMALIZED_COORDS_FALSE | CLK_ADDRESS_CLAMP | CLK_FILTER_NEAREST;

__kernel void Abstractionism_Quantization_And_Gray(__read_only image2d_t src, __write_only image2d_t dst, int width, int height, int quantization)
{
	int2 coord = (int2)(get_global_id(0), get_global_id(1));

	uint4 tempSrc;
	uint4 tempDst;

	tempSrc = read_imageui(src, imageSampler, coord);

	tempDst.x = (int)tempSrc.x / quantization * quantization;
	tempDst.y = (int)tempSrc.y / quantization * quantization;
	tempDst.z = (int)tempSrc.z / quantization * quantization;
	tempDst.w = (( 1053 * (int)tempDst.z + 2064 * (int)tempDst.y +  401 * (int)tempDst.x +  67584 ) >> 12);

	write_imageui(dst, coord, tempDst);
}

__kernel void Abstractionism_Emboss_Down_Left(__read_only image2d_t src, __write_only image2d_t dst, int width, int height)
{
	int2 coord = (int2)(get_global_id(0), get_global_id(1));
	int w = get_global_id(0);
	int h = get_global_id(1);

	uint4 tempSrc;
	uint4 tempDst;

	if(w >= 1 && h >= 1 && w < (width - 1) && h < (height - 1))
	{
		coord = (int2)(w - 1, h + 1);
		tempSrc = read_imageui(src, imageSampler, coord);
		coord = (int2)(w + 1, h - 1);
		tempDst = read_imageui(src, imageSampler2, coord);

		tempDst.x = max(min((int)tempSrc.w - (int)tempDst.w + 128, 255), 0);
	}
	else
	{
		tempDst.x = 128;
	}
	tempDst.y = 0;
	tempDst.z = 0;

	coord = (int2)(w, h);
	write_imageui(dst, coord, tempDst);
}

__kernel void Abstractionism_Blend(__read_only image2d_t src, __read_only image2d_t emboss, __write_only image2d_t dst, int width, int height, float fScale)
{
	int2 coord = (int2)(get_global_id(0), get_global_id(1));

	uint4 tempSrc;
	uint4 tempDst;

	tempSrc = read_imageui(src, imageSampler, coord);
	tempDst = read_imageui(emboss, imageSampler2, coord);
	int nTempValue = ((int)fScale * ((int)tempDst.x - 128));

	tempDst.x = max(min((int)tempSrc.x + nTempValue, 255), 0);
	tempDst.y = max(min((int)tempSrc.y + nTempValue, 255), 0);
	tempDst.z = max(min((int)tempSrc.z + nTempValue, 255), 0);
	tempDst.w = 255;

	write_imageui(dst, coord, tempDst);
}

__kernel void  Abstractionism_Merged_Emboss_Blend_Cvt( __read_only image2d_t src,  __global	uchar4 * dst, int width, int height, int iScale )
{
	int2 coord;
	int w = get_global_id(0);
	int h = get_global_id(1);

	uint4 tempSrc;	// quantized+Gray frame
	int4 tempDst;	// embossed temp

	// gray scale embossing

	coord = (int2)(w - 1, h + 1);
	tempSrc = read_imageui(src, imageSampler, coord);

	coord = (int2)(w + 1, h - 1);
	tempDst = convert_int4( read_imageui(src, imageSampler2, coord) );

	tempDst.x = clamp( ((int)tempSrc.w - (int)tempDst.w ), -128, 127);

	tempDst.x = ( (w == 0) || ( w == width-1 )  || ( h == 0 ) || ( h == height-1)	)? 0  : tempDst.x;

//=================================

	// apply emboss to image

	coord = (int2)(w, h);

	tempSrc = read_imageui(src, imageSampler, coord);

	int nTempValue = (iScale * (tempDst.x ) );

	tempDst.x = ((int)tempSrc.x + nTempValue);
	tempDst.y = ((int)tempSrc.y + nTempValue);
	tempDst.z = ((int)tempSrc.z + nTempValue);
	tempDst.w = 255;

	int	index = w + h*width;

	uchar4 uc4_temp = convert_uchar4_sat( tempDst );

	if( w < width && h < height )
	{
		dst[index] = uc4_temp;
	}

}



// buildOptions=
// RUN: %occ-cli %s --cl-options="-I%cwd -I%S " %cfg_path --cl-device=%cl_device 2>&1
