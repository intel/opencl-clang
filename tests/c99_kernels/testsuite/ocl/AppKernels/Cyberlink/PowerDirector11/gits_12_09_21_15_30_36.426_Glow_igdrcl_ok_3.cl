__constant sampler_t imageSampler = CLK_NORMALIZED_COORDS_FALSE | CLK_ADDRESS_CLAMP | CLK_FILTER_NEAREST;

__kernel void Glow_LinearDodge_1(__read_only image2d_t src, __write_only image2d_t dst, int GlowLevel)
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


__kernel void Glow_LinearDodge_2(__read_only image2d_t src, __write_only image2d_t dst, int GlowLevel)
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


__kernel void Glow_LinearDodge_1buf(__global uchar4 * src, __global uchar4 * dst, int GlowLevel)
{
	int index =  get_global_id(0);

	uchar4	glowMult = (uchar4)GlowLevel;

	uchar4 tempDst; //=  mad_sat( src[index], glowMult, 0 );

	tempDst.w = 255;

	dst[index] = tempDst;
}


__kernel void Glow_LinearDodge_2buf(__global uchar4 * src, __global uchar4 * dst, float GlowLevel)
{
	int index = get_global_id(0);

	float4	glowMult = (float4)GlowLevel;

	uchar4 tempDst;

	tempDst = convert_uchar4_sat( glowMult * convert_float4( src[index] ) );

	tempDst.w = 255;

	dst[index] = tempDst;
}

// buildOptions=
// RUN: %occ-cli %s --cl-options="-I%cwd -I%S " %cfg_path --cl-device=%cl_device 2>&1
