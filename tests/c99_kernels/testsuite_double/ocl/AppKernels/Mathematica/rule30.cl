#define USING_OPENCL_FUNCTION 1
#define OPENCLLINK_USING_NVIDIA
#define mint long
#define Real_t double
#define USING_DOUBLE_PRECISIONQ 1
#define MAX_ITERATIONS 100

__kernel void rule30_kernel(__global mint * prev, __global mint * nxt, mint width) {
    int index = get_global_id(0);
    int p, q, r;

    if (index < width) {
        p = index == 0 ? 0 : prev[index-1];
        q = prev[index];
        r = index == width-1 ? 0 : prev[index+1];
        nxt[index] = p ^ (q | r);
    }
}


// buildOptions=
// RUN: %occ-cli %s --cl-options="-I%cwd -I%S " %cfg_path --cl-device=%cl_device 2>&1
