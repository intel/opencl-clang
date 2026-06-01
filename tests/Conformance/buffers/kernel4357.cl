// RUN: %occ-cli %s --cl-options= --cl-device=%cl_device %cfg_path
__kernel void test_mem_read(__global int *src, __global int *dst) {
  int tid = get_global_id(0);

  dst[tid] = src[tid] + 1;
}
