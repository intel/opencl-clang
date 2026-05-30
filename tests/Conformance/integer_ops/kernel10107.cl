// RUN: %occ-cli %s --cl-options= --cl-device=%cl_device %cfg_path
__kernel void test_popcount_short4(__global short4 *srcA,
                                   __global short4 *dst) {
  int tid = get_global_id(0);

  short4 sA;
  sA = srcA[tid];
  short4 dstVal = popcount(sA);
  dst[tid] = dstVal;
}
