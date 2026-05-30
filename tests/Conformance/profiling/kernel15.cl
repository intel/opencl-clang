// RUN: %occ-cli %s --cl-options= --cl-device=%cl_device %cfg_path
__kernel void test_stream_read_ulong(__global ulong *dst) {
  int tid = get_global_id(0);

  dst[tid] = ((1UL << 32) + 1UL);
}
