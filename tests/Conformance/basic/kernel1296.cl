// RUN: %occ-cli %s --cl-options= --cl-device=%cl_device %cfg_path
#pragma OPENCL EXTENSION cl_khr_fp64 : enable
__kernel void test_fn(__global double *src, __global ulong4 *dst) {
  int tid = get_global_id(0);
  ulong4 tmp = as_ulong4(vload3(tid, src));
  dst[tid] = tmp;
}
