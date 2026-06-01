// RUN: %occ-cli %s --cl-options= --cl-device=%cl_device %cfg_path
__kernel void test_popcount_uchar8(__global uchar8 *srcA,
                                   __global uchar8 *dst) {
  int tid = get_global_id(0);

  uchar8 sA;
  sA = srcA[tid];
  uchar8 dstVal = popcount(sA);
  dst[tid] = dstVal;
}
