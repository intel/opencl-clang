// RUN: %occ-cli %s --cl-options= --cl-device=%cl_device %cfg_path

__kernel void sample_test(__global char4 *sourceA, __global int *destValues) {
  int tid = get_global_id(0);
  destValues[tid] = any(sourceA[tid]);
}
