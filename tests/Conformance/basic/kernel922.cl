// RUN: %occ-cli %s --cl-options= --cl-device=%cl_device %cfg_path
__kernel void test_conversion(__global float *sourceValues,
                              __global float4 *destValues) {
  int tid = get_global_id(0);
  float src = sourceValues[tid];

  destValues[tid] = (float4)src;
}
