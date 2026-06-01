// RUN: %occ-cli %s --cl-options= --cl-device=%cl_device %cfg_path
__kernel void test_buffer_fill_uint8(__global uint8 *src, __global uint8 *dst) {
  int tid = get_global_id(0);

  dst[tid] = src[tid];
}
