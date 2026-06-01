// RUN: %occ-cli %s --cl-options= --cl-device=%cl_device %cfg_path
__kernel void test_popcount_long4(__global long4 *srcA, __global long4 *dst) {
  int tid = get_global_id(0);

  long4 sA;
  sA = srcA[tid];
  long4 dstVal = popcount(sA);
  dst[tid] = dstVal;
}
