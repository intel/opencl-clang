// RUN: %occ-cli %s --cl-options= --cl-device=%cl_device %cfg_path
__kernel void test_convert_ulong8_rtp_uint8(__global uint8 *src,
                                            __global ulong8 *dest) {
  size_t i = get_global_id(0);
  dest[i] = convert_ulong8_rtp(src[i]);
}
