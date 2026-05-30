// RUN: %occ-cli %s --cl-options= --cl-device=%cl_device %cfg_path
__kernel void test_conversion(__global long *sourceValues,
                              __global long2 *destValues) {
  int tid = get_global_id(0);
  long src = sourceValues[tid];

  destValues[tid] = (long2)src;
}
