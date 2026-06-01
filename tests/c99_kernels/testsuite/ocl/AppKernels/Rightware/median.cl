/**
* OpenCL median and related filter implementations.
* Copyright 2011 by Rightware. All rights reserved.
*/

/* Tukey Ninther. Calculate median of medians. When problem is bandwidth limited this is most likely no faster than normal median filtering. */
__kernel void nintherfilt3x3(__global float *input, __global float *output)
{
    float3 x,y,z;
    float3 medians;
    float median;
    x = vload3(0,input);
    y = vload3(1,input);
    z = vload3(2,input);
    medians = select(min(z,max(x,y)),min(x,y),z<min(x,y));
    median = medians.z < min(medians.x,medians.y) ? min(medians.x,medians.y) : min(medians.z, max(medians.x, medians.y));
}


/* Returns a median of 3x3 matrix */
float median3x3(float3 x,float3 y,float3 z)
{
    float3 xx,yy,zz;
    /* Sort the rows */
    xx = max(x, y);
    zz = min(x, y);
    yy = select(min(z, xx), zz, z < zz);
    xx = max(xx, z);
    zz = min(zz, z);
    /* Transpose the matrix */
    x = (float3)(xx.x, yy.x, zz.x);
    y = (float3)(xx.y, yy.y, zz.y);
    z = (float3)(xx.z, yy.z, zz.z);
    /* Sort the rows again (columns on the end result matrix) */
    xx = max(x, y);
    zz = min(x, y);
    yy = select(min(z, xx), zz, z < zz);
    xx = max(xx, z);
    zz = min(zz, z);

    return zz.x < min(xx.z, yy.y) ? min(xx.z, yy.y) : min(zz.x, max(xx.z, yy.y));
}


/* 3x3 8888 image median filtering.*/
__kernel void medfilt3x3(__write_only image2d_t dst_image, __read_only image2d_t src_image)
{
    const sampler_t sampler = CLK_NORMALIZED_COORDS_FALSE | CLK_ADDRESS_CLAMP_TO_EDGE | CLK_FILTER_NEAREST;

    int x = get_global_id(0);
    int y = get_global_id(1);
    float4 col = (float4)(0,0,0,255);
    float3 colours[9];

	for(int j = 0; j <= 2; j++)
	    for(int i = 0; i <= 2; i++)
        {
	        float4 tmp = read_imagef(src_image, sampler, (int2)(x+i-1,y+j-1));
            colours[i+j*3] = tmp.xyz;
        }

    col.x = median3x3((float3)(colours[0].x,colours[1].x,colours[2].x), (float3)(colours[3].x,colours[4].x,colours[5].x), (float3)(colours[6].x,colours[7].x,colours[8].x));
    col.y = median3x3((float3)(colours[0].y,colours[1].y,colours[2].y), (float3)(colours[3].y,colours[4].y,colours[5].y), (float3)(colours[6].y,colours[7].y,colours[8].y));
    col.z = median3x3((float3)(colours[0].z,colours[1].z,colours[2].z), (float3)(colours[3].z,colours[4].z,colours[5].z), (float3)(colours[6].z,colours[7].z,colours[8].z));

    write_imagef(dst_image,(int2)(x,y),col);
}


// buildOptions=
// RUN: %occ-cli %s --cl-options="-I%cwd -I%S " %cfg_path --cl-device=%cl_device 2>&1
