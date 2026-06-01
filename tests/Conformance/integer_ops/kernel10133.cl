// RUN: %occ-cli %s --cl-options= --cl-device=%cl_device %cfg_path
__kernel void test_popcount_long16(__global long16 *srcA,
                                   __global long16 *dst) {
  int tid = get_global_id(0);

  long16 sA;
  sA = srcA[tid];
  long16 dstVal = popcount(sA);
  dst[tid] = dstVal;
}
