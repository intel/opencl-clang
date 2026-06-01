// RUN: %occ-cli %s --cl-options= --cl-device=%cl_device %cfg_path
__kernel void test_conversion(__global ulong *sourceValues,
                              __global ulong4 *destValues) {
  int tid = get_global_id(0);
  ulong src = sourceValues[tid];

  destValues[tid] = (ulong4)src;
}
