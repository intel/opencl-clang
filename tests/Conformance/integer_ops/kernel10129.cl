// RUN: %occ-cli %s --cl-options= --cl-device=%cl_device %cfg_path
__kernel void test_popcount_long2(__global long2 *srcA, __global long2 *dst) {
  int tid = get_global_id(0);

  long2 sA;
  sA = srcA[tid];
  long2 dstVal = popcount(sA);
  dst[tid] = dstVal;
}
