// RUN: %occ-cli %s --cl-options= --cl-device=%cl_device %cfg_path

__kernel void test_vector_creation(__global uint *src, __global uint *result) {
  vstore3((uint3)(src[0], src[1], src[2]), 0, result);
  vstore3((uint3)(src[0], vload2(0, src + 1)), 1, result);
  vstore3((uint3)(vload2(0, src + 0), src[2]), 2, result);
  vstore3((uint3)(vload3(0, src + 0)), 3, result);
}
