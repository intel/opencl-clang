// RUN: %occ-cli %s --cl-options= --cl-device=%cl_device %cfg_path
__kernel void test_buffer_write_float16(__global float16 *src,
                                        __global float16 *dst) {
  int tid = get_global_id(0);

  dst[tid] = src[tid];
}
