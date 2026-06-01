// RUN: %occ-cli %s --cl-options= --cl-device=%cl_device %cfg_path
__kernel void test_absdiff_uint16(__global uint16 *srcA, __global uint16 *srcB,
                                  __global uint16 *dst) {
  int tid = get_global_id(0);

  uint16 sA, sB;
  sA = srcA[tid];
  sB = srcB[tid];
  uint16 dstVal = abs_diff(sA, sB);
  dst[tid] = dstVal;
}
