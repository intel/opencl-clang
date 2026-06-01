// RUN: %occ-cli %s --cl-options= --cl-device=%cl_device %cfg_path
__kernel void test_popcount_uint8(__global uint8 *srcA, __global uint8 *dst) {
  int tid = get_global_id(0);

  uint8 sA;
  sA = srcA[tid];
  uint8 dstVal = popcount(sA);
  dst[tid] = dstVal;
}
