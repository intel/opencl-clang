// RUN: %occ-cli %s --cl-options= --cl-device=%cl_device %cfg_path
#pragma OPENCL EXTENSION cl_khr_fp64 : enable
__kernel void test_fn(__global double2 *src, __global char16 *dst) {
  int tid = get_global_id(0);
  char16 tmp = as_char16(src[tid]);
  dst[tid] = tmp;
}
