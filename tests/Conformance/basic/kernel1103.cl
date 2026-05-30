// RUN: %occ-cli %s --cl-options= --cl-device=%cl_device %cfg_path
#pragma OPENCL EXTENSION cl_khr_fp64 : enable
__kernel void test_fn(__global int16 *src, __global double8 *dst) {
  int tid = get_global_id(0);
  double8 tmp = as_double8(src[tid]);
  dst[tid] = tmp;
}
