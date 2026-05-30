typedef int2 feature_t;
#define SQR(x) ((x)*(x))

__kernel void getMatchedFeatures(
   __global const feature_t *restrict feture_list,
   __global uint *matches,
   __global feature_t *matched_feture_list,
   __global uint *clean_matches,
   __global uint *matched_feture_count)
{
    const size_t idx = get_global_id(0);

    if (matches[idx] == (uint)-1)
        return;

    uint new_idx = atomic_inc(matched_feture_count);
    matched_feture_list[new_idx] = feture_list[idx];
	clean_matches[new_idx] = matches[idx];
}

__kernel void squareDiff(
    __global feature_t *feature_list_from,
    __global feature_t *feature_list_to,
    __global uint *matches,
    const uint radius,
    __read_only image2d_t img1,
    __read_only image2d_t img2,
    __write_only image2d_t feature_buffer,
    const uint buffer_size_x,
    const uint RES_ERR_RAD
    )
{
    const size_t feature_idx = get_global_id(0);
    const feature_t feature_from = feature_list_from[feature_idx];
    const feature_t feature_to = feature_list_to[matches[feature_idx]];
    const size_t pixel_idx = get_global_id(1);
    const int feature_pad_size = (2 * radius + 1) + 2 * RES_ERR_RAD;

    int pixel_y = pixel_idx / feature_pad_size;
    int pixel_x = pixel_idx - pixel_y * feature_pad_size;
    pixel_y -= feature_pad_size / 2;
    pixel_x -= feature_pad_size / 2;

    const sampler_t srcSampler = CLK_NORMALIZED_COORDS_FALSE |
        CLK_ADDRESS_CLAMP_TO_EDGE |
        CLK_FILTER_NEAREST;

    int2 coords_from = (int2)(feature_from.x + pixel_x, feature_from.y + pixel_y);
    int2 coords_to = (int2)(feature_to.x + pixel_x, feature_to.y + pixel_y);

	float4 color = fabs(read_imagef(img1, srcSampler, coords_from) - read_imagef(img2, srcSampler, coords_to));
    color.w = 1.f;

    pixel_y += feature_pad_size / 2;
    pixel_x += feature_pad_size / 2;

    int dest_y = feature_idx / buffer_size_x;
    int dest_x = feature_idx - dest_y * buffer_size_x;
    dest_y = dest_y * feature_pad_size + pixel_y;
    dest_x = dest_x * feature_pad_size + pixel_x;

    write_imageui(feature_buffer, (int2)(dest_x, dest_y), convert_uint4(SQR(color * 255)));
}


__kernel void clearFlow(__global int2 *flow)
{
    flow[get_global_id(0)] = (int2)1000;
}
__kernel void clearVectorIndexes(__global uint *vector_indexes)
{
    vector_indexes[get_global_id(0)] = (uint)-1;
}

__kernel void clearResErrorField(__global float *best_res_err)
{
	best_res_err[get_global_id(0)] = 10000.f;
}

__kernel void flow(
    __read_only image2d_t integrated_features,
    const uint buffer_size_x,
    __global feature_t *feature_list_from,
    const uint radius,
    __global int *vector_indexes,
    __global float *best_res_err,
    const uint width,
    const uint height,
    const uint RES_ERR_RAD)
{
    const size_t feature_idx = get_global_id(0);
    const feature_t feature_from = feature_list_from[feature_idx];
    const size_t pixel_idx = get_global_id(1);
    const int feature_size = (2 * radius + 1);
    const int feature_pad_size = feature_size + 2 * RES_ERR_RAD;

    int pixel_y = pixel_idx / feature_size;
    int pixel_x = pixel_idx - pixel_y * feature_size;

    pixel_y += RES_ERR_RAD;
    pixel_x += RES_ERR_RAD;

    int dest_y = feature_idx / buffer_size_x;
    int dest_x = feature_idx - dest_y * buffer_size_x;
    dest_y = dest_y * feature_pad_size + pixel_y;
    dest_x = dest_x * feature_pad_size + pixel_x;

    const sampler_t srcSampler = CLK_NORMALIZED_COORDS_FALSE |
        CLK_ADDRESS_CLAMP_TO_EDGE |
        CLK_FILTER_NEAREST;

	uint4 A = read_imageui(integrated_features, srcSampler, (int2)(dest_x, dest_y) + (int2)(-RES_ERR_RAD, -RES_ERR_RAD));
	uint4 B = read_imageui(integrated_features, srcSampler, (int2)(dest_x, dest_y) + (int2)( RES_ERR_RAD, -RES_ERR_RAD));
	uint4 C = read_imageui(integrated_features, srcSampler, (int2)(dest_x, dest_y) + (int2)( RES_ERR_RAD,  RES_ERR_RAD));
	uint4 D = read_imageui(integrated_features, srcSampler, (int2)(dest_x, dest_y) + (int2)(-RES_ERR_RAD,  RES_ERR_RAD));

    uint4 res_err_rgb = C - B + A - D;

    pixel_y -= RES_ERR_RAD;
    pixel_x -= RES_ERR_RAD;
    pixel_y += feature_from.y - feature_size / 2;
    pixel_x += feature_from.x - feature_size / 2;

	if (pixel_y < 0 || pixel_y >= height || pixel_x < 0 || pixel_x >= width)
	    return;

    float res_err = (res_err_rgb.x + res_err_rgb.y + res_err_rgb.z) / (float)SQR(RES_ERR_RAD * 2 + 1);

	__global float *res_err_curr = &best_res_err[pixel_y * width + pixel_x];

	__global int *curr_feat = &vector_indexes[pixel_y * width + pixel_x];
    atomic_xchg(res_err_curr, *res_err_curr > res_err ? (atomic_xchg(curr_feat, feature_idx), res_err) : *res_err_curr);
}

__kernel void writeVectors(
    __global feature_t *feature_list_from,
    __global feature_t *feature_list_to,
    __global int *matches,
    __global int *vector_indexes,
	const int width_in,
	__global int2 *flow)
{
    const size_t x = get_global_id(0);
    const size_t y = get_global_id(1);
    const size_t width = get_global_size(0);
	const uint feature_idx = vector_indexes[y * width_in + x];
	if (feature_idx == (uint)-1)
	    return;

	flow[y * width + x] = feature_list_to[matches[feature_idx]].xy - feature_list_from[feature_idx].xy;
}

__kernel void addVectorsX(
	__global int2 *flow,
	__global int2 *flow_int_x,
	__global uint *flow_count,
	const uint width)
{
   const size_t y = get_global_id(0);

   int2 sum = 0;
   uint count = 0;

   for (uint x = 0; x < width; ++x)
   {
      int2 v = flow[y * width + x];
	  if (v.x != 1000)
	  {
         sum += v;
		 ++count;
	  }
	  flow_int_x[y * width + x] = sum;
	  flow_count[y * width + x] = count;
   }
}

__kernel void addVectorsY(
	__global int2 *flow_int,
	__global uint *flow_count,
	const int height)
{
   const size_t x = get_global_id(0);
   const size_t width = get_global_size(0);

   int2 sum = 0;
   uint count = 0;

   for (uint y = 0; y < height; ++y)
   {
      sum += flow_int[y * width + x];
	  flow_int[y * width + x] = sum;

	  count += flow_count[y * width + x];
	  flow_count[y * width + x] = count;
  }
}

__kernel void fillVectors(
        __global int2 *flow,
        __global int2 *flow_int,
		__global uint *flow_count)
{
    const int x = get_global_id(0);
    const int y = get_global_id(1);
    const int width = get_global_size(0);
    const int height = get_global_size(1);

	if (flow[y * width + x].x == 1000)
	{
	    int rad = 2;

		int2 A, B, C, D;
		int Ac, Bc, Cc, Dc;
		/**************************************
		 * Sum of vectors C - B + A - D
		 * Count of vectors Cc - Bc + Ac - Dc
		 **************************************/

		for (int rad = 2; rad < 128; rad *= 2)
		{
		    int y1 = max(y - rad, 0);
		    int x1 = max(x - rad, 0);
		    int y2 = min(y + rad, height - 1);
		    int x2 = min(x + rad, width - 1);

		    A = flow_int[y1 * width + x1];
		    Ac = flow_count[y1 * width + x1];

		    B = flow_int[y1 * width + x2];
		    Bc = flow_count[y1 * width + x2];

    		C = flow_int[y2 * width + x2];
	    	Cc = flow_count[y2 * width + x2];

		    D = flow_int[y2 * width + x1];
		    Dc = flow_count[y2 * width + x1];

			if ((Cc - Bc + Ac - Dc) != 0)
			    break;
		}

		flow[y * width + x] = (C - B + A - D) / (Cc - Bc + Ac - Dc);
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


// buildOptions=-cl-std=CL1.1
// RUN: %occ-cli %s --cl-options="-I%cwd -I%S -cl-std=CL1.1" %cfg_path --cl-device=%cl_device 2>&1
