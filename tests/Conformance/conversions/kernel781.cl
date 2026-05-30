// RUN: %occ-cli %s --cl-options= --cl-device=%cl_device %cfg_path
__kernel void test_convert_char_sat_rtn_ushort(__global ushort *src,
                                               __global char *dest) {
  size_t i = get_global_id(0);
  dest[i] = convert_char_sat_rtn(src[i]);
}
