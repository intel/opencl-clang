// RUN: %occ-cli %s --cl-options= --cl-device=%cl_device %cfg_path
#pragma OPENCL EXTENSION cl_khr_fp64 : enable
__kernel void test_fn(__global double8 *src, __global float16 *dst) {
  int tid = get_global_id(0);
  float16 tmp = as_float16(src[tid]);
  dst[tid] = tmp;
}
