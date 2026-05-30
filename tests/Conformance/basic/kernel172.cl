// RUN: %occ-cli %s --cl-options= --cl-device=%cl_device %cfg_path
__kernel void test_lo_ushort16(__global ushort16 *srcA, __global ushort8 *dst) {
  int tid = get_global_id(0);

  ushort8 tmp = srcA[tid].lo;
  dst[tid] = tmp;
}
