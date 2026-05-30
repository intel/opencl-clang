// RUN: %occ-cli %s --cl-options= --cl-device=%cl_device %cfg_path
#pragma OPENCL EXTENSION cl_khr_fp64 : enable
__kernel void test_clamp(__global double8 *x, __global double8 *minval,
                         __global double8 *maxval, __global double8 *dst) {
  int tid = get_global_id(0);

  dst[tid] = clamp(x[tid], minval[tid], maxval[tid]);
}
