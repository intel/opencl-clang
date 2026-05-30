// RUN: %occ-cli %s --cl-options= --cl-device=%cl_device %cfg_path
#pragma OPENCL EXTENSION cl_khr_fp64 : enable
__kernel void sample_test(__global double4 *sourceA, __global double4 *sourceB,
                          __global long4 *destValues,
                          __global long4 *destValuesB) {
  int tid = get_global_id(0);
  destValues[tid] = islessgreater(sourceA[tid], sourceB[tid]);
  destValuesB[tid] =
      (sourceA[tid] < sourceB[tid]) | (sourceA[tid] > sourceB[tid]);
}
