// RUN: %occ-cli %s --cl-options= --cl-device=%cl_device %cfg_path
__kernel void test_popcount_int16(__global int16 *srcA, __global int16 *dst) {
  int tid = get_global_id(0);

  int16 sA;
  sA = srcA[tid];
  int16 dstVal = popcount(sA);
  dst[tid] = dstVal;
}
