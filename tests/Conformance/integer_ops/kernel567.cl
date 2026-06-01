// RUN: %occ-cli %s --cl-options= --cl-device=%cl_device %cfg_path
__kernel void test_absdiff_char4(__global char4 *srcA, __global char4 *srcB,
                                 __global uchar4 *dst) {
  int tid = get_global_id(0);

  char4 sA, sB;
  sA = srcA[tid];
  sB = srcB[tid];
  uchar4 dstVal = abs_diff(sA, sB);
  dst[tid] = dstVal;
}
