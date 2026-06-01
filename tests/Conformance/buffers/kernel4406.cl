// RUN: %occ-cli %s --cl-options= --cl-device=%cl_device %cfg_path
__kernel void test_buffer_fill_int16(__global int16 *src, __global int16 *dst) {
  int tid = get_global_id(0);

  dst[tid] = src[tid];
}
