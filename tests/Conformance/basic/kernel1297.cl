// RUN: %occ-cli %s --cl-options= --cl-device=%cl_device %cfg_path
#pragma OPENCL EXTENSION cl_khr_fp64 : enable
__kernel void test_fn(__global double4 *src, __global ulong *dst) {
  int tid = get_global_id(0);
  ulong3 tmp = as_ulong3(src[tid]);
  vstore3(tmp, tid, dst);
}
