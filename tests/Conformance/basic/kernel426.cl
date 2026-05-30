// RUN: %occ-cli %s --cl-options= --cl-device=%cl_device %cfg_path
#pragma OPENCL EXTENSION cl_khr_fp64 : enable
__kernel void test_odd_double3(__global double3 *srcA, __global double2 *dst) {
  int tid = get_global_id(0);

  double2 tmp = srcA[tid].odd;
  dst[tid] = tmp;
}
