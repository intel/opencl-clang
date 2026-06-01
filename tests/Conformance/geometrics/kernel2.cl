// RUN: %occ-cli %s --cl-options= --cl-device=%cl_device %cfg_path
#pragma OPENCL EXTENSION cl_khr_fp64 : enable
__kernel void sample_test(__global double *sourceA, __global double *sourceB,
                          __global double *destValues) {
  int tid = get_global_id(0);
  vstore3(cross(vload3(tid, sourceA), vload3(tid, sourceB)), tid, destValues);
}
