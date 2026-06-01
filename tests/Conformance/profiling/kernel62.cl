// RUN: %occ-cli %s --cl-options= --cl-device=%cl_device %cfg_path
__kernel void test_stream_write_ulong2(__global ulong2 *src,
                                       __global ulong2 *dst) {
  int tid = get_global_id(0);

  dst[tid] = src[tid];
}
