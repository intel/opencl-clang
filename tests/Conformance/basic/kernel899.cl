// RUN: %occ-cli %s --cl-options= --cl-device=%cl_device %cfg_path
__kernel void test_conversion(__global short *sourceValues,
                              __global short8 *destValues) {
  int tid = get_global_id(0);
  short src = sourceValues[tid];

  destValues[tid] = (short8)src;
}
