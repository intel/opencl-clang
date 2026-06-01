// RUN: %occ-cli %s --cl-options= --cl-device=%cl_device %cfg_path
__kernel void test_convert_char4_rtp_int4(__global int4 *src,
                                          __global char4 *dest) {
  size_t i = get_global_id(0);
  dest[i] = convert_char4_rtp(src[i]);
}
