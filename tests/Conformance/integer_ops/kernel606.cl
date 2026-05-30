// RUN: %occ-cli %s --cl-options= --cl-device=%cl_device %cfg_path
__kernel void test_absdiff_ulong(__global ulong *srcA, __global ulong *srcB,
                                 __global ulong *dst) {
  int tid = get_global_id(0);

  ulong sA, sB;
  sA = srcA[tid];
  sB = srcB[tid];
  ulong dstVal = abs_diff(sA, sB);
  dst[tid] = dstVal;
}
