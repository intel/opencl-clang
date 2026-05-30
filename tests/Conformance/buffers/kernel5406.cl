// RUN: %occ-cli %s --cl-options= --cl-device=%cl_device %cfg_path
__kernel void test_buffer_fill_uchar16(__global uchar16 *src,
                                       __global uchar16 *dst) {
  int tid = get_global_id(0);

  dst[tid] = src[tid];
}
