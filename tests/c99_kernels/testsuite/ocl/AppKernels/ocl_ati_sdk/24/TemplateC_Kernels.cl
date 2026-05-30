/*!
 * Sample kernel which multiplies every element of the input array with
 * a constant and stores it at the corresponding output array
 */

__kernel void templateKernel(__global  unsigned int * output,
                             __global  unsigned int * input,
                             const     unsigned int multiplier)
{
    uint tid = get_global_id(0);

    output[tid] = input[tid] * multiplier;
}


// buildOptions=
// RUN: %occ-cli %s --cl-options="-I%cwd -I%S " %cfg_path --cl-device=%cl_device 2>&1
