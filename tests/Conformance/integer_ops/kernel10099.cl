// RUN: %occ-cli %s --cl-options= --cl-device=%cl_device %cfg_path
__kernel void test_popcount_uchar2(__global uchar2 *srcA,
                                   __global uchar2 *dst) {
  int tid = get_global_id(0);

  uchar2 sA;
  sA = srcA[tid];
  uchar2 dstVal = popcount(sA);
  dst[tid] = dstVal;
}
