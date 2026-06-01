__constant sampler_t imageSampler = CLK_NORMALIZED_COORDS_FALSE | CLK_ADDRESS_CLAMP | CLK_FILTER_NEAREST;
__constant sampler_t imageSampler2 = CLK_NORMALIZED_COORDS_FALSE | CLK_ADDRESS_CLAMP | CLK_FILTER_NEAREST;

__kernel void Quantization_And_Gray(__read_only image2d_t src, __write_only image2d_t dst, int width, int height, int quantization)
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

__kernel void Emboss_Down_Left(__read_only image2d_t src, __write_only image2d_t dst, int width, int height)
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

	coord = (int2)(w, h);
	write_imageui(dst, coord, tempDst);
}

#if 1
__kernel void Blend(__read_only image2d_t src, __read_only image2d_t emboss, __write_only image2d_t dst, int width, int height, float fScale)
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
#else
__kernel void Blend(__read_only image2d_t src, __read_only image2d_t emboss, __write_only image2d_t dst, int width, int height, float fScale)
{

	int2 coord = (int2)(get_global_id(0), get_global_id(1));

	uchar4 tempSrc;
	uchar4 tempDst;

	tempSrc = convert_uchar4(read_imageui(src, imageSampler, coord));
	tempDst = convert_uchar4(read_imageui(emboss, imageSampler2, coord));
	short	 nTempValue = ((short)fScale * ((short)tempDst.x - 128));

	ushort foo;
	ushort fee = (ushort)tempSrc.x + nTempValue;
	foo = clamp(fee, (ushort)0, (ushort)255);
	tempDst.x = foo;
	fee = (ushort)tempSrc.y + nTempValue;
	foo = clamp(fee, (ushort)0, (ushort)255);
	tempDst.y = foo;
	fee = (ushort)tempSrc.z + nTempValue;
	foo = clamp(fee, (ushort)0, (ushort)255);
	tempDst.z = foo;
	tempDst.w = 255;


	write_imageui(dst, coord, convert_uint4(tempDst));
}

#endif



// buildOptions=
// RUN: %occ-cli %s --cl-options="-I%cwd -I%S " %cfg_path --cl-device=%cl_device 2>&1
