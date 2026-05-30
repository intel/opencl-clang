//global include for a all OpenCL kernels programs

__kernel void clKernel(__write_only image2d_t fbo, __read_only image2d_t dx, __read_only image2d_t dy)
{
	const sampler_t sampler = CLK_NORMALIZED_COORDS_FALSE | CLK_FILTER_NEAREST | CLK_ADDRESS_CLAMP_TO_EDGE;
    int x = get_global_id(0);
    int y = get_global_id(1);

	float4 xd = read_imagef(dx, sampler, (int2)(x,y));
	float4 yd = read_imagef(dy, sampler, (int2)(x,y));

	write_imagef(fbo, (int2)(x,y), (float4)(xd.x, yd.x,yd.x+xd.x,1.0));

}


// buildOptions=
// RUN: %occ-cli %s --cl-options="-I%cwd -I%S " %cfg_path --cl-device=%cl_device 2>&1
