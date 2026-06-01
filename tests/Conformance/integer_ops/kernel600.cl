// RUN: %occ-cli %s --cl-options= --cl-device=%cl_device %cfg_path
__kernel void test_absdiff_long(__global long *srcA, __global long *srcB,
                                __global ulong *dst) {
  int tid = get_global_id(0);

  long sA, sB;
  sA = srcA[tid];
  sB = srcB[tid];
  ulong dstVal = abs_diff(sA, sB);
  dst[tid] = dstVal;
}
