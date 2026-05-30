// RUN: %occ-cli %s --cl-options= --cl-device=%cl_device %cfg_path
#pragma OPENCL EXTENSION cl_khr_fp64 : enable
__kernel void test_fn(__global double *x, __global double *y,
                      __global double *dst) {
  int tid = get_global_id(0);

  vstore3(min(vload3(tid, x), vload3(tid, y)), tid, dst);
}
