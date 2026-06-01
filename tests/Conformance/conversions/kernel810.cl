// RUN: %occ-cli %s --cl-options= --cl-device=%cl_device %cfg_path
__kernel void test_convert_char8_rtp_short8(__global short8 *src,
                                            __global char8 *dest) {
  size_t i = get_global_id(0);
  dest[i] = convert_char8_rtp(src[i]);
}
