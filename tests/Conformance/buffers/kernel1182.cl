// RUN: %occ-cli %s --cl-options= --cl-device=%cl_device %cfg_path
__kernel void test_buffer_write_long4(__global long4 *src,
                                      __global long4 *dst) {
  int tid = get_global_id(0);

  dst[tid] = src[tid];
}
