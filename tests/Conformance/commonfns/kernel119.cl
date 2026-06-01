// RUN: %occ-cli %s --cl-options= --cl-device=%cl_device %cfg_path
#pragma OPENCL EXTENSION cl_khr_fp64 : enable
__kernel void test_step16_double(__global double16 *srcA,
                                 __global double16 *srcB,
                                 __global double16 *dst) {
  int tid = get_global_id(0);

  dst[tid] = step(srcA[tid], srcB[tid]);
}
