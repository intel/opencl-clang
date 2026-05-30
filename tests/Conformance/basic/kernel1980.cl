// RUN: %occ-cli %s --cl-options= --cl-device=%cl_device %cfg_path

__kernel void test_vector_creation(__global char *src, __global char2 *result) {
  result[0] = (char2)(src[0], src[1]);
  result[1] = (char2)(vload2(0, src + 0));
}
