// RUN: %occ-cli %s --cl-options= --cl-device=%cl_device %cfg_path
__kernel void test_absdiff_uint(__global uint *srcA, __global uint *srcB,
                                __global uint *dst) {
  int tid = get_global_id(0);

  uint sA, sB;
  sA = srcA[tid];
  sB = srcB[tid];
  uint dstVal = abs_diff(sA, sB);
  dst[tid] = dstVal;
}
