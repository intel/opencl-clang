// RUN: %occ-cli %s --cl-options= --cl-device=%cl_device %cfg_path
__kernel void test_buffer_write_uint2(__global uint2 *src,
                                      __global uint2 *dst) {
  int tid = get_global_id(0);

  dst[tid] = src[tid];
}
