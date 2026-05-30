// RUN: %occ-cli %s --cl-options= --cl-device=%cl_device %cfg_path
__kernel void test_popcount_ulong8(__global ulong8 *srcA,
                                   __global ulong8 *dst) {
  int tid = get_global_id(0);

  ulong8 sA;
  sA = srcA[tid];
  ulong8 dstVal = popcount(sA);
  dst[tid] = dstVal;
}
