// RUN: %occ-cli %s --cl-options= --cl-device=%cl_device %cfg_path
__kernel void test_lo_ulong8(__global ulong8 *srcA, __global ulong4 *dst) {
  int tid = get_global_id(0);

  ulong4 tmp = srcA[tid].lo;
  dst[tid] = tmp;
}
