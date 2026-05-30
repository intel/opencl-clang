// RUN: %occ-cli %s --cl-options= --cl-device=%cl_device %cfg_path
__kernel void test_buffer_read_int(__global int *dst) {
  int tid = get_global_id(0);

  dst[tid] = ((1 << 16) + 1);
}
