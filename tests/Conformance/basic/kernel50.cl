// RUN: %occ-cli %s --cl-options= --cl-device=%cl_device %cfg_path
__kernel void test_lo_char8(__global char8 *srcA, __global char4 *dst) {
  int tid = get_global_id(0);

  char4 tmp = srcA[tid].lo;
  dst[tid] = tmp;
}
