// RUN: %occ-cli %s --cl-options= --cl-device=%cl_device %cfg_path
#pragma OPENCL EXTENSION cl_khr_fp64 : enable
__kernel void test(__global double4 *p, __global half *f) {
  __private double4 data;
  size_t i = get_global_id(0);
  data = p[i];
  vstorea_half4(data, i, f);
}
