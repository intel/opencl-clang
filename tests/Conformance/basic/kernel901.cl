// RUN: %occ-cli %s --cl-options= --cl-device=%cl_device %cfg_path
__kernel void test_conversion(__global ushort *sourceValues,
                              __global ushort2 *destValues) {
  int tid = get_global_id(0);
  ushort src = sourceValues[tid];

  destValues[tid] = (ushort2)src;
}
