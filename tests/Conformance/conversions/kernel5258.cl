// RUN: %occ-cli %s --cl-options= --cl-device=%cl_device %cfg_path
__kernel void test_convert_long2_float2(__global float2 *src,
                                        __global long2 *dest) {
  size_t i = get_global_id(0);
  dest[i] = convert_long2(src[i]);
}
