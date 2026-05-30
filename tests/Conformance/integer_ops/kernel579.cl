// RUN: %occ-cli %s --cl-options= --cl-device=%cl_device %cfg_path
__kernel void test_absdiff_short4(__global short4 *srcA, __global short4 *srcB,
                                  __global ushort4 *dst) {
  int tid = get_global_id(0);

  short4 sA, sB;
  sA = srcA[tid];
  sB = srcB[tid];
  ushort4 dstVal = abs_diff(sA, sB);
  dst[tid] = dstVal;
}
