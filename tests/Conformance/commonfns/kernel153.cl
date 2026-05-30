// RUN: %occ-cli %s --cl-options= --cl-device=%cl_device %cfg_path
#pragma OPENCL EXTENSION cl_khr_fp64 : enable
__kernel void test_sign3_double(__global double *src, __global double *dst) {
  int tid = get_global_id(0);

  vstore3(sign(vload3(tid, src)), tid, dst);
}
