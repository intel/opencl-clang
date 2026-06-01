// RUN: %occ-cli %s --cl-options= --cl-device=%cl_device %cfg_path
__kernel void test_absdiff_uint4(__global uint4 *srcA, __global uint4 *srcB,
                                 __global uint4 *dst) {
  int tid = get_global_id(0);

  uint4 sA, sB;
  sA = srcA[tid];
  sB = srcB[tid];
  uint4 dstVal = abs_diff(sA, sB);
  dst[tid] = dstVal;
}
