// RUN: %occ-cli %s --cl-options= --cl-device=%cl_device %cfg_path
__kernel void test_stream_read_short16(__global short16 *dst) {
  int tid = get_global_id(0);

  dst[tid] = (short)((1 << 8) + 1);
}
