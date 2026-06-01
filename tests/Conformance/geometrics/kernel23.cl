// RUN: %occ-cli %s --cl-options= --cl-device=%cl_device %cfg_path
__kernel void sample_test(__global float4 *sourceA, __global float4 *sourceB,
                          __global float *destValues) {
  int tid = get_global_id(0);
  destValues[tid] = fast_distance(sourceA[tid], sourceB[tid]);
}
