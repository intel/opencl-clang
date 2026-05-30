// RUN: %occ-cli %s --cl-options= --cl-device=%cl_device %cfg_path
#pragma OPENCL EXTENSION cl_khr_fp64 : enable
__kernel void test_fn(__global long16 *src, __global double16 *dst) {
  int tid = get_global_id(0);
  double16 tmp = as_double16(src[tid]);
  dst[tid] = tmp;
}
