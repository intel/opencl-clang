// RUN: %occ-cli %s --cl-options= --cl-device=%cl_device %cfg_path
__kernel void sample_test(__global float16 *sourceA, __global float16 *sourceB,
                          __global int16 *destValues,
                          __global int16 *destValuesB) {
  int tid = get_global_id(0);
  destValues[tid] = isgreater(sourceA[tid], sourceB[tid]);
  destValuesB[tid] = sourceA[tid] > sourceB[tid];
}
