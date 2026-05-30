// RUN: %occ-cli %s --cl-options= --cl-device=%cl_device %cfg_path
__kernel void sample_test(__global float2 *sourceA, __global float2 *sourceB,
                          __global int2 *destValues,
                          __global int2 *destValuesB) {
  int tid = get_global_id(0);
  destValues[tid] = isgreater(sourceA[tid], sourceB[tid]);
  destValuesB[tid] = sourceA[tid] > sourceB[tid];
}
