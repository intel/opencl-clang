// RUN: %occ-cli %s --cl-options= --cl-device=%cl_device %cfg_path
#pragma OPENCL EXTENSION cl_khr_fp64 : enable
__kernel void test_step3_double(__global double *srcA, __global double *srcB,
                                __global double *dst) {
  int tid = get_global_id(0);

  vstore3(step(srcA[tid], vload3(tid, srcB)), tid, dst);
}
