// RUN: %occ-cli %s --cl-options= --cl-device=%cl_device %cfg_path
__kernel void test_lo_char4(__global char4 *srcA, __global char2 *dst) {
  int tid = get_global_id(0);

  char2 tmp = srcA[tid].lo;
  dst[tid] = tmp;
}
