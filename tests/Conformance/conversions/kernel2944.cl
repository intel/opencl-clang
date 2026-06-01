// RUN: %occ-cli %s --cl-options= --cl-device=%cl_device %cfg_path
__kernel void test_convert_uint4_rtp_ulong4(__global ulong4 *src,
                                            __global uint4 *dest) {
  size_t i = get_global_id(0);
  dest[i] = convert_uint4_rtp(src[i]);
}
