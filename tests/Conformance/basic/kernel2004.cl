// RUN: %occ-cli %s --cl-options= --cl-device=%cl_device %cfg_path

__kernel void test_vector_creation(__global long *src, __global long2 *result) {
  result[0] = (long2)(src[0], src[1]);
  result[1] = (long2)(vload2(0, src + 0));
}
