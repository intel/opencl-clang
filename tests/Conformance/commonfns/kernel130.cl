// RUN: %occ-cli %s --cl-options= --cl-device=%cl_device %cfg_path
#pragma OPENCL EXTENSION cl_khr_fp64 : enable
__kernel void test_step8_double(__global double *srcA, __global double8 *srcB,
                                __global double8 *dst) {
  int tid = get_global_id(0);

  dst[tid] = step(srcA[tid], srcB[tid]);
}
