// RUN: %occ-cli %s --cl-options= --cl-device=%cl_device %cfg_path
__kernel void test_convert_uchar8_sat_char8(__global char8 *src,
                                            __global uchar8 *dest) {
  size_t i = get_global_id(0);
  dest[i] = convert_uchar8_sat(src[i]);
}
