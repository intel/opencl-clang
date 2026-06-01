// RUN: %occ-cli %s --cl-options= --cl-device=%cl_device %cfg_path
__kernel void test_lo_long8(__global long8 *srcA, __global long4 *dst) {
  int tid = get_global_id(0);

  long4 tmp = srcA[tid].lo;
  dst[tid] = tmp;
}
