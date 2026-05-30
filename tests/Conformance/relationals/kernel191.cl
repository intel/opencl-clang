// RUN: %occ-cli %s --cl-options= --cl-device=%cl_device %cfg_path
#pragma OPENCL EXTENSION cl_khr_fp64 : enable
__kernel void sample_test(__global double2 *sourceA, __global double2 *sourceB,
                          __global long2 *destValues,
                          __global long2 *destValuesB) {
  int tid = get_global_id(0);
  destValues[tid] = isgreaterequal(sourceA[tid], sourceB[tid]);
  destValuesB[tid] = sourceA[tid] >= sourceB[tid];
}
