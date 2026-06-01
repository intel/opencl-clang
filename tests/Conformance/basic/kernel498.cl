// RUN: %occ-cli %s --cl-options= --cl-device=%cl_device %cfg_path
#pragma OPENCL EXTENSION cl_khr_fp64 : enable
__kernel __attribute__((reqd_work_group_size(1, 1, 1))) void
test_sizeof(__global uint *dst) {
  dst[0] = (uint)sizeof(double16);
}
