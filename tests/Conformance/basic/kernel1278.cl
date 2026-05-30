// RUN: %occ-cli %s --cl-options= --cl-device=%cl_device %cfg_path
#pragma OPENCL EXTENSION cl_khr_fp64 : enable
__kernel void test_fn(__global double *src, __global uint2 *dst) {
  int tid = get_global_id(0);
  uint2 tmp = as_uint2(src[tid]);
  dst[tid] = tmp;
}
