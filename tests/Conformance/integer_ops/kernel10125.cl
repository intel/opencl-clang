// RUN: %occ-cli %s --cl-options= --cl-device=%cl_device %cfg_path
__kernel void test_popcount_uint4(__global uint4 *srcA, __global uint4 *dst) {
  int tid = get_global_id(0);

  uint4 sA;
  sA = srcA[tid];
  uint4 dstVal = popcount(sA);
  dst[tid] = dstVal;
}
