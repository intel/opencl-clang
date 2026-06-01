// RUN: %occ-cli %s --cl-options= --cl-device=%cl_device %cfg_path
__kernel void test_popcount_char2(__global char2 *srcA, __global char2 *dst) {
  int tid = get_global_id(0);

  char2 sA;
  sA = srcA[tid];
  char2 dstVal = popcount(sA);
  dst[tid] = dstVal;
}
