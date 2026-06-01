// RUN: %occ-cli %s --cl-options= --cl-device=%cl_device %cfg_path
#pragma OPENCL EXTENSION cl_khr_fp64 : enable
__kernel void test_odd_double2(__global double2 *srcA, __global double *dst) {
  int tid = get_global_id(0);

  double tmp = ((double2)(srcA[tid].s0, srcA[tid].s1)).odd;
  dst[tid] = tmp;
}
