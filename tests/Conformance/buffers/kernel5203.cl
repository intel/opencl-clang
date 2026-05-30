// RUN: %occ-cli %s --cl-options= --cl-device=%cl_device %cfg_path
__kernel void test_buffer_fill_char2(__global char2 *src, __global char2 *dst) {
  int tid = get_global_id(0);

  dst[tid] = src[tid];
}
