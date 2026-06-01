// RUN: %occ-cli %s --cl-options= --cl-device=%cl_device %cfg_path
__kernel void test_popcount_uchar16(__global uchar16 *srcA,
                                    __global uchar16 *dst) {
  int tid = get_global_id(0);

  uchar16 sA;
  sA = srcA[tid];
  uchar16 dstVal = popcount(sA);
  dst[tid] = dstVal;
}
