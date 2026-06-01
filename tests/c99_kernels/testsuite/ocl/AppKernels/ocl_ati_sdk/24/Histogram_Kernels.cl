/*
 * For a description of the algorithm and the terms used, please see the
 * documentation for this sample.
 *
 * On invocation of kernel blackScholes, each work thread calculates
 * thread-histogram bin and finally all thread-histograms merged into
 * block-histogram bin. Outside the kernel, All block-histograms merged
 * into final histogram
 */

#define LINEAR_MEM_ACCESS
#pragma OPENCL EXTENSION cl_khr_byte_addressable_store : enable

#define BIN_SIZE 256

/**
 * @brief   Calculates block-histogram bin whose bin size is 256
 * @param   data  input data pointer
 * @param   sharedArray shared array for thread-histogram bins
 * @param   binResult block-histogram array
 */
__kernel
void histogram256(__global const uint* data,
                  __local uchar* sharedArray,
                  __global uint* binResult)
{
    size_t localId = get_local_id(0);
    size_t globalId = get_global_id(0);
    size_t groupId = get_group_id(0);
    size_t groupSize = get_local_size(0);

    /* initialize shared array to zero */
    for(int i = 0; i < BIN_SIZE; ++i)
        sharedArray[localId * BIN_SIZE + i] = 0;

    barrier(CLK_LOCAL_MEM_FENCE);

    /* calculate thread-histograms */
    for(int i = 0; i < BIN_SIZE; ++i)
    {
#ifdef LINEAR_MEM_ACCESS
        uint value = data[groupId * groupSize * BIN_SIZE + i * groupSize + localId];
#else
        uint value = data[globalId * BIN_SIZE + i];
#endif LINEAR_MEM_ACCESS
        sharedArray[localId * BIN_SIZE + value]++;
    }

    barrier(CLK_LOCAL_MEM_FENCE);

    /* merge all thread-histograms into block-histogram */
    for(int i = 0; i < BIN_SIZE / groupSize; ++i)
    {
        uint binCount = 0;
        for(int j = 0; j < groupSize; ++j)
            binCount += sharedArray[j * BIN_SIZE + i * groupSize + localId];

        binResult[groupId * BIN_SIZE + i * groupSize + localId] = binCount;
    }
}




// buildOptions=
// RUN: %occ-cli %s --cl-options="-I%cwd -I%S " %cfg_path --cl-device=%cl_device 2>&1
