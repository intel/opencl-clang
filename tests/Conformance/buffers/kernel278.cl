// RUN: %occ-cli %s --cl-options= --cl-device=%cl_device %cfg_path
__kernel void test_buffer_read_long8(__global long8 *dst) {
  int tid = get_global_id(0);

  dst[tid] = ((1L << 32) + 1L);
}
