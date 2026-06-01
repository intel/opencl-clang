// RUN: %occ-cli %s --cl-options= --cl-device=%cl_device %cfg_path
__kernel void test_conversion(__global ulong *sourceValues,
                              __global ulong16 *destValues) {
  int tid = get_global_id(0);
  ulong src = sourceValues[tid];

  destValues[tid] = (ulong16)src;
}
