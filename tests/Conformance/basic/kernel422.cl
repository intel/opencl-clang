// RUN: %occ-cli %s --cl-options= --cl-device=%cl_device %cfg_path
#pragma OPENCL EXTENSION cl_khr_fp64 : enable
__kernel void test_even_double16(__global double16 *srcA,
                                 __global double8 *dst) {
  int tid = get_global_id(0);

  double8 tmp = srcA[tid].even;
  dst[tid] = tmp;
}
