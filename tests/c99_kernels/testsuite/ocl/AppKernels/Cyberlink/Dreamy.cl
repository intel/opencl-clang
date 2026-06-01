__constant sampler_t imageSampler = CLK_NORMALIZED_COORDS_FALSE | CLK_ADDRESS_CLAMP | CLK_FILTER_NEAREST;
__constant sampler_t imageSamplerBack = CLK_NORMALIZED_COORDS_FALSE | CLK_ADDRESS_CLAMP | CLK_FILTER_NEAREST;


__kernel void Dreamy(__read_only image2d_t src, __read_only image2d_t back, __write_only image2d_t dst, int width, int height)
{
	int2 coord = (int2)(get_global_id(0), get_global_id(1));
	int w = get_global_id(0);
	int h = get_global_id(1);

	uint4 tempSrc;// = {0, 0, 0, 0};
	uint4 tempDest;// = {0, 0, 0, 0};

	coord = (int2)(get_global_id(0), get_global_id(1));
	tempSrc = read_imageui(src, imageSampler, coord);
	tempDest = read_imageui(back, imageSampler, coord);

	//tempDest.x = 255 - ( ( (int)(255 - tempDest.x) * (int)(255 - tempSrc.x) ) >> 8 );
	//tempDest.y = 255 - ( ( (int)(255 - tempDest.y) * (int)(255 - tempSrc.y) ) >> 8 );
	//tempDest.z = 255 - ( ( (int)(255 - tempDest.z) * (int)(255 - tempSrc.z) ) >> 8 );
	tempDest = 255 - ( ( (255 - tempDest) * (255 - tempSrc) ) >> 8 );


	write_imageui(dst, coord, tempDest);

}


// buildOptions=
// RUN: %occ-cli %s --cl-options="-I%cwd -I%S " %cfg_path --cl-device=%cl_device 2>&1
