// RUN: %occ-cli %s --cl-options= --cl-device=%cl_device %cfg_path
__kernel void test_conversion(__global int *sourceValues,
                              __global int8 *destValues) {
  int tid = get_global_id(0);
  int src = sourceValues[tid];

  destValues[tid] = (int8)src;
}
