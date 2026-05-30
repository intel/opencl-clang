// RUN: %occ-cli %s --cl-options= --cl-device=%cl_device %cfg_path
#pragma OPENCL EXTENSION cl_khr_fp64 : enable
__kernel void test_vector_creation(__global double *src,
                                   __global double2 *result) {
  result[0] = (double2)(src[0], src[1]);
  result[1] = (double2)(vload2(0, src + 0));
}
