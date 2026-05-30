// RUN: %occ-cli %s --cl-options= --cl-device=%cl_device %cfg_path
#pragma OPENCL EXTENSION cl_khr_fp64 : enable
__kernel void test(__global double3 *p, __global half *f) {
  __private double3 data;
  size_t i = get_global_id(0);
  data = p[i];
  vstorea_half3_rtp(data, i, f);
  vstore_half_rtp(((__global double *)p)[4 * i + 3], 4 * i + 3, f);
}
