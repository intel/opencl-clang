// RUN: %occ-cli %s --cl-options= --cl-device=%cl_device %cfg_path
#pragma OPENCL EXTENSION cl_khr_fp64 : enable
__kernel void test_fn(__global ulong4 *src, __global double *dst) {
  int tid = get_global_id(0);
  double3 tmp = as_double3(src[tid]);
  vstore3(tmp, tid, dst);
}
