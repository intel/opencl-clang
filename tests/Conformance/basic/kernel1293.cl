// RUN: %occ-cli %s --cl-options= --cl-device=%cl_device %cfg_path
#pragma OPENCL EXTENSION cl_khr_fp64 : enable
__kernel void test_fn(__global double4 *src, __global ulong4 *dst) {
  int tid = get_global_id(0);
  ulong4 tmp = as_ulong4(src[tid]);
  dst[tid] = tmp;
}
