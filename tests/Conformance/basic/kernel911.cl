// RUN: %occ-cli %s --cl-options= --cl-device=%cl_device %cfg_path
__kernel void test_conversion(__global uint *sourceValues,
                              __global uint8 *destValues) {
  int tid = get_global_id(0);
  uint src = sourceValues[tid];

  destValues[tid] = (uint8)src;
}
