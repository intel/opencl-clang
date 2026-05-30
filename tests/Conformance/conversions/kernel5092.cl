// RUN: %occ-cli %s --cl-options= --cl-device=%cl_device %cfg_path
__kernel void test_convert_long_rtn_short(__global short *src,
                                          __global long *dest) {
  size_t i = get_global_id(0);
  dest[i] = convert_long_rtn(src[i]);
}
