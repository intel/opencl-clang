// RUN: %occ-cli %s --cl-options= --cl-device=%cl_device %cfg_path
#pragma OPENCL EXTENSION cl_khr_fp64 : enable
__kernel void test_fn(__global double4 *src, __global long *dst) {
  int tid = get_global_id(0);
  long3 tmp = as_long3(src[tid]);
  vstore3(tmp, tid, dst);
}
