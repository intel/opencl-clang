// RUN: %occ-cli %s --cl-options= --cl-device=%cl_device %cfg_path
__kernel void test_convert_ulong8_sat_rtp_uchar8(__global uchar8 *src,
                                                 __global ulong8 *dest) {
  size_t i = get_global_id(0);
  dest[i] = convert_ulong8_sat_rtp(src[i]);
}
