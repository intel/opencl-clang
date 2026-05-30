// RUN: %occ-cli %s --cl-options= --cl-device=%cl_device %cfg_path
__kernel void test_absdiff_uchar(__global uchar *srcA, __global uchar *srcB,
                                 __global uchar *dst) {
  int tid = get_global_id(0);

  uchar sA, sB;
  sA = srcA[tid];
  sB = srcB[tid];
  uchar dstVal = abs_diff(sA, sB);
  dst[tid] = dstVal;
}
