// RUN: %occ-cli %s --cl-options= --cl-device=%cl_device %cfg_path
__kernel void test_convert_char2_sat_rtp_ulong2(__global ulong2 *src,
                                                __global char2 *dest) {
  size_t i = get_global_id(0);
  dest[i] = convert_char2_sat_rtp(src[i]);
}
