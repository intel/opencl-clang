/**
* Generic image convolution implementations for BasemarkCL
*
* Naive 2d convolution. Measures performance of situations where the kernel developer has no knowledge/interest whatsoever of the underlying hardware.
* conv_kernel points to (K_WIDTH)*(K_HEIGHT) amount of floating point data. The kernel is assumed to be normalized. Only kernels with odd dimension are supported.
*
* Copyright 2011 by Rightware. All rights reserved.
*/


/** These cannot be passed from buildprogram as binary kernels must be supported */
#define K_WIDTH 3
#define K_HEIGHT 3


/** Currently we use only the float version as OpenGL 2.1 only has texture formats in the base that map to cl image which must use _imagef functions */
__kernel void convolutionNaive2dFloat(__write_only image2d_t dst_image, __read_only image2d_t src_image,__constant float* conv_kernel)
{
    const sampler_t sampler = CLK_NORMALIZED_COORDS_FALSE | CLK_ADDRESS_CLAMP_TO_EDGE | CLK_FILTER_NEAREST;
    int x = get_global_id(0);
    int y = get_global_id(1);
    float4 col = (float4)(0.0f, 0.0f, 0.0f, 0.0f);

    for(int i = -K_WIDTH/2; i <= K_WIDTH/2; i++)
       for(int j = -K_HEIGHT/2; j <= K_HEIGHT/2; j++)
       {
          col += read_imagef(src_image, sampler, (int2)(x + i, y + j)) * conv_kernel[K_WIDTH * (j + K_HEIGHT/2) + (i + K_WIDTH/2)];
       }

    col.w = 1.0f;
    write_imagef(dst_image, (int2)(x, y), col);
}

// buildOptions=
// RUN: %occ-cli %s --cl-options="-I%cwd -I%S " %cfg_path --cl-device=%cl_device 2>&1
