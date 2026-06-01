// RUN: %occ-cli %s --cl-options= --cl-device=%cl_device %cfg_path
#pragma OPENCL EXTENSION cl_khr_fp64 : enable
__kernel void test_fn(__global double4 *x, __global double4 *y,
                      __global double4 *dst) {
  int tid = get_global_id(0);

  dst[tid] = min(x[tid], y[tid]);
}
