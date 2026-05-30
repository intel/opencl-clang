// RUN: %occ-cli %s --cl-options= --cl-device=%cl_device %cfg_path
__kernel void test_convert_char8_sat_rtn_ushort8(__global ushort8 *src,
                                                 __global char8 *dest) {
  size_t i = get_global_id(0);
  dest[i] = convert_char8_sat_rtn(src[i]);
}
