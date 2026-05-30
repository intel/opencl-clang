/*
 * For a description of the algorithm and the terms used, please see the
 * documentation for this sample.
 *
 * Quasi Random Sequence
 * Output size : n_dimensions * n_vectors
 * Input size: n_dimensions * n_directions
 * shared buffer size : n_directions
 * Number of blocks : n_dimensions
 * First, all the direction numbers for a dimension are cached into
 * shared memory. Then each thread writes a single vector value by
 * using all the direction numbers from the shared memory.
 *
 */

#define N_DIRECTIONS 32/4

__kernel void QuasiRandomSequence(__global  float4* output,
                                  __global  uint4* input,
					    		  __local uint4* shared)
{
	uint global_id = get_global_id(0);
	uint local_id = get_local_id(0);
	uint group_id = get_group_id(0);

	for(int i=0; i < N_DIRECTIONS; i++)
	{
		shared[i] = input[group_id * N_DIRECTIONS + i];
	}

	uint4 temp = 0;

	uint factor = local_id*4;

	uint4 vlid = (uint4)(factor, factor + 1, factor + 2, factor + 3);

	for(int k=0; k < N_DIRECTIONS; k++)
	{

		uint fK = k*4;
		uint4 vK = (uint4)(fK, fK + 1, fK + 2, fK + 3);

		uint4 two = (uint4)(2, 2, 2, 2);

		uint4 mask = (uint4)(pow((float)2, (float)vK.x), pow((float)2, (float)vK.y), pow((float)2, (float)vK.z), pow((float)2, (float)vK.w));

		temp.x ^= (((vlid.x & mask.x)>>vK.x) * shared[k].x) ^ 			    (((vlid.x & mask.y)>>vK.y) * shared[k].y) ^ 			    (((vlid.x & mask.z)>>vK.z) * shared[k].z) ^ 			    (((vlid.x & mask.w)>>vK.w) * shared[k].w);

		temp.y ^= (((vlid.y & mask.x)>>vK.x) * shared[k].x) ^ 			    (((vlid.y & mask.y)>>vK.y) * shared[k].y) ^ 			    (((vlid.y & mask.z)>>vK.z) * shared[k].z) ^ 			    (((vlid.y & mask.w)>>vK.w) * shared[k].w);

		temp.z ^= (((vlid.z & mask.x)>>vK.x) * shared[k].x) ^ 			    (((vlid.z & mask.y)>>vK.y) * shared[k].y) ^ 			    (((vlid.z & mask.z)>>vK.z) * shared[k].z) ^ 			    (((vlid.z & mask.w)>>vK.w) * shared[k].w);

		temp.w ^= (((vlid.w & mask.x)>>vK.x) * shared[k].x) ^ 			    (((vlid.w & mask.y)>>vK.y) * shared[k].y) ^ 			    (((vlid.w & mask.z)>>vK.z) * shared[k].z) ^ 			    (((vlid.w & mask.w)>>vK.w) * shared[k].w);

	}

		output[global_id] = convert_float4(temp) / (float)pow((float)2, (float)32);

}



// buildOptions=
// RUN: %occ-cli %s --cl-options="-I%cwd -I%S " %cfg_path --cl-device=%cl_device 2>&1
