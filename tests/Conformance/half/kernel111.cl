// RUN: %occ-cli %s --cl-options= --cl-device=%cl_device %cfg_path
#pragma OPENCL EXTENSION cl_khr_fp64 : enable
__kernel void test(__global double3 *p, __global half *f) {
  size_t i = get_global_id(0);
  vstorea_half3(p[i], i, f);
  vstore_half(((__global double *)p)[4 * i + 3], 4 * i + 3, f);
}
