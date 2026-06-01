// RUN: %occ-cli %s --cl-options= --cl-device=%cl_device %cfg_path
__kernel void test_buffer_read_short2(__global short2 *dst) {
  int tid = get_global_id(0);

  dst[tid] = (short)((1 << 8) + 1);
}
