
__kernel void multiDeviceKernel(__global float *input,
                                __global float *output)
{
    uint tid = get_global_id(0);

    float a = mad(input[tid], input[tid], 1);
    float b = mad(input[tid], input[tid], 2);

    for(int i = 0; i < KERNEL_ITERATIONS; i++)
    {
        a = hypot(a, b);
        b = hypot(a, b);
     }

    output[tid] = (a + b);
}


// buildOptions= -D KERNEL_ITERATIONS=10
// RUN: %occ-cli %s --cl-options="-I%cwd -I%S  -D KERNEL_ITERATIONS=10" %cfg_path --cl-device=%cl_device 2>&1
