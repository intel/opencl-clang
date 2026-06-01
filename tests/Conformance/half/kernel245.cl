// RUN: %occ-cli %s --cl-options= --cl-device=%cl_device %cfg_path
#pragma OPENCL EXTENSION cl_khr_fp64 : enable
__kernel void test(__global double3 *p, __global half *f) {
  __local double3 data[128];
  size_t i = get_global_id(0);
  size_t lid = get_local_id(0);
  data[lid] = p[i];
  vstorea_half3_rtz(data[lid], i, f);
  vstore_half_rtz(((__global double *)p)[4 * i + 3], 4 * i + 3, f);
}
