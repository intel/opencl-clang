// RUN: %occ-cli %s --cl-options= --cl-device=%cl_device %cfg_path
__kernel void test_convert_long8_rtp_float8(__global float8 *src,
                                            __global long8 *dest) {
  size_t i = get_global_id(0);
  dest[i] = convert_long8_rtp(src[i]);
}
