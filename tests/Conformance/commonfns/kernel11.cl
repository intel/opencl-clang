// RUN: %occ-cli %s --cl-options= --cl-device=%cl_device %cfg_path
#pragma OPENCL EXTENSION cl_khr_fp64 : enable
__kernel void test_clamp(__global double *x, __global double *minval,
                         __global double *maxval, __global double *dst) {
  int tid = get_global_id(0);

  vstore3(clamp(vload3(tid, x), vload3(tid, minval), vload3(tid, maxval)), tid,
          dst);
}
