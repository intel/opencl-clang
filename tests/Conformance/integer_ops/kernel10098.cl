// RUN: %occ-cli %s --cl-options= --cl-device=%cl_device %cfg_path
__kernel void test_popcount_uchar(__global uchar *srcA, __global uchar *dst) {
  int tid = get_global_id(0);

  uchar sA;
  sA = srcA[tid];
  uchar dstVal = popcount(sA);
  dst[tid] = dstVal;
}
