// RUN: %occ-cli %s --cl-options= --cl-device=%cl_device %cfg_path
__kernel void test_absdiff_long8(__global long8 *srcA, __global long8 *srcB,
                                 __global ulong8 *dst) {
  int tid = get_global_id(0);

  long8 sA, sB;
  sA = srcA[tid];
  sB = srcB[tid];
  ulong8 dstVal = abs_diff(sA, sB);
  dst[tid] = dstVal;
}
