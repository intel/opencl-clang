// RUN: %occ-cli %s --cl-options= --cl-device=%cl_device %cfg_path
__kernel void test_absdiff_short16(__global short16 *srcA,
                                   __global short16 *srcB,
                                   __global ushort16 *dst) {
  int tid = get_global_id(0);

  short16 sA, sB;
  sA = srcA[tid];
  sB = srcB[tid];
  ushort16 dstVal = abs_diff(sA, sB);
  dst[tid] = dstVal;
}
