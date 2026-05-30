// RUN: %occ-cli %s --cl-options= --cl-device=%cl_device %cfg_path
__kernel void test_popcount_int8(__global int8 *srcA, __global int8 *dst) {
  int tid = get_global_id(0);

  int8 sA;
  sA = srcA[tid];
  int8 dstVal = popcount(sA);
  dst[tid] = dstVal;
}
