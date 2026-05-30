// RUN: %occ-cli %s --cl-options= --cl-device=%cl_device %cfg_path
__kernel void test_buffer_write_short2(__global short2 *src,
                                       __global short2 *dst) {
  int tid = get_global_id(0);

  dst[tid] = src[tid];
}
