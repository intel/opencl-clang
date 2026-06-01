// RUN: %occ-cli %s --cl-options= --cl-device=%cl_device %cfg_path
__kernel void test_absdiff_short2(__global short2 *srcA, __global short2 *srcB,
                                  __global ushort2 *dst) {
  int tid = get_global_id(0);

  short2 sA, sB;
  sA = srcA[tid];
  sB = srcB[tid];
  ushort2 dstVal = abs_diff(sA, sB);
  dst[tid] = dstVal;
}
