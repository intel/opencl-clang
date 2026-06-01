// RUN: %occ-cli %s --cl-options= --cl-device=%cl_device %cfg_path
__kernel void test_abs_ushort8(__global ushort8 *srcA, __global ushort8 *dst) {
  int tid = get_global_id(0);

  ushort8 tmp = abs(srcA[tid]);
  dst[tid] = tmp;
}
