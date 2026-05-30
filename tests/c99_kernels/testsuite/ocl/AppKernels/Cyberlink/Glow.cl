__constant sampler_t imageSampler = CLK_NORMALIZED_COORDS_FALSE | CLK_ADDRESS_CLAMP | CLK_FILTER_NEAREST;

__kernel void LinearDodge_1(__read_only image2d_t src, __write_only image2d_t dst, int GlowLevel)
{

	int2 coord = (int2)(get_global_id(0), get_global_id(1));

	uint4 tempSrc;
	uint4 tempDst;

	tempSrc = read_imageui(src, imageSampler, coord);

	tempDst.x = min((int)tempSrc.x + (int)tempSrc.x * GlowLevel, 255);
	tempDst.y = min((int)tempSrc.y + (int)tempSrc.y * GlowLevel, 255);
	tempDst.z = min((int)tempSrc.z + (int)tempSrc.z * GlowLevel, 255);

	tempDst.w = 255;

	write_imageui(dst, coord, tempDst);
}


__kernel void LinearDodge_2(__read_only image2d_t src, __write_only image2d_t dst, int GlowLevel)
{

	int2 coord = (int2)(get_global_id(0), get_global_id(1));

	uint4 tempSrc;
	uint4 tempDst;

	tempSrc = read_imageui(src, imageSampler, coord);

	tempDst.x = min((int)tempSrc.x + ((int)tempSrc.x * GlowLevel >> 16), 255);
	tempDst.y = min((int)tempSrc.y + ((int)tempSrc.y * GlowLevel >> 16), 255);
	tempDst.z = min((int)tempSrc.z + ((int)tempSrc.z * GlowLevel >> 16), 255);

	tempDst.w = 255;

	write_imageui(dst, coord, tempDst);
}



// buildOptions=
// RUN: %occ-cli %s --cl-options="-I%cwd -I%S " %cfg_path --cl-device=%cl_device 2>&1
