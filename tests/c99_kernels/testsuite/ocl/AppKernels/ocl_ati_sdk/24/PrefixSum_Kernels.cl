/*
 * Work-efficient compute implementation of scan, one thread per 2 elements
 * O(log(n)) stepas and O(n) adds using shared memory
 * Uses a balanced tree algorithm. See Belloch, 1990 "Prefix Sums
 * and Their Applications"
 * @param output output data
 * @param input  input data
 * @param block  local memory used in the kernel
 * @param length lenght of the input data
 */

__kernel
void prefixSum(__global float * output,
               __global float * input,
               __local  float * block,
               const   uint    length)
{
	int tid = get_local_id(0);

	int offset = 1;

    /* Cache the computational window in shared memory */
	block[2*tid]     = input[2*tid];
	block[2*tid + 1] = input[2*tid + 1];

    /* build the sum in place up the tree */
	for(int d = length>>1; d > 0; d >>=1)
	{
		barrier(CLK_LOCAL_MEM_FENCE);

		if(tid<d)
		{
			int ai = offset*(2*tid + 1) - 1;
			int bi = offset*(2*tid + 2) - 1;

			block[bi] += block[ai];
		}
		offset *= 2;
	}

    /* scan back down the tree */

    /* clear the last element */
	if(tid == 0)
	{
		block[length - 1] = 0;
	}

    /* traverse down the tree building the scan in the place */
	for(int d = 1; d < length ; d *= 2)
	{
		offset >>=1;
		barrier(CLK_LOCAL_MEM_FENCE);

		if(tid < d)
		{
			int ai = offset*(2*tid + 1) - 1;
			int bi = offset*(2*tid + 2) - 1;

			float t = block[ai];
			block[ai] = block[bi];
			block[bi] += t;
		}
	}

	barrier(CLK_LOCAL_MEM_FENCE);

    /*write the results back to global memory */
	output[2*tid]     = block[2*tid];
	output[2*tid + 1] = block[2*tid + 1];
}




// buildOptions=
// RUN: %occ-cli %s --cl-options="-I%cwd -I%S " %cfg_path --cl-device=%cl_device 2>&1
