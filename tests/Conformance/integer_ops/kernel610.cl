// RUN: %occ-cli %s --cl-options= --cl-device=%cl_device %cfg_path
__kernel void test_absdiff_ulong8(__global ulong8 *srcA, __global ulong8 *srcB,
                                  __global ulong8 *dst) {
  int tid = get_global_id(0);

  ulong8 sA, sB;
  sA = srcA[tid];
  sB = srcB[tid];
  ulong8 dstVal = abs_diff(sA, sB);
  dst[tid] = dstVal;
}
