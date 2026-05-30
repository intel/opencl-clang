// RUN: %occ-cli %s --cl-options= --cl-device=%cl_device %cfg_path
__kernel void test_popcount_char8(__global char8 *srcA, __global char8 *dst) {
  int tid = get_global_id(0);

  char8 sA;
  sA = srcA[tid];
  char8 dstVal = popcount(sA);
  dst[tid] = dstVal;
}
