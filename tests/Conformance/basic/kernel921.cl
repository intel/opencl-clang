// RUN: %occ-cli %s --cl-options= --cl-device=%cl_device %cfg_path
__kernel void test_conversion(__global float *sourceValues,
                              __global float2 *destValues) {
  int tid = get_global_id(0);
  float src = sourceValues[tid];

  destValues[tid] = (float2)src;
}
