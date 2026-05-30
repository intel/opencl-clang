// RUN: %occ-cli %s --cl-options= --cl-device=%cl_device %cfg_path
__kernel void test_popcount_long(__global long *srcA, __global long *dst) {
  int tid = get_global_id(0);

  long sA;
  sA = srcA[tid];
  long dstVal = popcount(sA);
  dst[tid] = dstVal;
}
