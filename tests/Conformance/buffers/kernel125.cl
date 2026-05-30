// RUN: %occ-cli %s --cl-options= --cl-device=%cl_device %cfg_path
__kernel void test_buffer_read_ushort(__global ushort *dst) {
  int tid = get_global_id(0);

  dst[tid] = (ushort)((1 << 8) + 1);
}
