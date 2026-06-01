/*
 * Copies a block to the local memory
 * and copies back the transpose from local memory to output
 * @param output output matrix
 * @param input  input matrix
 * @param block  local memory of size blockSize x blockSize
 * @param width  width of the input matrix
 * @param height height of the input matrix
 * @param blockSize size of the block
 */

__kernel
void matrixTranspose(__global float * output,
                     __global float * input,
                     __local  float * block,
                     const    uint    width,
                     const    uint    height,
                     const    uint blockSize
                       )
{
	uint globalIdx = get_global_id(0);
	uint globalIdy = get_global_id(1);

	uint localIdx = get_local_id(0);
	uint localIdy = get_local_id(1);

    /* copy from input to local memory */
	block[localIdy*blockSize + localIdx] = input[globalIdy*width + globalIdx];

    /* wait until the whole block is filled */
	barrier(CLK_LOCAL_MEM_FENCE);

	uint groupIdx = get_group_id(0);
	uint groupIdy = get_group_id(1);

    /* calculate the corresponding target location for transpose  by inverting x and y values*/
	uint targetGlobalIdx = groupIdy*blockSize + localIdy;
	uint targetGlobalIdy = groupIdx*blockSize + localIdx;

    /* calculate the corresponding raster indices of source and target */
	uint targetIndex  = targetGlobalIdy*height     + targetGlobalIdx;
	uint sourceIndex  = localIdy       * blockSize + localIdx;

	output[targetIndex] = block[sourceIndex];
}


// buildOptions=
// RUN: %occ-cli %s --cl-options="-I%cwd -I%S " %cfg_path --cl-device=%cl_device 2>&1
