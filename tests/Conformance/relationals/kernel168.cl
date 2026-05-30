// RUN: %occ-cli %s --cl-options= --cl-device=%cl_device %cfg_path
#pragma OPENCL EXTENSION cl_khr_fp64 : enable
__kernel void sample_test(__global double3 *sourceA, __global double3 *sourceB,
                          __global long3 *destValues,
                          __global long3 *destValuesB) {
  int tid = get_global_id(0);
  double3 sampA = vload3(tid, (__global double *)sourceA);
  double3 sampB = vload3(tid, (__global double *)sourceB);
  vstore3(isnotequal(sampA, sampB), tid, (__global long *)destValues);
  vstore3((sampA != sampB), tid, (__global long *)destValuesB);
}
