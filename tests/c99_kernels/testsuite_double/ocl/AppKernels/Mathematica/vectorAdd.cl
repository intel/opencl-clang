#define USING_OPENCL_FUNCTION 1
#define OPENCLLINK_USING_NVIDIA
#define mint long
#define Real_t double
#define USING_DOUBLE_PRECISIONQ 1
#define MAX_ITERATIONS 100

__kernel void vectorAdd(__global mint * a, __global mint * b, __global mint * c, mint n) {
    int iGID = get_global_id(0);

    if (iGID < n) {
        c[iGID] = a[iGID] + b[iGID];
    }
}


// buildOptions=
// RUN: %occ-cli %s --cl-options="-I%cwd -I%S " %cfg_path --cl-device=%cl_device 2>&1
