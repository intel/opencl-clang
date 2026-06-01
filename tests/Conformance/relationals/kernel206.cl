// RUN: %occ-cli %s --cl-options= --cl-device=%cl_device %cfg_path
#pragma OPENCL EXTENSION cl_khr_fp64 : enable
__kernel void sample_test(__global double8 *sourceA, __global double8 *sourceB,
                          __global long8 *destValues,
                          __global long8 *destValuesB) {
  int tid = get_global_id(0);
  destValues[tid] = isless(sourceA[tid], sourceB[tid]);
  destValuesB[tid] = sourceA[tid] < sourceB[tid];
}
