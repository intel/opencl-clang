// RUN: %occ-cli %s --cl-options= --cl-device=%cl_device %cfg_path
__constant int outVal = 42;
__constant int outIndex = 7;
__constant int outValues[16] = {17,  01, 11, 12,   1955, 11, 5,    1985,
                                113, 1,  24, 1984, 7,    23, 1979, 97};

__kernel void constant_kernel(__global int *out) {
  int tid = get_global_id(0);

  if (tid == 0) {
    out[0] = outVal;
    out[1] = outValues[outIndex];
  } else {
    out[tid + 1] = outValues[tid];
  }
}
