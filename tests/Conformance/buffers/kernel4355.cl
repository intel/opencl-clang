// RUN: %occ-cli %s --cl-options= --cl-device=%cl_device %cfg_path
__kernel void test_mem_read_write(__global int *dst) {
  int tid = get_global_id(0);

  dst[tid] = dst[tid] + 1;
}
