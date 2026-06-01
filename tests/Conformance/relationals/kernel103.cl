// RUN: %occ-cli %s --cl-options= --cl-device=%cl_device %cfg_path
#pragma OPENCL EXTENSION cl_khr_fp64 : enable
__kernel void sample_test(__global double2 *sourceA, __global double2 *sourceB,
                          __global double2 *sourceC,
                          __global double2 *destValues) {
  int tid = get_global_id(0);
  destValues[tid] = bitselect(sourceA[tid], sourceB[tid], sourceC[tid]);
}
