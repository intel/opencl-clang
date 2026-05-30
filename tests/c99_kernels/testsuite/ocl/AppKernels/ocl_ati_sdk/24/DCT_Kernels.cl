/**
 * Given the blockindices and localIndicies this
 * function calculate the global index
 * @param blockIdx index of the block horizontally
 * @param blockIdy index of the block vertically
 * @param localidx index of the element relative to the block horizontally
 * @param localIdy index of the element relative to the block vertically
 * @param blockWidth width of each blcok which is 8
 * @param globalWidth Width of the input matrix
 */
uint
getIdx(uint blockIdx, uint blockIdy, uint localIdx, uint localIdy, uint blockWidth, uint globalWidth)
{
    uint globalIdx = blockIdx * blockWidth + localIdx;
    uint globalIdy = blockIdy * blockWidth + localIdy;

    return (globalIdy * globalWidth  + globalIdx);
}
/**
 * Perform Discrete Cosine Transform for block of size 8x8
 * in the input matrix
 * @param output output of the DCT8x8 transform
 * @param input  input array
 * @param dct8x8 8x8 consine function base used to calculate DCT8x8
 * @param inter  local memory which stores intermediate result
 * @param width  width of the input matrix
 * @param blockWidth width of each block, 8 here
 * @param inverse  flag to perform inverse DCT
 */

__kernel
void DCT(__global float * output,
         __global float * input,
         __global float * dct8x8,
         __local  float * inter,
         const    uint    width,
         const    uint  blockWidth,
         const    uint    inverse)

{
    /* get global indices of the element */
    uint globalIdx = get_global_id(0);
    uint globalIdy = get_global_id(1);

    /* get indices of the block to which the element belongs to */
    uint groupIdx  = get_group_id(0);
    uint groupIdy  = get_group_id(1);

    /* get indices relative to the block */
    uint i  = get_local_id(0);
    uint j  = get_local_id(1);

    uint idx = globalIdy * width + globalIdx;

    /* initialise the accumulator */
    float acc = 0.0f;

    /* AT * X  */
    for(uint k=0; k < blockWidth; k++)
    {
        uint index1 = (inverse)? i*blockWidth + k : k * blockWidth + i;
        uint index2 = getIdx(groupIdx, groupIdy, j, k, blockWidth, width);

        acc += dct8x8[index1] * input[index2];
    }
    inter[j*blockWidth + i] = acc;

    /*
     * Make sure all the values of inter that belong to a block
     * are calculated before proceeding further
     */
    barrier(CLK_LOCAL_MEM_FENCE);

    /* again initalising the accumulator */
    acc = 0.0f;

    /* (AT * X) * A */
    for(uint k=0; k < blockWidth; k++)
    {
        uint index1 = i* blockWidth + k;
        uint index2 = (inverse)? j*blockWidth + k : k* blockWidth + j;

        acc += inter[index1] * dct8x8[index2];
    }
    output[idx] = acc;
}


// buildOptions=
// RUN: %occ-cli %s --cl-options="-I%cwd -I%S " %cfg_path --cl-device=%cl_device 2>&1
