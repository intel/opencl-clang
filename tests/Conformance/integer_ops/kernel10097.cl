// RUN: %occ-cli %s --cl-options= --cl-device=%cl_device %cfg_path
__kernel void test_popcount_char16(__global char16 *srcA,
                                   __global char16 *dst) {
  int tid = get_global_id(0);

  char16 sA;
  sA = srcA[tid];
  char16 dstVal = popcount(sA);
  dst[tid] = dstVal;
}
