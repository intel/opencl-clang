// RUN: %occ-cli %s --cl-options= --cl-device=%cl_device %cfg_path
__kernel void test_buffer_fill_ulong16(__global ulong16 *src,
                                       __global ulong16 *dst) {
  int tid = get_global_id(0);

  dst[tid] = src[tid];
}
