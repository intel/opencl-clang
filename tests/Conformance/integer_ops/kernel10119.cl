// RUN: %occ-cli %s --cl-options= --cl-device=%cl_device %cfg_path
__kernel void test_popcount_int4(__global int4 *srcA, __global int4 *dst) {
  int tid = get_global_id(0);

  int4 sA;
  sA = srcA[tid];
  int4 dstVal = popcount(sA);
  dst[tid] = dstVal;
}
