// RUN: %occ-cli %s --cl-options= --cl-device=%cl_device %cfg_path
__kernel void test_absdiff_ulong2(__global ulong2 *srcA, __global ulong2 *srcB,
                                  __global ulong2 *dst) {
  int tid = get_global_id(0);

  ulong2 sA, sB;
  sA = srcA[tid];
  sB = srcB[tid];
  ulong2 dstVal = abs_diff(sA, sB);
  dst[tid] = dstVal;
}
