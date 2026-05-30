// RUN: %occ-cli %s --cl-options= --cl-device=%cl_device %cfg_path
__kernel void test_popcount_int2(__global int2 *srcA, __global int2 *dst) {
  int tid = get_global_id(0);

  int2 sA;
  sA = srcA[tid];
  int2 dstVal = popcount(sA);
  dst[tid] = dstVal;
}
