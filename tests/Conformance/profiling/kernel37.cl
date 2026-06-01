// RUN: %occ-cli %s --cl-options= --cl-device=%cl_device %cfg_path
__kernel void test_stream_read_char4(__global char4 *dst) {
  int tid = get_global_id(0);

  dst[tid] = (char)'w';
}
