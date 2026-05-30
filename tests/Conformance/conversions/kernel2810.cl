// RUN: %occ-cli %s --cl-options= --cl-device=%cl_device %cfg_path
__kernel void test_convert_uint4_float4(__global float4 *src,
                                        __global uint4 *dest) {
  size_t i = get_global_id(0);
  dest[i] = convert_uint4(src[i]);
}
