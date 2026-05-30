// RUN: %occ-cli %s --cl-options= --cl-device=%cl_device %cfg_path
#pragma OPENCL EXTENSION cl_khr_fp64 : enable
__kernel void test_fn(__global double4 *src, __global short16 *dst) {
  int tid = get_global_id(0);
  short16 tmp = as_short16(src[tid]);
  dst[tid] = tmp;
}
