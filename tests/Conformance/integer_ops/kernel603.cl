// RUN: %occ-cli %s --cl-options= --cl-device=%cl_device %cfg_path
__kernel void test_absdiff_long4(__global long4 *srcA, __global long4 *srcB,
                                 __global ulong4 *dst) {
  int tid = get_global_id(0);

  long4 sA, sB;
  sA = srcA[tid];
  sB = srcB[tid];
  ulong4 dstVal = abs_diff(sA, sB);
  dst[tid] = dstVal;
}
