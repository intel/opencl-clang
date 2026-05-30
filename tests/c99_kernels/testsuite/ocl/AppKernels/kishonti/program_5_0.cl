#define SQR(x) ((x)*(x))

#define DESCRIPTOR_SIZE (DESC_RAD * 2 + 1)

typedef int2 feature_t;

typedef struct
{
    uchar4 data[SQR(DESCRIPTOR_SIZE)];
} descriptor_t;

inline uint norm_distance(descriptor_t a, descriptor_t b)
{
    uint result = 0;
    for (uint i = 0; i < SQR(DESCRIPTOR_SIZE); ++i)
	{
	  int r_err = (int)a.data[i].x - (int)b.data[i].x;
	  int g_err = (int)a.data[i].y - (int)b.data[i].y;
	  int b_err = (int)a.data[i].z - (int)b.data[i].z;
	  result += SQR(r_err) + SQR(g_err) + SQR(b_err);
	}
	return result;
}
__kernel void buildDescriptorDownSampling(__read_only image2d_t int_img,
    __global const feature_t * restrict features,
    const uint radius,
    const float sample_radius,
    __global descriptor_t *descriptors)
{
    const size_t feature_idx = get_global_id(0);
    const int desc_x = get_global_id(1);
    const int desc_y = get_global_id(2);

    const sampler_t srcSampler = CLK_NORMALIZED_COORDS_FALSE |
        CLK_ADDRESS_CLAMP_TO_EDGE |
        CLK_FILTER_NEAREST;

    float2 sample_coords = convert_float2(features[feature_idx].xy) - (float2)radius + (float2)(desc_x, desc_y) * (float)(sample_radius + 1);

	const uint4 A = read_imageui(int_img, srcSampler, sample_coords + (float2)(-sample_radius, -sample_radius));
	const uint4 B = read_imageui(int_img, srcSampler, sample_coords + (float2)( sample_radius, -sample_radius));
	const uint4 C = read_imageui(int_img, srcSampler, sample_coords + (float2)( sample_radius,  sample_radius));
	const uint4 D = read_imageui(int_img, srcSampler, sample_coords + (float2)(-sample_radius,  sample_radius));

    __local descriptor_t descriptor;
    descriptor.data[desc_y * DESCRIPTOR_SIZE + desc_x] = convert_uchar4(convert_float4(C - B + A - D) / SQR(2.0f * sample_radius + 1.0f));

    barrier(CLK_LOCAL_MEM_FENCE);

    if (desc_x == 0 && desc_y == 0)
    {
        descriptors[feature_idx] = descriptor;
    }
}
__kernel void integrate_y_f(
    __read_only image2d_t img,
    const uint img_height,
    __write_only image2d_t result)
{
    const size_t gId = get_global_id(0);

    const sampler_t srcSampler = CLK_NORMALIZED_COORDS_FALSE |
        CLK_ADDRESS_CLAMP_TO_EDGE |
        CLK_FILTER_NEAREST;

    uint4 sum = {0,0,0,0};
    for (size_t j = 0; j <img_height; ++j)
    {
       sum += convert_uint4(read_imagef(img, srcSampler, (int2)(gId, j)) * 255.f);
       write_imageui(result, (int2)(gId, j), sum);
    }
}

__kernel void integrate_y_ui(
    __read_only image2d_t img,
    const uint img_height,
    __write_only image2d_t result)
{
    const size_t gId = get_global_id(0);

    const sampler_t srcSampler = CLK_NORMALIZED_COORDS_FALSE |
        CLK_ADDRESS_CLAMP_TO_EDGE |
        CLK_FILTER_NEAREST;

    uint4 sum = {0,0,0,0};
    for (size_t j = 0; j <img_height; ++j)
    {
       sum += read_imageui(img, srcSampler, (int2)(gId, j));
       write_imageui(result, (int2)(gId, j), sum);
    }
}


__kernel void integrate_x(
    __read_only image2d_t img,
    const uint img_width,
    __write_only image2d_t result)
{
    const size_t gId = get_global_id(0);

    const sampler_t srcSampler = CLK_NORMALIZED_COORDS_FALSE |
        CLK_ADDRESS_CLAMP_TO_EDGE |
        CLK_FILTER_NEAREST;

    uint4 sum = {0,0,0,0};
    for (size_t i = 0; i <img_width; ++i)
    {
       sum += read_imageui(img, srcSampler, (int2)(i, gId));
       write_imageui(result, (int2)(i, gId), sum);
    }
}


// buildOptions=-cl-std=CL1.1 -D DESC_RAD=3
// RUN: %occ-cli %s --cl-options="-I%cwd -I%S -cl-std=CL1.1 -D DESC_RAD=3" %cfg_path --cl-device=%cl_device 2>&1
