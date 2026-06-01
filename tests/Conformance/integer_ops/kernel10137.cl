// RUN: %occ-cli %s --cl-options= --cl-device=%cl_device %cfg_path
__kernel void test_popcount_ulong4(__global ulong4 *srcA,
                                   __global ulong4 *dst) {
  int tid = get_global_id(0);

  ulong4 sA;
  sA = srcA[tid];
  ulong4 dstVal = popcount(sA);
  dst[tid] = dstVal;
}
