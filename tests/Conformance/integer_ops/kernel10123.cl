// RUN: %occ-cli %s --cl-options= --cl-device=%cl_device %cfg_path
__kernel void test_popcount_uint2(__global uint2 *srcA, __global uint2 *dst) {
  int tid = get_global_id(0);

  uint2 sA;
  sA = srcA[tid];
  uint2 dstVal = popcount(sA);
  dst[tid] = dstVal;
}
