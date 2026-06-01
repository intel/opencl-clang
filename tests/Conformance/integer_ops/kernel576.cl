// RUN: %occ-cli %s --cl-options= --cl-device=%cl_device %cfg_path
__kernel void test_absdiff_short(__global short *srcA, __global short *srcB,
                                 __global ushort *dst) {
  int tid = get_global_id(0);

  short sA, sB;
  sA = srcA[tid];
  sB = srcB[tid];
  ushort dstVal = abs_diff(sA, sB);
  dst[tid] = dstVal;
}
