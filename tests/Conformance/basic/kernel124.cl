// RUN: %occ-cli %s --cl-options= --cl-device=%cl_device %cfg_path
__kernel void test_lo_short2(__global short2 *srcA, __global short *dst) {
  int tid = get_global_id(0);

  short tmp = srcA[tid].lo;
  dst[tid] = tmp;
}
