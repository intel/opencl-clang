__kernel void clKernel(__read_only image3d_t volume, __write_only image2d_t texture, float iVar, float iExp, char iAxis)

{
	uint x = get_global_id(0);
    uint y = get_global_id(1);
    uint w = get_global_size(0);
    uint h = get_global_size(1);

	const sampler_t volumeSampler = CLK_NORMALIZED_COORDS_TRUE | CLK_ADDRESS_CLAMP | CLK_FILTER_LINEAR;

	float4 pos;
	switch (iAxis)
	{
		case 'x':
			pos.x = iVar;
			pos.y = x/(float)w;
			pos.z = y/(float)h;
		break;
		case 'y':
			pos.x = x/(float)w;
			pos.y = iVar;
			pos.z = y/(float)h;
		break;
		case 'z':
			pos.x = x/(float)w;
			pos.y = y/(float)h;
			pos.z = iVar;
		break;
	}
    float4 sample = exp(-8.0f*iExp*read_imagef(volume, volumeSampler, pos));

	write_imagef(texture, (int2)(x,y),sample);

}


// buildOptions=
// RUN: %occ-cli %s --cl-options="-I%cwd -I%S " %cfg_path --cl-device=%cl_device 2>&1
