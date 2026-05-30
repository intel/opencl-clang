__kernel void clMerge(__read_only image2d_t srce, __read_only image2d_t line, __write_only image2d_t dest)
{
	const sampler_t srceSampler = CLK_NORMALIZED_COORDS_FALSE | CLK_FILTER_NEAREST | CLK_ADDRESS_CLAMP;
	int x = get_global_id(0);
	int y = get_global_id(1);
	float4 RGBA = read_imagef(srce, srceSampler, (int2)(x,y));
	float4 LINE = read_imagef(line, srceSampler, (int2)(x,y));

	if (LINE.x/100.0 > 0.002 )
	{
		RGBA = (float4)(0,0,0,1);
	}
	else
	{
		//RGBA = (float4)(100,100,100,1);
	}



	write_imagef(dest, (int2)(x,y), RGBA);
}


// buildOptions=
// RUN: %occ-cli %s --cl-options="-I%cwd -I%S " %cfg_path --cl-device=%cl_device 2>&1
