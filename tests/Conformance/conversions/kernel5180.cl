// RUN: %occ-cli %s --cl-options= --cl-device=%cl_device %cfg_path
__kernel void test_convert_long4_sat_rtp_uint4(__global uint4 *src,
                                               __global long4 *dest) {
  size_t i = get_global_id(0);
  dest[i] = convert_long4_sat_rtp(src[i]);
}
