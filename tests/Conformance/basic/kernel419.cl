// RUN: %occ-cli %s --cl-options= --cl-device=%cl_device %cfg_path
#pragma OPENCL EXTENSION cl_khr_fp64 : enable
__kernel void test_even_double4(__global double4 *srcA, __global double2 *dst) {
  int tid = get_global_id(0);

  double2 tmp =
      ((double4)(srcA[tid].s0, srcA[tid].s1, srcA[tid].s2, srcA[tid].s3)).even;
  dst[tid] = tmp;
}
