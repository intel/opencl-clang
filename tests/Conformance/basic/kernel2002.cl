// RUN: %occ-cli %s --cl-options= --cl-device=%cl_device %cfg_path

__kernel void test_vector_creation(__global uint *src, __global uint4 *result) {
  result[0] = (uint4)(src[0], src[1], src[2], src[3]);
  result[1] = (uint4)(src[0], src[1], vload2(0, src + 2));
  result[2] = (uint4)(src[0], vload2(0, src + 1), src[3]);
  result[3] = (uint4)(src[0], vload3(0, src + 1));
  result[4] = (uint4)(vload2(0, src + 0), src[2], src[3]);
  result[5] = (uint4)(vload2(0, src + 0), vload2(0, src + 2));
  result[6] = (uint4)(vload3(0, src + 0), src[3]);
  result[7] = (uint4)(vload4(0, src + 0));
}
