// RUN: %occ-cli %s --cl-options= --cl-device=%cl_device %cfg_path
#pragma OPENCL EXTENSION cl_khr_fp64 : enable
__kernel void test(__global double2 *p, __global half *f) {
  size_t i = get_global_id(0);
  vstorea_half2_rtz(p[i], i, f);
}
