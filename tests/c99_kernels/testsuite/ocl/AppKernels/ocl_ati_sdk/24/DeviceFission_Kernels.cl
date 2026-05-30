/*
 * Copys the input to output
 */
__kernel
void
copy(__global float* input, __global float* output)
{
    size_t xPos = get_global_id(0);
    output[xPos] = input[xPos];
}


// buildOptions=
// RUN: %occ-cli %s --cl-options="-I%cwd -I%S " %cfg_path --cl-device=%cl_device 2>&1
