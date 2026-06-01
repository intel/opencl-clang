// RUN: %occ-cli %s --cl-options= --cl-device=%cl_device %cfg_path
__kernel void test_buffer_read_ulong8(__global ulong8 *dst) {
  int tid = get_global_id(0);

  dst[tid] = ((1UL << 32) + 1UL);
}
