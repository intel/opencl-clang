// RUN: %occ-cli %s --cl-options= --cl-device=%cl_device %cfg_path

__kernel void test_vector_creation(__global long *src, __global long4 *result) {
  result[0] = (long4)(src[0], src[1], src[2], src[3]);
  result[1] = (long4)(src[0], src[1], vload2(0, src + 2));
  result[2] = (long4)(src[0], vload2(0, src + 1), src[3]);
  result[3] = (long4)(src[0], vload3(0, src + 1));
  result[4] = (long4)(vload2(0, src + 0), src[2], src[3]);
  result[5] = (long4)(vload2(0, src + 0), vload2(0, src + 2));
  result[6] = (long4)(vload3(0, src + 0), src[3]);
  result[7] = (long4)(vload4(0, src + 0));
}
