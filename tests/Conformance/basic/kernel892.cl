// RUN: %occ-cli %s --cl-options= --cl-device=%cl_device %cfg_path
__kernel void test_conversion(__global char *sourceValues,
                              __global char16 *destValues) {
  int tid = get_global_id(0);
  char src = sourceValues[tid];

  destValues[tid] = (char16)src;
}
