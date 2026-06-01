// RUN: %occ-cli %s --cl-options= --cl-device=%cl_device %cfg_path
__kernel void test_convert_char16_sat_rte_uint16(__global uint16 *src,
                                                 __global char16 *dest) {
  size_t i = get_global_id(0);
  dest[i] = convert_char16_sat_rte(src[i]);
}
