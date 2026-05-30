// RUN: %occ-cli %s --cl-options= --cl-device=%cl_device %cfg_path
__kernel void test_convert_uint_rtp_short(__global short *src,
                                          __global uint *dest) {
  size_t i = get_global_id(0);
  dest[i] = convert_uint_rtp(src[i]);
}
