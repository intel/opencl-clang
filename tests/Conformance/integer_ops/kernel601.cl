// RUN: %occ-cli %s --cl-options= --cl-device=%cl_device %cfg_path
__kernel void test_absdiff_long2(__global long2 *srcA, __global long2 *srcB,
                                 __global ulong2 *dst) {
  int tid = get_global_id(0);

  long2 sA, sB;
  sA = srcA[tid];
  sB = srcB[tid];
  ulong2 dstVal = abs_diff(sA, sB);
  dst[tid] = dstVal;
}
