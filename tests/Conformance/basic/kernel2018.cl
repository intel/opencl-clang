// RUN: %occ-cli %s --cl-options= --cl-device=%cl_device %cfg_path
#pragma OPENCL EXTENSION cl_khr_fp64 : enable
__kernel void test_vector_creation(__global double *src,
                                   __global double4 *result) {
  result[0] = (double4)(src[0], src[1], src[2], src[3]);
  result[1] = (double4)(src[0], src[1], vload2(0, src + 2));
  result[2] = (double4)(src[0], vload2(0, src + 1), src[3]);
  result[3] = (double4)(src[0], vload3(0, src + 1));
  result[4] = (double4)(vload2(0, src + 0), src[2], src[3]);
  result[5] = (double4)(vload2(0, src + 0), vload2(0, src + 2));
  result[6] = (double4)(vload3(0, src + 0), src[3]);
  result[7] = (double4)(vload4(0, src + 0));
}
