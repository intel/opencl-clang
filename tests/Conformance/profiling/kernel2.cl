// RUN: %occ-cli %s --cl-options= --cl-device=%cl_device %cfg_path
__kernel void test_stream_read_int4(__global int4 *dst) {
  int tid = get_global_id(0);

  dst[tid] = ((1 << 16) + 1);
}
