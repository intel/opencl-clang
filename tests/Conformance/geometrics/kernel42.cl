// RUN: %occ-cli %s --cl-options= --cl-device=%cl_device %cfg_path
#pragma OPENCL EXTENSION cl_khr_fp64 : enable
__kernel void sample_test(__global double3 *sourceA,
                          __global double3 *destValues) {
  int tid = get_global_id(0);
  vstore3(normalize(vload3(tid, (__global double *)sourceA)), tid,
          (__global double *)destValues);
}
