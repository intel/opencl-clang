// RUN: %occ-cli %s --cl-options= --cl-device=%cl_device %cfg_path
__kernel void test_absdiff_ushort(__global ushort *srcA, __global ushort *srcB,
                                  __global ushort *dst) {
  int tid = get_global_id(0);

  ushort sA, sB;
  sA = srcA[tid];
  sB = srcB[tid];
  ushort dstVal = abs_diff(sA, sB);
  dst[tid] = dstVal;
}
