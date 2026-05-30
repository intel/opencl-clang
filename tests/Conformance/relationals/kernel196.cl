// RUN: %occ-cli %s --cl-options= --cl-device=%cl_device %cfg_path
__kernel void sample_test(__global float *sourceA, __global float *sourceB,
                          __global int *destValues, __global int *destValuesB) {
  int tid = get_global_id(0);
  destValues[tid] = isless(sourceA[tid], sourceB[tid]);
  destValuesB[tid] = sourceA[tid] < sourceB[tid];
}
