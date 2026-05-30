// RUN: %occ-cli %s --cl-options= --cl-device=%cl_device %cfg_path

__kernel void test_vector_creation(__global float *src,
                                   __global float4 *result) {
  result[0] = (float4)(src[0], src[1], src[2], src[3]);
  result[1] = (float4)(src[0], src[1], vload2(0, src + 2));
  result[2] = (float4)(src[0], vload2(0, src + 1), src[3]);
  result[3] = (float4)(src[0], vload3(0, src + 1));
  result[4] = (float4)(vload2(0, src + 0), src[2], src[3]);
  result[5] = (float4)(vload2(0, src + 0), vload2(0, src + 2));
  result[6] = (float4)(vload3(0, src + 0), src[3]);
  result[7] = (float4)(vload4(0, src + 0));
}
