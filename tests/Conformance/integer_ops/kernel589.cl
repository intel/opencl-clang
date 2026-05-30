// RUN: %occ-cli %s --cl-options= --cl-device=%cl_device %cfg_path
__kernel void test_absdiff_int2(__global int2 *srcA, __global int2 *srcB,
                                __global uint2 *dst) {
  int tid = get_global_id(0);

  int2 sA, sB;
  sA = srcA[tid];
  sB = srcB[tid];
  uint2 dstVal = abs_diff(sA, sB);
  dst[tid] = dstVal;
}
