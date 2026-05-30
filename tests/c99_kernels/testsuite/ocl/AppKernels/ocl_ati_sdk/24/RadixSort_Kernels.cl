/*
 * For a description of the algorithm and the terms used, please see the
 * documentation for this sample.
 */

#pragma OPENCL EXTENSION cl_khr_byte_addressable_store : enable

#define RADIX 8
#define RADICES (1 << RADIX)

/**
 * @brief   Calculates block-histogram bin whose bin size is 256
 * @param   unsortedData    array of unsorted elements
 * @param   buckets         histogram buckets
 * @param   shiftCount      shift count
 * @param   sharedArray     shared array for thread-histogram bins
  */
__kernel
void histogram(__global const uint* unsortedData,
               __global uint* buckets,
               uint shiftCount,
               __local ushort* sharedArray)
{
    size_t localId = get_local_id(0);
    size_t globalId = get_global_id(0);
    size_t groupId = get_group_id(0);
    size_t groupSize = get_local_size(0);

    /* Initialize shared array to zero */
    for(int i = 0; i < RADICES; ++i)
        sharedArray[localId * RADICES + i] = 0;

    barrier(CLK_LOCAL_MEM_FENCE);

    /* Calculate thread-histograms */
    for(int i = 0; i < RADICES; ++i)
    {
        uint value = unsortedData[globalId * RADICES + i];
        value = (value >> shiftCount) & 0xFFU;
        sharedArray[localId * RADICES + value]++;
    }

    barrier(CLK_LOCAL_MEM_FENCE);

    /* Copy calculated histogram bin to global memory */
    for(int i = 0; i < RADICES; ++i)
    {
        uint bucketPos = groupId * RADICES * groupSize + localId * RADICES + i;
        buckets[bucketPos] = sharedArray[localId * RADICES + i];
    }
}

/**
 * @brief   Permutes the element to appropriate places based on
 *          prescaned buckets values
 * @param   unsortedData        array of unsorted elments
 * @param   scanedBuckets       prescaned buckets for permuations
 * @param   shiftCount          shift count
 * @param   sharedBuckets       shared array for scaned buckets
 * @param   sortedData          array for sorted elements
 */
__kernel
void permute(__global const uint* unsortedData,
             __global const uint* scanedBuckets,
             uint shiftCount,
             __local ushort* sharedBuckets,
             __global uint* sortedData)
{

    size_t groupId = get_group_id(0);
    size_t localId = get_local_id(0);
    size_t globalId = get_global_id(0);
    size_t groupSize = get_local_size(0);


    /* Copy prescaned thread histograms to corresponding thread shared block */
    for(int i = 0; i < RADICES; ++i)
    {
        uint bucketPos = groupId * RADICES * groupSize + localId * RADICES + i;
        sharedBuckets[localId * RADICES + i] = scanedBuckets[bucketPos];
    }

    barrier(CLK_LOCAL_MEM_FENCE);

    /* Premute elements to appropriate location */
    for(int i = 0; i < RADICES; ++i)
    {
        uint value = unsortedData[globalId * RADICES + i];
        value = (value >> shiftCount) & 0xFFU;
        uint index = sharedBuckets[localId * RADICES + value];
        sortedData[index] = unsortedData[globalId * RADICES + i];
        sharedBuckets[localId * RADICES + value] = index + 1;
	barrier(CLK_LOCAL_MEM_FENCE);

    }
}


// buildOptions=
// RUN: %occ-cli %s --cl-options="-I%cwd -I%S " %cfg_path --cl-device=%cl_device 2>&1
