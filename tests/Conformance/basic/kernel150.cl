// RUN: %occ-cli %s --cl-options= --cl-device=%cl_device %cfg_path
__kernel void test_odd_short8(__global short8 *srcA, __global short4 *dst) {
  int tid = get_global_id(0);

  short4 tmp = srcA[tid].odd;
  dst[tid] = tmp;
}
