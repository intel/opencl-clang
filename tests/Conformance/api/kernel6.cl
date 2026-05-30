// RUN: %occ-cli %s --cl-options= --cl-device=%cl_device %cfg_path
__kernel void sample_test(__global float *src, __global int *dst) {
  int tid = get_global_id(0);
  for (int i = 0; i < 1000000; i++)
    ;
  dst[tid] = (int)src[tid];
}
