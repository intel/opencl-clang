// RUN: %occ-cli %s --cl-options= --cl-device=%cl_device %cfg_path
__kernel void test_popcount_char4(__global char4 *srcA, __global char4 *dst) {
  int tid = get_global_id(0);

  char4 sA;
  sA = srcA[tid];
  char4 dstVal = popcount(sA);
  dst[tid] = dstVal;
}
