/*
 * For a description of the algorithm and the terms used, please see the
 * documentation for this sample.
 *
 * Each block invocation of this kernel, reduces block of input array
 * to a single value and writes this value to output.
 *
 * Each work-item loads its data from input array to shared memory of block.
 * Reduction of each block is done in multiple passes. In first pass
 * first half work-items are active and they update their values in shared memory
 * by adding other half values in shared memory. In subsequent passes number
 * of active threads are reduced to half and they keep updating their value with
 * other half values of shared memory.
 */

__kernel
void
reduce(__global uint4* input, __global uint4* output, __local uint4* sdata)
{
    // load shared mem
    unsigned int tid = get_local_id(0);
    unsigned int bid = get_group_id(0);
    unsigned int gid = get_global_id(0);

    unsigned int localSize = get_local_size(0);
    sdata[tid] = input[gid];
    barrier(CLK_LOCAL_MEM_FENCE);

    // do reduction in shared mem
    for(unsigned int s = localSize / 2; s > 0; s >>= 1)
    {
        if(tid < s)
        {
            sdata[tid] += sdata[tid + s];
        }
        barrier(CLK_LOCAL_MEM_FENCE);
    }

    // write result for this block to global mem
    if(tid == 0) output[bid] = sdata[0];
}


// buildOptions=
// RUN: %occ-cli %s --cl-options="-I%cwd -I%S " %cfg_path --cl-device=%cl_device 2>&1
