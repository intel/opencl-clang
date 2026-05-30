// RUN: %occ-cli %s --cl-options= --cl-device=%cl_device %cfg_path
__kernel void test_buffer_fill_ushort(__global ushort *src,
                                      __global ushort *dst) {
  int tid = get_global_id(0);

  dst[tid] = src[tid];
}
