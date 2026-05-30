// RUN: %occ-cli %s --cl-options= --cl-device=%cl_device %cfg_path
__kernel void test_absdiff_uchar2(__global uchar2 *srcA, __global uchar2 *srcB,
                                  __global uchar2 *dst) {
  int tid = get_global_id(0);

  uchar2 sA, sB;
  sA = srcA[tid];
  sB = srcB[tid];
  uchar2 dstVal = abs_diff(sA, sB);
  dst[tid] = dstVal;
}
