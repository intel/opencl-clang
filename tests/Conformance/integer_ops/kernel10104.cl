// RUN: %occ-cli %s --cl-options= --cl-device=%cl_device %cfg_path
__kernel void test_popcount_short(__global short *srcA, __global short *dst) {
  int tid = get_global_id(0);

  short sA;
  sA = srcA[tid];
  short dstVal = popcount(sA);
  dst[tid] = dstVal;
}
