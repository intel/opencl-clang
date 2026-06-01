//#pragma OPENCL EXTENSION cl_amd_printf : enable

__kernel void ip_map(
	__global float2 *mapping,
	__constant float4 * rot_mat)
{
	// Destination image coordiantes and size
	int width  = get_global_size(0);
	int height = get_global_size(1);
	int j      = get_global_id(0);
	int i      = get_global_id(1);

	float4 tmp = (float4)((float)j, (float)i, 1.0f, 0.0f);

	float4 tmp2;
	tmp2.z = dot(rot_mat[2], tmp);
	float z_rec= 1.0f / tmp2.z;
	tmp2.y = dot(rot_mat[1], tmp) * z_rec;
	tmp2.x = dot(rot_mat[0], tmp) * z_rec;

	mapping[width*i + j] = (float2)(tmp2.x, tmp2.y);// tmp2.xy;
}

__kernel void ip_compute(
	__read_only image2d_t input,
	__write_only image2d_t output,
	__constant float4 * rot_mat )
{
	const sampler_t sampler = CLK_NORMALIZED_COORDS_FALSE | CLK_ADDRESS_CLAMP_TO_EDGE | CLK_FILTER_LINEAR;

	// Destination image coordiantes and size
	int j      = get_global_id(0);
	int i      = get_global_id(1);

	float4 tmp = (float4)((float)j, (float)i, 1.0f, 0.0f);

	float4 tmp2;
	tmp2.z = dot(rot_mat[2], tmp);
	float z_rec= 1.0f / tmp2.z;
	tmp2.y = dot(rot_mat[1], tmp) * z_rec;
	tmp2.x = dot(rot_mat[0], tmp) * z_rec;

	float4 pixel;
	pixel = read_imagef(input, sampler, tmp2.xy + (float2)(0.5f) );
	write_imagef(output, (int2)(j, i), pixel);

//  PZOLI TRY: is the IPM less paralelogram-ish, with smoothing?
	//   answere: the downsampling of the original image was the cause of the artifacts. It is corrected there, in Convertimage.cl
//	pixel = read_imagef(input, sampler, tmp2.xy + (float2)(-0.5f, -0.5f));
//	pixel += read_imagef(input, sampler, tmp2.xy + (float2)(-0.5f, 0.5f));
//	pixel += read_imagef(input, sampler, tmp2.xy + (float2)(0.5f, -0.5f));
//	pixel += read_imagef(input, sampler, tmp2.xy + (float2)(0.5f, 0.5f));
//	write_imagef(output, (int2)(j, i), pixel*0.25f);
}




// buildOptions=
// RUN: %occ-cli %s --cl-options="-I%cwd -I%S " %cfg_path --cl-device=%cl_device 2>&1
