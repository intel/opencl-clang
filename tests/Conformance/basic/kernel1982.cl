// RUN: %occ-cli %s --cl-options= --cl-device=%cl_device %cfg_path

__kernel void test_vector_creation(__global char *src, __global char4 *result) {
  result[0] = (char4)(src[0], src[1], src[2], src[3]);
  result[1] = (char4)(src[0], src[1], vload2(0, src + 2));
  result[2] = (char4)(src[0], vload2(0, src + 1), src[3]);
  result[3] = (char4)(src[0], vload3(0, src + 1));
  result[4] = (char4)(vload2(0, src + 0), src[2], src[3]);
  result[5] = (char4)(vload2(0, src + 0), vload2(0, src + 2));
  result[6] = (char4)(vload3(0, src + 0), src[3]);
  result[7] = (char4)(vload4(0, src + 0));
}
