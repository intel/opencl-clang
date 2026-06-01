// RUN: %occ-cli %s --cl-options= --cl-device=%cl_device %cfg_path
__kernel void test_popcount_short2(__global short2 *srcA,
                                   __global short2 *dst) {
  int tid = get_global_id(0);

  short2 sA;
  sA = srcA[tid];
  short2 dstVal = popcount(sA);
  dst[tid] = dstVal;
}
