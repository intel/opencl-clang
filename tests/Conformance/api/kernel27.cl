// RUN: %occ-cli %s --cl-options= --cl-device=%cl_device %cfg_path
__kernel void sample_test(__constant int *src1, __global int *dst) {
  int tid = get_global_id(0);

  dst[tid] = src1[tid];
}
