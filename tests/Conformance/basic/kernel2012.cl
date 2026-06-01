// RUN: %occ-cli %s --cl-options= --cl-device=%cl_device %cfg_path

__kernel void test_vector_creation(__global float *src,
                                   __global float2 *result) {
  result[0] = (float2)(src[0], src[1]);
  result[1] = (float2)(vload2(0, src + 0));
}
