// RUN: %occ-cli %s --cl-options= --cl-device=%cl_device %cfg_path
#pragma OPENCL EXTENSION cl_khr_fp64 : enable
__kernel __attribute__((vec_type_hint(double2))) void
sample_test(__global int *src, __global int *dst) {
  int tid = get_global_id(0);
  dst[tid] = src[tid];
}
