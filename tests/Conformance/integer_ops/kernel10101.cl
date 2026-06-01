// RUN: %occ-cli %s --cl-options= --cl-device=%cl_device %cfg_path
__kernel void test_popcount_uchar4(__global uchar4 *srcA,
                                   __global uchar4 *dst) {
  int tid = get_global_id(0);

  uchar4 sA;
  sA = srcA[tid];
  uchar4 dstVal = popcount(sA);
  dst[tid] = dstVal;
}
