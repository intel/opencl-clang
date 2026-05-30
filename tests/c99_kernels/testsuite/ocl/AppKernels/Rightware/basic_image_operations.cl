/**
* OpenCL Basic image operations
* Contains basic functions such as summing and subracting two images
* Copyright 2011 by Rightware. All rights reserved.
*/

/* */
__kernel void addConstantMultiply(__write_only image2d_t dst_image, __read_only image2d_t src_image, __read_only image2d_t scaled_image, float scaleFactor)
{
    const sampler_t sampler=CLK_NORMALIZED_COORDS_FALSE | CLK_ADDRESS_CLAMP_TO_EDGE | CLK_FILTER_NEAREST;
    int x = get_global_id(0);
    int y = get_global_id(1);
    float4 scalecol = read_imagef(scaled_image, sampler, (int2)(x, y));
    scalecol.w = 0.0f;
    float4 col = read_imagef(src_image, sampler, (int2)(x, y)) + scaleFactor * length(scalecol);
        col.w = 1.0f;
    write_imagef(dst_image, (int2)(x,y), col);
}


// buildOptions=
// RUN: %occ-cli %s --cl-options="-I%cwd -I%S " %cfg_path --cl-device=%cl_device 2>&1
