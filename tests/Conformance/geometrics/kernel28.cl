// RUN: %occ-cli %s --cl-options= --cl-device=%cl_device %cfg_path
#pragma OPENCL EXTENSION cl_khr_fp64 : enable
__kernel void sample_test(__global double *sourceA,
                          __global double *destValues) {
  int tid = get_global_id(0);
  destValues[tid] = length(sourceA[tid]);
}
