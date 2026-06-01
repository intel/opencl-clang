// RUN: %occ-cli %s --cl-options= --cl-device=%cl_device %cfg_path
__kernel void test_popcount_short8(__global short8 *srcA,
                                   __global short8 *dst) {
  int tid = get_global_id(0);

  short8 sA;
  sA = srcA[tid];
  short8 dstVal = popcount(sA);
  dst[tid] = dstVal;
}
