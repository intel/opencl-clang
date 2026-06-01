// RUN: %occ-cli %s --cl-options= --cl-device=%cl_device %cfg_path
__kernel void test_absdiff_short8(__global short8 *srcA, __global short8 *srcB,
                                  __global ushort8 *dst) {
  int tid = get_global_id(0);

  short8 sA, sB;
  sA = srcA[tid];
  sB = srcB[tid];
  ushort8 dstVal = abs_diff(sA, sB);
  dst[tid] = dstVal;
}
