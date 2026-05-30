/**
* OpenCL image histogram equalization implementation.
*
* Copyright 2011 by Rightware. All rights reserved.
*/


#pragma OPENCL EXTENSION cl_khr_local_int32_base_atomics: enable
#pragma OPENCL EXTENSION cl_khr_global_int32_base_atomics: enable


#define BIN_COUNT 256
#define CHANNEL_COUNT 4


/**
* Calculates a histogram from RGBA image
* Workgroups use atomic operations to increment a local subhistogram which is merged at the end into global histograms.
* This function requires the device to support atomic functions in addition to atleast 4kB of local memory, cannot be used with Embedded profile (1kB local memory, no atomic operations)
*/
__kernel void generateHistogram(__read_only image2d_t src_image, __global uint *histogram)
{
    const sampler_t sampler=CLK_NORMALIZED_COORDS_FALSE | CLK_ADDRESS_CLAMP_TO_EDGE | CLK_FILTER_NEAREST;
    __local uint l_hist[BIN_COUNT*CHANNEL_COUNT];
    uint4 col;

    for(uint i = get_local_id(0) + get_local_id(1) * get_local_size(0); i < BIN_COUNT*CHANNEL_COUNT; i += get_local_size(0) * get_local_size(1) )
    {
        l_hist[i] = 0;
    }
    barrier(CLK_LOCAL_MEM_FENCE);

    col = convert_uint4(read_imagef(src_image,sampler,(int2)(get_global_id(0),get_global_id(1)))*255.0f);
    atom_inc(l_hist+col.x);
    atom_inc(l_hist+col.y+BIN_COUNT);
    atom_inc(l_hist+col.z+BIN_COUNT*2);
    atom_inc(l_hist+col.w+BIN_COUNT*3);
    barrier(CLK_LOCAL_MEM_FENCE);

    for(uint i = get_local_id(0) + get_local_id(1) * get_local_size(0); i < BIN_COUNT*CHANNEL_COUNT; i += get_local_size(0) * get_local_size(1) )
    {
        atom_add(histogram + i,l_hist[i]);
    }
}

__kernel void applyHistogram(__write_only image2d_t dst_image, __read_only image2d_t src_image, __global uint *cumulative_histogram)
{
        const sampler_t sampler=CLK_NORMALIZED_COORDS_FALSE | CLK_ADDRESS_CLAMP_TO_EDGE | CLK_FILTER_NEAREST;
        /* New val = cumulative_histogram[colour]*255/(W*H)*/
        uint4 col;
        uint pixel_count = get_image_height(src_image)*get_image_width(src_image);
        col = convert_uint4(read_imagef(src_image,sampler,(int2)(get_global_id(0),get_global_id(1)))*255.0f);

        col.x = (cumulative_histogram[col.x            ]*(BIN_COUNT-1))/pixel_count;
        col.y = (cumulative_histogram[col.y+BIN_COUNT  ]*(BIN_COUNT-1))/pixel_count;
        col.z = (cumulative_histogram[col.z+BIN_COUNT*2]*(BIN_COUNT-1))/pixel_count;
        col.w = (cumulative_histogram[col.w+BIN_COUNT*3]*(BIN_COUNT-1))/pixel_count;
        write_imagef(dst_image,(int2)(get_global_id(0),get_global_id(1)),convert_float4(col)/255.0f);
}

/** Generates cumulative distribution function from the histogram. */
__kernel void generateCumulativeDistribution(__global uint *histogram)
{
    uint cumsum = 0;
    for(uint i = 0; i < BIN_COUNT;i++)
    {
        cumsum += histogram[i+get_global_id(0)*BIN_COUNT];
        histogram[i+get_global_id(0)*BIN_COUNT] = cumsum;
    }
}

/** Zeroes the histogram. */
__kernel void zeroDistribution(__global uint *histogram)
{
    for(uint i = 0; i < BIN_COUNT;i++)
    {
        histogram[i+get_global_id(0)*BIN_COUNT] = 0;
    }
}


// buildOptions=
// RUN: %occ-cli %s --cl-options="-I%cwd -I%S " %cfg_path --cl-device=%cl_device 2>&1
