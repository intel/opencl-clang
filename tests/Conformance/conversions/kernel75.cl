// RUN: %occ-cli %s --cl-options= --cl-device=%cl_device %cfg_path
__kernel void test_convert_uchar2_rtp_char2(__global char2 *src,
                                            __global uchar2 *dest) {
  size_t i = get_global_id(0);
  dest[i] = convert_uchar2_rtp(src[i]);
}
