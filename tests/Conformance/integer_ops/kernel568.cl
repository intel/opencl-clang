// RUN: %occ-cli %s --cl-options= --cl-device=%cl_device %cfg_path
__kernel void test_absdiff_char8(__global char8 *srcA, __global char8 *srcB,
                                 __global uchar8 *dst) {
  int tid = get_global_id(0);

  char8 sA, sB;
  sA = srcA[tid];
  sB = srcB[tid];
  uchar8 dstVal = abs_diff(sA, sB);
  dst[tid] = dstVal;
}
