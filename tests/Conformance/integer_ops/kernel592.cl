// RUN: %occ-cli %s --cl-options= --cl-device=%cl_device %cfg_path
__kernel void test_absdiff_int8(__global int8 *srcA, __global int8 *srcB,
                                __global uint8 *dst) {
  int tid = get_global_id(0);

  int8 sA, sB;
  sA = srcA[tid];
  sB = srcB[tid];
  uint8 dstVal = abs_diff(sA, sB);
  dst[tid] = dstVal;
}
