// RUN: %occ-cli %s --cl-options= --cl-device=%cl_device %cfg_path
__kernel void test_popcount_uint(__global uint *srcA, __global uint *dst) {
  int tid = get_global_id(0);

  uint sA;
  sA = srcA[tid];
  uint dstVal = popcount(sA);
  dst[tid] = dstVal;
}
