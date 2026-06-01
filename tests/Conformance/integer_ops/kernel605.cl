// RUN: %occ-cli %s --cl-options= --cl-device=%cl_device %cfg_path
__kernel void test_absdiff_long16(__global long16 *srcA, __global long16 *srcB,
                                  __global ulong16 *dst) {
  int tid = get_global_id(0);

  long16 sA, sB;
  sA = srcA[tid];
  sB = srcB[tid];
  ulong16 dstVal = abs_diff(sA, sB);
  dst[tid] = dstVal;
}
