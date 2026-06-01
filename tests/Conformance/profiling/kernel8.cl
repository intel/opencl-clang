// RUN: %occ-cli %s --cl-options= --cl-device=%cl_device %cfg_path
__kernel void test_stream_read_uint8(__global uint8 *dst) {
  int tid = get_global_id(0);

  dst[tid] = ((1U << 16) + 1U);
}
