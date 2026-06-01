// RUN: %occ-cli %s --cl-options= --cl-device=%cl_device %cfg_path
__kernel void sample_test(__global float3 *sourceA, __global float3 *sourceB,
                          __global int3 *destValues,
                          __global int3 *destValuesB) {
  int tid = get_global_id(0);
  float3 sampA = vload3(tid, (__global float *)sourceA);
  float3 sampB = vload3(tid, (__global float *)sourceB);
  vstore3(isgreater(sampA, sampB), tid, (__global int *)destValues);
  vstore3((sampA > sampB), tid, (__global int *)destValuesB);
}
