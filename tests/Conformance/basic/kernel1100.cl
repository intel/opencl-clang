// RUN: %occ-cli %s --cl-options= --cl-device=%cl_device %cfg_path
#pragma OPENCL EXTENSION cl_khr_fp64 : enable
__kernel void test_fn(__global int2 *src, __global double *dst) {
  int tid = get_global_id(0);
  double tmp = as_double(src[tid]);
  dst[tid] = tmp;
}
