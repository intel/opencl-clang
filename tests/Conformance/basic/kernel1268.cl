// RUN: %occ-cli %s --cl-options= --cl-device=%cl_device %cfg_path
#pragma OPENCL EXTENSION cl_khr_fp64 : enable
__kernel void test_fn(__global double *src, __global short4 *dst) {
  int tid = get_global_id(0);
  short4 tmp = as_short4(src[tid]);
  dst[tid] = tmp;
}
