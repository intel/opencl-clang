#define USING_OPENCL_FUNCTION 1
#define OPENCLLINK_USING_NVIDIA
#define mint long
#define Real_t double
#define USING_DOUBLE_PRECISIONQ 1
#define MAX_ITERATIONS 100

__kernel void gol_kernel(__global mint * prev, __global mint * nxt, mint width, mint height) {
    int xIndex = get_global_id(0);
    int yIndex = get_global_id(1);
    int index = xIndex + yIndex*width;
    int ii, jj, curr, neighbrs;

    if (xIndex < width && yIndex < height) {
        curr = prev[index];
        neighbrs = 0;
        for (ii = -1; ii <= 1; ii++) {
            if (xIndex + ii >= 0 && xIndex+ii < width) {
                for (jj = -1; jj <= 1; jj++) {
                    if (yIndex+jj >= 0 && yIndex+jj < height) {
                        neighbrs += prev[xIndex + ii + (yIndex+jj)*width];
                    }
                }
            }
        }
        neighbrs -= 2*curr;
        if (curr == 1)
            nxt[index] = (neighbrs == 2 || neighbrs == 3) ? 1 : 0;
        else
            nxt[index] = (neighbrs == 3) ? 1 : 0;
    }
}


// buildOptions=
// RUN: %occ-cli %s --cl-options="-I%cwd -I%S " %cfg_path --cl-device=%cl_device 2>&1
