// RUN: %occ-cli %s --cl-options= --cl-device=%cl_device %cfg_path
__kernel void test_convert_uint8_sat_rtn_char8(__global char8 *src,
                                               __global uint8 *dest) {
  size_t i = get_global_id(0);
  dest[i] = convert_uint8_sat_rtn(src[i]);
}
