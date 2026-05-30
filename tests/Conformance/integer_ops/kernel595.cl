// RUN: %occ-cli %s --cl-options= --cl-device=%cl_device %cfg_path
__kernel void test_absdiff_uint2(__global uint2 *srcA, __global uint2 *srcB,
                                 __global uint2 *dst) {
  int tid = get_global_id(0);

  uint2 sA, sB;
  sA = srcA[tid];
  sB = srcB[tid];
  uint2 dstVal = abs_diff(sA, sB);
  dst[tid] = dstVal;
}
