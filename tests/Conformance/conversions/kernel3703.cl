// RUN: %occ-cli %s --cl-options= --cl-device=%cl_device %cfg_path
__kernel void test_convert_float16_rte_char16(__global char16 *src,
                                              __global float16 *dest) {
  size_t i = get_global_id(0);
  dest[i] = convert_float16_rte(src[i]);
}
