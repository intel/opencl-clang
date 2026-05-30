// RUN: %occ-cli %s --cl-options= --cl-device=%cl_device %cfg_path
#pragma OPENCL EXTENSION cl_khr_fp64 : enable
__kernel void test_fn(__global double16 *src, __global ulong16 *dst) {
  int tid = get_global_id(0);
  ulong16 tmp = as_ulong16(src[tid]);
  dst[tid] = tmp;
}
