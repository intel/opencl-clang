// RUN: %occ-cli %s --cl-options= --cl-device=%cl_device %cfg_path
__kernel void test_convert_float4_rtp_float4(__global float4 *src,
                                             __global float4 *dest) {
  size_t i = get_global_id(0);
  dest[i] = convert_float4_rtp(src[i]);
}
