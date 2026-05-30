// RUN: %occ-cli %s --cl-options= --cl-device=%cl_device %cfg_path
#pragma OPENCL EXTENSION cl_khr_fp64 : enable
__kernel void test_degrees2_double(__global double2 *src,
                                   __global double2 *dst) {
  int tid = get_global_id(0);

  dst[tid] = degrees(src[tid]);
}
