// RUN: %occ-cli %s --cl-options= --cl-device=%cl_device %cfg_path
__kernel void test_absdiff_int(__global int *srcA, __global int *srcB,
                               __global uint *dst) {
  int tid = get_global_id(0);

  int sA, sB;
  sA = srcA[tid];
  sB = srcB[tid];
  uint dstVal = abs_diff(sA, sB);
  dst[tid] = dstVal;
}
