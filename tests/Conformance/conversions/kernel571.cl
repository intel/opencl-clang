// RUN: %occ-cli %s --cl-options= --cl-device=%cl_device %cfg_path
__kernel void test_convert_uchar4_rtn_long4(__global long4 *src,
                                            __global uchar4 *dest) {
  size_t i = get_global_id(0);
  dest[i] = convert_uchar4_rtn(src[i]);
}
