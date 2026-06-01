// RUN: %occ-cli %s --cl-options= --cl-device=%cl_device %cfg_path
__kernel void test_popcount_int(__global int *srcA, __global int *dst) {
  int tid = get_global_id(0);

  int sA;
  sA = srcA[tid];
  int dstVal = popcount(sA);
  dst[tid] = dstVal;
}
