/**
* Bilateral filter OpenCL implementation
*
* Naive implementation of bilateral filter.
*
* Copyright 2011 by Rightware. All rights reserved.
*/


#define RANGE_DEVIATION 2
#define VALUE_DEVIATION 3
#define VALUE_DEVIATION_F (0.075f)


/** Applies a bilateral filter to RGB image. */
__kernel void bilateralFilter(__write_only image2d_t dst_image, __read_only image2d_t src_image)
{
    const sampler_t sampler = CLK_NORMALIZED_COORDS_FALSE | CLK_ADDRESS_CLAMP_TO_EDGE | CLK_FILTER_NEAREST;
    float4 normval = 0.0f;
    int x = get_global_id(0);
    int y = get_global_id(1);
 	  float4 col = (float4)(0, 0, 0, 0);

    float4 icur = read_imagef(src_image,sampler, (int2)(x,y));

    for(int j = -RANGE_DEVIATION*2; j <= RANGE_DEVIATION*2; j++)
    for(int i = -RANGE_DEVIATION*2; i <= RANGE_DEVIATION*2; i++)
    {
        float4 cval = read_imagef(src_image,sampler, (int2)(x+i ,y+j) );
        float4 fval = native_exp(((float)-(i*i + j*j)) / (2.0f*(float)RANGE_DEVIATION*(float)RANGE_DEVIATION) -((icur-cval) * (icur-cval))/(2.0f*VALUE_DEVIATION_F*VALUE_DEVIATION_F));

        normval += fval;
        col += cval*fval;
    }
    write_imagef(dst_image,(int2)(x,y),(col/normval));
    return;
}

/** Bilateral filter implementation using lab colorspace. Currently not in use in the benchmark. */
float4 rgb2xyz(float4 rgb)
{
    float4 xyz;
    /* Inverse gamma correction */
    rgb = select( native_powr((rgb + 0.055f)/1.055f, (float4)(2.4f)), rgb/12.92f, rgb <= 0.04045f);
    xyz.x = dot(rgb,(float4)(0.4124f, 0.3576f, 0.1805f, 0.0f));
    xyz.y = dot(rgb,(float4)(0.2126f, 0.7152f, 0.0722f, 0.0f));
    xyz.z = dot(rgb,(float4)(0.0193f, 0.1192f, 0.9505f, 0.0f));
    xyz.w = 0.0f;
    return xyz;
}

float4 xyz2rgb(float4 xyz)
{
    float4 rgb;

    rgb.x = dot(xyz,(float4)(3.2406f, -1.5372f, -0.4986f, 0.0f));
    rgb.y = dot(xyz,(float4)(-0.9689f, 1.8758f, 0.0415f, 0.0f));
    rgb.z = dot(xyz,(float4)(0.0557f, -0.2040f, 1.0570f, 0.0f));
    rgb.w = 1.0f;
    /* Gamma correction */
    rgb = select(native_powr(rgb, (float4)(1.0f/2.4f))*1.055f - 0.055f, 12.92f*rgb, rgb <= 0.0031307f);
    rgb.w = 1.0f;
    return rgb;
}

#define WHITEPOINT (float4)(0.950456f, 1.0f, 1.088754f, 1.0f)

float4 xyz2lab(float4 xyz)
{
    float4 lab;
    xyz = xyz/WHITEPOINT;

    xyz = select((841.0f/108.0f)*xyz + (4.0f/29.0f), cbrt(xyz), xyz >= (6.0f/29.0f)*(6.0f/29.0f)*(6.0f/29.0f));

    lab.x = 116.0f * xyz.y - 16.0;
    lab.y = 500.0f * (xyz.x - xyz.y);
    lab.z = 200.0f * (xyz.y - xyz.z);
    lab.w = 1.0f;

    return lab;
}

float4 lab2xyz(float4 lab)
{
    float4 xyz;
    xyz.y = (lab.x + 16.0f)/116.0f;
    xyz.x = (lab.x + 16.0f)/116.0f + lab.y/500.0f;
    xyz.z = (lab.x + 16.0f)/116.0f - lab.z/200.0f;
    xyz.w = 1.0f;

    xyz = select( (108.0f/841.0f)*(xyz - (4.0f/29.0f)) , xyz*xyz*xyz , xyz >= 0.2068965517f);

    return xyz*WHITEPOINT;
}

float4 rgb2lab(float4 rgb)
{
    return xyz2lab(rgb2xyz(rgb));
}

float4 lab2rgb(float4 lab)
{
    return xyz2rgb(lab2xyz(lab));
}

#define LAB_DEVIATION 4.0f

/** Applies a bilateral filter in Lab color space while doing the conversion on the fly for each pixel. */
__kernel void bilateralFilterLab(__write_only image2d_t dst_image, __read_only image2d_t src_image)
{
    const sampler_t sampler=CLK_NORMALIZED_COORDS_FALSE|CLK_ADDRESS_CLAMP|CLK_FILTER_NEAREST;
    float normval = 0.0f;
    uint4 colour = (uint4)(0,0,0,255);
    int x = get_global_id(0);
    int y = get_global_id(1);
    float4 col = (float4)(0,0,0,0);
    float4 icur = rgb2lab(convert_float4(read_imageui(src_image,sampler, (int2)(x,y)))/255.0f);

    for(int j=-RANGE_DEVIATION*2;j<=RANGE_DEVIATION*2;j++)
    for(int i=-RANGE_DEVIATION*2;i<=RANGE_DEVIATION*2;i++)
    {
        float4 cval = rgb2lab(convert_float4(read_imageui(src_image,sampler, (int2)(x+i,y+j)))/255.0f);
        float fval = native_exp(((float)-(i*i+j*j)) / (2.0f*(float)RANGE_DEVIATION*(float)RANGE_DEVIATION) - (dot(icur-cval,icur-cval))/(2.0f*(float)LAB_DEVIATION*(float)LAB_DEVIATION));

        normval += fval;
        col += cval*fval;
    }

    write_imageui(dst_image,(int2)(x,y),convert_uint4(255.0f*lab2rgb(col/normval)));
    return;
}


// buildOptions=
// RUN: %occ-cli %s --cl-options="-I%cwd -I%S " %cfg_path --cl-device=%cl_device 2>&1
