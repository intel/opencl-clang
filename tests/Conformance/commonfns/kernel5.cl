// RUN: %occ-cli %s --cl-options= --cl-device=%cl_device %cfg_path
#pragma OPENCL EXTENSION cl_khr_fp64 : enable
__kernel void test_clamp(__global double4 *x, __global double4 *minval,
                         __global double4 *maxval, __global double4 *dst) {
  int tid = get_global_id(0);

  dst[tid] = clamp(x[tid], minval[tid], maxval[tid]);
}
