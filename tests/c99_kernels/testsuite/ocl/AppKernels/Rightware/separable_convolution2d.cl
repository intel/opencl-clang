/**
* Separable convolution kernels for image/generic 2d signal processing
* Copyright 2011 by Rightware. All rights reserved.
*/

/* TODO: Pass via clBuildProgram */

#define K_WIDTH 9
#define K_HEIGHT 9


__kernel void convolutionNaiveRowsFloat(__write_only image2d_t dst_image, __read_only image2d_t src_image, __constant float* conv_kernel)
{
    const sampler_t sampler=CLK_NORMALIZED_COORDS_FALSE | CLK_ADDRESS_CLAMP_TO_EDGE | CLK_FILTER_NEAREST;
    int x = get_global_id(0);
    int y = get_global_id(1);
 	float4 col = (float4)(0.0f, 0.0f, 0.0f, 0.0f);

	for(int i = -K_WIDTH/2; i <= K_WIDTH/2; i++)
        {
        col += read_imagef(src_image, sampler, (int2)(x + i, y)) * conv_kernel[(i + K_WIDTH/2)];
        }

    write_imagef(dst_image, (int2)(x, y), col);
}

__kernel void convolutionNaiveColumnsFloat(__write_only image2d_t dst_image, __read_only image2d_t src_image, __constant float* conv_kernel)
{
    const sampler_t sampler=CLK_NORMALIZED_COORDS_FALSE | CLK_ADDRESS_CLAMP_TO_EDGE | CLK_FILTER_NEAREST;
    int x = get_global_id(0);
    int y = get_global_id(1);
 	float4 col = (float4)(0.0f, 0.0f, 0.0f, 0.0f);

	for(int j=-K_HEIGHT/2; j <= K_HEIGHT/2; j++)
        {
        col += read_imagef(src_image, sampler, (int2)(x, y + j)) * conv_kernel[(j + K_HEIGHT/2)];
        }

    write_imagef(dst_image, (int2)(x, y), col);
}


// buildOptions=
// RUN: %occ-cli %s --cl-options="-I%cwd -I%S " %cfg_path --cl-device=%cl_device 2>&1
