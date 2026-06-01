// RUN: %occ-cli %s --cl-options= --cl-device=%cl_device %cfg_path
__kernel void test_absdiff_uint8(__global uint8 *srcA, __global uint8 *srcB,
                                 __global uint8 *dst) {
  int tid = get_global_id(0);

  uint8 sA, sB;
  sA = srcA[tid];
  sB = srcB[tid];
  uint8 dstVal = abs_diff(sA, sB);
  dst[tid] = dstVal;
}
