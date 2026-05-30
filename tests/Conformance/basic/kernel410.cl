// RUN: %occ-cli %s --cl-options= --cl-device=%cl_device %cfg_path
#pragma OPENCL EXTENSION cl_khr_fp64 : enable
__kernel void test_lo_double8(__global double8 *srcA, __global double4 *dst) {
  int tid = get_global_id(0);

  double4 tmp = srcA[tid].lo;
  dst[tid] = tmp;
}
