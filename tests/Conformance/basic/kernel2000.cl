// RUN: %occ-cli %s --cl-options= --cl-device=%cl_device %cfg_path

__kernel void test_vector_creation(__global uint *src, __global uint2 *result) {
  result[0] = (uint2)(src[0], src[1]);
  result[1] = (uint2)(vload2(0, src + 0));
}
