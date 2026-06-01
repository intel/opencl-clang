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
/**
* \file bfmatch.cl
* \author Gabor Angyal
* \brief GPU matching CL functions
*/

/**
* \brief Returns the next number that is divisable by 16.
* \param i input
* \return \f$  \lceil \frac{i}{16} \rceil * 16 \f$
*/
inline uint pad16(uint i)
{
    if ((i >> 4) << 4 == i)
        return i;
    else
        return ((i >> 4) << 4) + 16;
}

__kernel void initMatchMap(__global uchar *match_map)
{
    match_map[get_global_id(0)] = 0;
}

__kernel void matchMap(
    __global const uint * restrict feature_count1,
    __global const uint * restrict feature_prefix_sum1,
    const uint feature_num1,
    __global const uint * restrict feature_count2,
    __global const uint * restrict feature_prefix_sum2,
    const uint feature_num2,
    __global uchar *match_map
    )
{
    const int tile_x = get_global_id(0);
    const int tile_y = get_global_id(1);
    const int numtile_x = get_global_size(0);
    const int numtile_y = get_global_size(1);

    const int idx = numtile_x * tile_y + tile_x;

    int idx_start[3], idx_end[3];

    for (int i = 0; i < 3; ++i)
    {
        idx_start[i] = numtile_x * clamp(tile_y + i - 1, 0, numtile_y - 1) + (tile_x == 0 ? 0 : tile_x - 1);
        idx_end[i]   = numtile_x * clamp(tile_y + i - 1, 0, numtile_y - 1) + (tile_x == numtile_x - 1 ? tile_x : tile_x + 1);
    }


    int start_r16_1 = feature_prefix_sum1[idx] - feature_count1[idx];
    start_r16_1 /= 16;

    int end_r16_1 = feature_prefix_sum1[idx];
    end_r16_1 /= 16;

    int start_r16_j[3], end_r16_j[3];


    for (int i = 0; i < 3; ++i)
    {
        start_r16_j[i] = feature_prefix_sum2[idx_start[i]] - feature_count2[idx_start[i]];
        start_r16_j[i] /= 16;

        end_r16_j[i] = feature_prefix_sum2[idx_end[i]];
        end_r16_j[i] /= 16;
    }

    const uint r16_num_i = pad16(feature_num1) / 16;
    const uint r16_num_j = pad16(feature_num2) / 16;

    for (uint k = 0; k < 3; ++k)
        for(uint j = start_r16_j[k]; j <= end_r16_j[k]; ++j)
            for(uint i = start_r16_1; i <= end_r16_1; ++i)
			    if ( i < r16_num_i && j < r16_num_j)
                    match_map[j * r16_num_i + i] = 255;
}

/**
* \brief Generates the index used in minvalues and minplaces arrays.
* \param i interest point index on image I.
* \param group_j group index of the interest point from image J.
* \param point_num_j number of interest points on image J
* \return The index.
*/
inline uint getIdx(uint i, uint group_j, uint point_num_j)
{
    return i * (pad16(point_num_j) / 16) + group_j;
}

/**
* \brief Match interest points between image I and J by 16 x 16 blocks.
* \param features_i list of interest points on image I
* \param feature_num_i number of interest points on image I
* \param features_j list of interest points on image J
* \param feature_num_j number of interest points on image J
* \param descriptors_i array of descriptors of interest points on image I
* \param descriptors_j array of descriptors of interest points on image J
* \param minplaces array of minimum places
* \param minvalues array of minimum values
*/
__kernel __attribute__((reqd_work_group_size(16, 16, 1)))
    void match(
    __global const feature_t * restrict features_i,
    const uint feature_num_i,
    __global const feature_t * restrict features_j,
    const uint feature_num_j,
    __global const descriptor_t * restrict descriptors_i,
    __global const descriptor_t * restrict descriptors_j,
    __global uint *minplaces,
    __global uint *minvalues,
    __global const uchar *match_map
    )
{
    const size_t l_id_i = get_local_id(0);
    const size_t l_id_j = get_local_id(1);
    const size_t g_id_i = get_global_id(0);
    const size_t g_id_j = get_global_id(1);
    const size_t idx =  getIdx(g_id_i, get_group_id(1), feature_num_j);

    if (!match_map[g_id_j / 16 * pad16(feature_num_i) / 16 + g_id_i / 16])
    {
        minvalues[idx] = (uint)-1;
        minplaces[idx] = (uint)-1;
        return;
    }

    /*********************************************************
    * Load the descriptors assigned for the current workgroup
    * into local memory.
    *********************************************************/
    __local descriptor_t descriptors_i_local[16];
    __local descriptor_t descriptors_j_local[16];

    if (l_id_i == 0 && g_id_j < feature_num_j)
    {
        descriptors_j_local[l_id_j] = descriptors_j[g_id_j];
    }

    if (l_id_j == 0 && g_id_i < feature_num_i)
    {
        descriptors_i_local[l_id_i] = descriptors_i[g_id_i];
    }

    barrier(CLK_LOCAL_MEM_FENCE);


    /***********************************************************
    * Calculate the distance of the descriptors for each pair.
    * Use an extremal value ((uint)-1) for work items, which do
    * not have descriptors assigned or are too far from each other.
    ***********************************************************/
    __local uint diff[16][16];
	const feature_t feature_i = features_i[g_id_i];
	const feature_t feature_j = features_j[g_id_j];
    if (g_id_i >= feature_num_i || g_id_j >= feature_num_j
	|| SQR(feature_i.x - feature_j.x) + SQR(feature_i.y - feature_j.y) > SQR(MAX_VECTOR_LENGTH))
        diff[l_id_i][l_id_j] = (uint)-1;
    else
        diff[l_id_i][l_id_j] = norm_distance(descriptors_i_local[l_id_i], descriptors_j_local[l_id_j]);

    barrier(CLK_LOCAL_MEM_FENCE);


    /**************************************************************
    * Find the closest descriptor for every descriptor assigned to
    * this workgroup from image I. Use reduction to find minimum.
    **************************************************************/
    __local uchar minplaces_l[16][16];
    minplaces_l[l_id_i][l_id_j] = l_id_j;

    for (int p = 1; p <= 4; ++p)
    {
        if (l_id_j % (1 << p) == 0)
        {
#define other (l_id_j + (1 << (p - 1)))

            if (diff[l_id_i][l_id_j] > diff[l_id_i][other])
            {
                minplaces_l[l_id_i][l_id_j] = minplaces_l[l_id_i][other];
                diff[l_id_i][l_id_j] = diff[l_id_i][other];
            }

#undef other
        }

        barrier(CLK_LOCAL_MEM_FENCE);
    }

    /***********************************************************
    * Write results to global memory.
    ***********************************************************/
    if (l_id_j == 0)
    {
	    if (diff[l_id_i][0] <= MAXIMUM_MATCH_DISTANT)
		{
            minvalues[idx] = diff[l_id_i][0];
            minplaces[idx] = g_id_j + minplaces_l[l_id_i][0];
		} else
		{
            minvalues[idx] = (uint)-1;
            minplaces[idx] = (uint)-1;
		}
    }
}

/**
* \brief arrange partial results with reduction
* \param minplaces_in Minimum places from matching or from previous run of reduction.
* \param minvalues_in Minimum values from matching or from previous run of reduction.
* \param input_size Number of minimum places and values
* \param minplaces_out Reducted minimum places.
* \param minvalues_out Reducted minimum values.
*/
__kernel __attribute__((reqd_work_group_size(1, LOCAL_SIZE / 2, 1)))
    void reduction(
    __global const uint * restrict minplaces_in,
    __global const uint * restrict minvalues_in,
    const uint input_size,
    __global uint *minplaces_out,
    __global uint *minvalues_out)
{
    const uint g_i_idx = get_global_id(0);
    const uint g_j_idx = get_global_id(1);
    const uint gr_j_idx = get_group_id(1);
    const uint gr_j_num = get_num_groups(1);
    const uint l_j_idx = get_local_id(1);

    /*******************************************************************
    * Read a chunk of minimum places and values into local memory
    ********************************************************************/

    __local uint minplaces_local[LOCAL_SIZE];
    __local float minvalues_local[LOCAL_SIZE];

    const size_t start_idx = g_i_idx * input_size;

    if (g_j_idx < input_size / 2)
    {
        minplaces_local[l_j_idx * 2] = minplaces_in[start_idx + g_j_idx * 2];
        minplaces_local[l_j_idx * 2 + 1] = minplaces_in[start_idx + g_j_idx * 2 + 1];
        minvalues_local[l_j_idx * 2] = minvalues_in[start_idx + g_j_idx * 2];
        minvalues_local[l_j_idx * 2 + 1] = minvalues_in[start_idx + g_j_idx * 2 + 1];
    } else
    {
        minplaces_local[l_j_idx * 2] = (uint)-1;
        minplaces_local[l_j_idx * 2 + 1] = (uint)-1;
        minvalues_local[l_j_idx * 2] = (uint)-1;
        minvalues_local[l_j_idx * 2 + 1] = (uint)-1;
    }

    barrier(CLK_LOCAL_MEM_FENCE);

    /*******************************************************************
    * Run reduction
    ********************************************************************/

    for (uint N = LOCAL_SIZE / 2; 0 < N; N /= 2)
    {
        if (l_j_idx < N)
        {
            if (minvalues_local[l_j_idx] > minvalues_local[l_j_idx + N])
            {
                minvalues_local[l_j_idx] = minvalues_local[l_j_idx + N];
                minplaces_local[l_j_idx] = minplaces_local[l_j_idx + N];
            }
        }
        barrier(CLK_LOCAL_MEM_FENCE);
    }

    /*******************************************************************
    * Write result into global memory
    ********************************************************************/

    if (l_j_idx == 0)
    {
        minplaces_out[g_i_idx * gr_j_num + gr_j_idx] = minplaces_local[0];
        minvalues_out[g_i_idx * gr_j_num + gr_j_idx] = minvalues_local[0];
    }
}

__kernel void backAndForthCheck(
    __global const feature_t * restrict features_i,
    __global uint *matches_forth,
    __global const feature_t * restrict features_j,
    __global uint * restrict matches_back)
{
    const size_t idx = get_global_id(0);
	const size_t idx_to = matches_forth[idx];
	if (idx_to == (uint)-1)
	    return;

	if (matches_back[idx_to] != idx)
	{
	    matches_forth[idx] = (uint)-1;
		return;
	}

	feature_t feature_i = features_i[idx];
	feature_t feature_j = features_j[idx_to];

	if (SQR(feature_i.x - feature_j.x) + SQR(feature_i.y - feature_j.y) > SQR(MAX_VECTOR_LENGTH))
	{
	    matches_forth[idx] = (uint)-1;
		return;
	}
}


__kernel void initVectorField(
    __write_only image2d_t vector_field)
{
	write_imagei(vector_field, (int2)(get_global_id(0), get_global_id(1)), (int4)(0));
}

__kernel void registerToVectorField(
    __global const feature_t * restrict features_1,
    __global const uint * restrict matches,
    __global const feature_t * restrict features_2,
    __write_only image2d_t vector_field)
{
    const size_t feature_idx = get_global_id(0);
	int idx_to = matches[feature_idx];
	if (idx_to == (uint)-1)
		return;
	const feature_t feature = features_1[feature_idx];
	int4 v;
	//possible overflow
    v.xy = features_2[idx_to].xy - feature.xy;
	v.z = 1;
    write_imagei(vector_field, feature.xy, v);
}

__kernel void areaCheckImg(
    __global const feature_t * restrict features_1,
    __global uint *matches,
    __global const feature_t * restrict features_2,
    __read_only image2d_t vector_field,
	const uint width,
	const uint height)
{
    const sampler_t srcSampler = CLK_NORMALIZED_COORDS_FALSE |
        CLK_ADDRESS_CLAMP_TO_EDGE |
        CLK_FILTER_NEAREST;

	const size_t feature_idx = get_global_id(0);
	int idx_to = matches[feature_idx];
	if (idx_to == (uint)-1)
		return;
	const feature_t feature = features_1[feature_idx];


	int2 v0 = features_2[idx_to].xy - feature.xy;

	uint count = 0;
	uint count_all = 0;
	for (int i = feature.x - 20; i <= feature.x + 20; ++i)
        for (int j = feature.y - 15; j <= feature.y + 15; ++j)
		    if (i >= 0 && i < width && j >= 0 && j < height && i != feature.x && j != feature.y)
	        {
			    int4 v = read_imagei(vector_field, srcSampler, (int2)(i, j));
				if (v.z == 0)
				  continue;
                ++count_all;
                if (max(abs(v.x - v0.x), abs(v.y - v0.y)) < 5)
                    ++count;
	        }

    if (count < 3)
	    matches[feature_idx] = (uint)-1;
}


// buildOptions=-cl-std=CL1.1 -D NUM_TILE_X=15 -D NUM_TILE_Y=13 -D TILE_WIDTH=40 -D LOCAL_SIZE=128 -D MAXIMUM_MATCH_DISTANT=32768 -D DESC_RAD=3 -D MAX_VECTOR_LENGTH=20
// RUN: %occ-cli %s --cl-options="-I%cwd -I%S -cl-std=CL1.1 -D NUM_TILE_X=15 -D NUM_TILE_Y=13 -D TILE_WIDTH=40 -D LOCAL_SIZE=128 -D MAXIMUM_MATCH_DISTANT=32768 -D DESC_RAD=3 -D MAX_VECTOR_LENGTH=20" %cfg_path --cl-device=%cl_device 2>&1
