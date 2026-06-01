// RUN: %occ-cli %s --cl-options= --cl-device=%cl_device %cfg_path
__kernel void test_buffer_read_uint16(__global uint16 *dst) {
  int tid = get_global_id(0);

  dst[tid] = ((1U << 16) + 1U);
}
