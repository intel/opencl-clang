/**
* Generic image convolution implementations for BasemarkCL
* Copyright 2011 by Rightware. All rights reserved.
*/

/*
TODO:
Make version with and without OpenCL image support.
*/

/* Naive 2d convolution. Measures performance of situations where the kernel developer has no knowledge/interest whatsoever of the underlying hardware.
   conv_kernel points to (K_WIDTH)*(K_HEIGHT) amount of floating point data. The kernel is assumed to be normalized. Only kernels with odd dimension are supported.
*/

/* TODO: Pass from clBuildProgram */
#define K_WIDTH 3
#define K_HEIGHT 3


__kernel void convolutionNaive2dFloat(__write_only image2d_t dst_image, __read_only image2d_t src_image,__constant float* conv_kernel)
{
    const sampler_t sampler=CLK_NORMALIZED_COORDS_FALSE | CLK_ADDRESS_CLAMP_TO_EDGE | CLK_FILTER_NEAREST;
    int x = get_global_id(0);
    int y = get_global_id(1);
 	float4 col = (float4)(0,0,0,0);

	for(int i=-K_WIDTH/2;i<=K_WIDTH/2;i++)
	    for(int j=-K_HEIGHT/2;j<=K_HEIGHT/2;j++)
        {
            col += read_imagef(src_image,sampler,(int2)(x+i,y+j))*conv_kernel[K_WIDTH*(j+K_HEIGHT/2)+(i+K_WIDTH/2)];
        }
    col.w = 1.0f;
    write_imagef(dst_image,(int2)(x,y),col);
}

__kernel void convolutionNaive2dUint(__write_only image2d_t dst_image, __read_only image2d_t src_image,__constant uchar* conv_kernel, uint norm_val, int k_width, int k_height)
{
    const sampler_t sampler=CLK_NORMALIZED_COORDS_FALSE|CLK_ADDRESS_CLAMP|CLK_FILTER_NEAREST;
    int x = get_global_id(0);
    int y = get_global_id(1);
 	uint4 col = (uint4)(0,0,0,0);

	for(int i=-k_width/2;i<=k_width/2;i++)
	    for(int j=-k_height/2;j<=k_height/2;j++)
        {
            col += read_imageui(src_image,sampler,(int2)(x+i,y+j))*conv_kernel[k_width*(j+k_height/2)+(i+k_width/2)];
        }
    col.w = 1.0f;
    write_imageui(dst_image,(int2)(x,y),col/norm_val);
}

/*
More local cache aware implementation. Load part of the image to cache along with the respective 'haloes' and perform the convolution.
imbuff points to float*4*((local_size(0)+k_width-1)*(local_size(1)+k_height-1)) amount of data.
*/
__kernel void convolution2dFloat(__write_only image2d_t dst_image, __read_only image2d_t src_image,__constant float* conv_kernel, __local float4 *imbuff, int k_width, int k_height)
{
    const sampler_t sampler=CLK_NORMALIZED_COORDS_FALSE|CLK_ADDRESS_CLAMP|CLK_FILTER_NEAREST;

    /* TODO: Figure out the optimal way to load the halo */

    /* Load main values to local memory */
    imbuff[get_local_id(0)+k_width/2+(get_local_id(1)+(k_height/2))*(get_local_size(0)+k_width-1)] = read_imagef(src_image,sampler,(int2)(get_global_id(0),get_global_id(1)));
    barrier(CLK_LOCAL_MEM_FENCE);

}


// buildOptions=
// RUN: %occ-cli %s --cl-options="-I%cwd -I%S " %cfg_path --cl-device=%cl_device 2>&1
