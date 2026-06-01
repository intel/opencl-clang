#define SQR(x) ((x)*(x))
#define WG_SIZE_X 8
#define WG_SIZE_Y 6

typedef int2 feature_t;

__kernel void squareDifference(
    __read_only image2d_t img_in,
    __write_only image2d_t img_out,
    const int2 displacement
    )
{
    const int2 xy = (int2)(get_global_id(0), get_global_id(1));

    const sampler_t srcSampler = CLK_NORMALIZED_COORDS_FALSE |
        CLK_ADDRESS_CLAMP_TO_EDGE |
        CLK_FILTER_NEAREST;

    const float4 color = fabs(read_imagef(img_in, srcSampler, xy) - read_imagef(img_in, srcSampler, xy + displacement));

	write_imageui(img_out, xy, convert_uint4(SQR(color * 255.0f + 0.5f)));
}

__kernel void initStrength(__global float *strength)
{
    strength[get_global_id(0)] = (uint)-1;
}

__kernel void SSD(
    __read_only image2d_t sd_int_img,
    __global float *strength,
    const int patch_radius
    )
{
    const int2 xy = (int2)(get_global_id(0), get_global_id(1));
    const size_t width = get_global_size(0);

    const sampler_t srcSampler = CLK_NORMALIZED_COORDS_FALSE |
        CLK_ADDRESS_CLAMP_TO_EDGE |
        CLK_FILTER_NEAREST;

    const uint4 A = read_imageui(sd_int_img, srcSampler, xy + (int2)(-patch_radius, -patch_radius));
    const uint4 B = read_imageui(sd_int_img, srcSampler, xy + (int2)( patch_radius, -patch_radius));
    const uint4 C = read_imageui(sd_int_img, srcSampler, xy + (int2)( patch_radius,  patch_radius));
    const uint4 D = read_imageui(sd_int_img, srcSampler, xy + (int2)(-patch_radius,  patch_radius));

    uint4 ssd_rgb = C - B + A - D;
    float ssd = (ssd_rgb.x + ssd_rgb.y + ssd_rgb.z) / convert_float(SQR(2 * patch_radius + 1) * 3);

    if (ssd < strength[xy.y * width + xy.x])
    {
        strength[xy.y * width + xy.x] = ssd;
    }
}

__kernel void  initLocMaxMap(__global uchar *loc_max_map)
{
    loc_max_map[get_global_id(0)] = 0;
}


/**
* \brief Non maximum suppression on strengthian values
* \param strength0 strengthian input array
* \param strength1 strengthian input array
* \param strength2 strengthian input array
* \param loc_max_map (output, array of \f$ \left\lbrace 0, 1 \right\lbrace \f$) map of local maxima (1 indicates maximum)
* \todo Also check the border of the WG_SIZE x WG_SIZE regions!
*/
__kernel void nonMaximumSuppression(
    __global const float * restrict strength,
    const uint patch_radius,
	const uint width_orig,
	const uint height_orig,
    __global uchar *loc_max_map)
{
    const int x = get_global_id(0);
    const int y = get_global_id(1);
    const int width = get_global_size(0);

	const float step_ = patch_radius + 0.5f;

    if (x < patch_radius || y < patch_radius || x >= width_orig - patch_radius || y >= height_orig - patch_radius)
        return;

	const float strength0 = strength[y * width + x];

	//local max - pixel
    for (int i = x - 1; i <= x + 1; ++i)
    {
        for (int j = y - 1; j <= y + 1; ++j)
            if (i != x || j != y)
            {
                if (strength[j * width + i] >= strength0)
                    return;
            }
    }

    //local max - patch
	for (float i = x - step_ ; i <= x + step_ ; i += step_)
    {
        for (float j = y - step_; j <= y + step_ ; j += step_)
		{
		    const float strength1 = strength[((size_t)j) * width + (size_t)i];
            if (strength1 > strength0)
                return;
		}
    }

    loc_max_map[y * width + x] = 1;
}


/**
* \brief Count interest points int every tile.
* \param loc_max_map output of nonMaximumSuppression
* \param feature_count (output) number of interest points for every tile
*/
__kernel __attribute__((reqd_work_group_size(TILE_WIDTH, 1, 1)))
    void countFeatures(
    __global const uchar * restrict loc_max_map,
    __global uint *feature_count
    )
{
    //global coordinates
    const size_t x_g = get_global_id(0);
    const size_t y_g = get_global_id(1) * TILE_HEIGHT;

    //width of the image
    const size_t width = get_global_size(0);

    //initialize count
    __local uint count;
    if (get_local_id(0) == 0)
        count = 0;

    barrier(CLK_LOCAL_MEM_FENCE);

    //loop for counting
    for (uint i = 0; i < TILE_HEIGHT; ++i)
    {
        if (loc_max_map[(y_g + i) * width + x_g] != 0)
        {
            atomic_inc(&count);
        }
    }

    barrier(CLK_LOCAL_MEM_FENCE);

    //set output
    feature_count[get_group_id(1) * get_num_groups(0) + get_group_id(0)] = count;
}

/**
* \brief Create a prefix sum for the output of countfeatures
*
* http://en.wikipedia.org/wiki/Prefix_sum
*
* \param feature_count output of countfeatures
* \param feature_count_sum (output) prefix sum
* \param count nuber of all interest points
* \todo Replace it with the one from principals
*/
__kernel __attribute__((reqd_work_group_size(NUM_TILE_X * NUM_TILE_Y, 1, 1)))
    void prefixsum(
    __global const uint * restrict feature_count,
    __global uint *feature_count_sum,
    __global uint *count
    )
{
    int lId = get_local_id(0); //equals global id!

    __local uint sum_local[NUM_TILE_X * NUM_TILE_Y];
    sum_local[lId] = feature_count[lId];

    barrier(CLK_LOCAL_MEM_FENCE);

    /**********************************************************
    * Paralell prefixsum part 1
    **********************************************************/
    int p = 1;
    for (; 1 << (p - 1) < NUM_TILE_X * NUM_TILE_Y; p += 1)
    {
        // lId % 2^p == 1
        ///Cuda C Best Practises Guide 5.1.1
        if (((lId + 1)  >> p) << p == lId + 1)
        {
            if (lId - (1 << (p - 1)) >= 0)
                sum_local[lId] += sum_local[lId - (1 << (p - 1))];
        }
        barrier(CLK_LOCAL_MEM_FENCE);
    }

    /**********************************************************
    * Paralell prefixsum part 2
    **********************************************************/
    for (; p > 0; p -= 1)
    {
        if (((lId + 1)  >> p) << p == lId + 1)
        {
            if (lId + (1 << (p - 1)) < NUM_TILE_X * NUM_TILE_Y)
                sum_local[lId + (1 << (p - 1))] += sum_local[lId];
        }
        barrier(CLK_LOCAL_MEM_FENCE);
    }

    feature_count_sum[lId] = sum_local[lId];
    if (lId == NUM_TILE_X * NUM_TILE_Y - 1)
    {
        *count = sum_local[lId];
    }
}

/**
* \brief create an array of interest points
* \param loc_max_map output of nonMaximumSuppression
* \param feature_count output of countfeatures
* \param feature_prefix_sum output of prefixsum
* \param point_list array of interest points
*/
__kernel __attribute__((reqd_work_group_size(TILE_WIDTH, 1, 1)))
    void getFeatures(
    __global const uchar * restrict loc_max_map,
    __global const uint * restrict feature_count,
    __global const uint * restrict feature_prefix_sum,
    __global feature_t *point_list)
{
    //global coordinates
    const size_t x_g = get_global_id(0);
    const size_t y_g = get_global_id(1) * TILE_HEIGHT;

    //width of the image
    const size_t width = get_global_size(0);

    //determine where the chunk of this tile starts in the array
    const size_t group_idx = get_group_id(1) * get_num_groups(0) + get_group_id(0);
    const size_t group_start_idx = feature_prefix_sum[group_idx] - feature_count[group_idx];

    //initialize local index
    __local uint idx;
    if (get_local_id(0) == 0)
        idx = 0;

    barrier(CLK_LOCAL_MEM_FENCE);

    //collect interest points
    for (uint i = 0; i < TILE_HEIGHT; ++i)
    {
	    uchar v = loc_max_map[(y_g + i) * width + x_g];
        if (v != 0)
        {
            int my_idx = group_start_idx + atomic_inc(&idx);
            point_list[my_idx] = (feature_t)(x_g, y_g + i);
        }
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


// buildOptions=-cl-std=CL1.1 -D TILE_WIDTH=40 -D TILE_HEIGHT=30 -D NUM_TILE_X=15 -D NUM_TILE_Y=13
// RUN: %occ-cli %s --cl-options="-I%cwd -I%S -cl-std=CL1.1 -D TILE_WIDTH=40 -D TILE_HEIGHT=30 -D NUM_TILE_X=15 -D NUM_TILE_Y=13" %cfg_path --cl-device=%cl_device 2>&1
