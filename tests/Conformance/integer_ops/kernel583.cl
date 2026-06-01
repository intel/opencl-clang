// RUN: %occ-cli %s --cl-options= --cl-device=%cl_device %cfg_path
__kernel void test_absdiff_ushort2(__global ushort2 *srcA,
                                   __global ushort2 *srcB,
                                   __global ushort2 *dst) {
  int tid = get_global_id(0);

  ushort2 sA, sB;
  sA = srcA[tid];
  sB = srcB[tid];
  ushort2 dstVal = abs_diff(sA, sB);
  dst[tid] = dstVal;
}
