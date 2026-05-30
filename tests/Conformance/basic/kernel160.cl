// RUN: %occ-cli %s --cl-options= --cl-device=%cl_device %cfg_path
__kernel void test_hi_ushort8(__global ushort8 *srcA, __global ushort4 *dst) {
  int tid = get_global_id(0);

  ushort4 tmp = srcA[tid].hi;
  dst[tid] = tmp;
}
