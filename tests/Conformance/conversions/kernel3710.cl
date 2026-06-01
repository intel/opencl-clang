// RUN: %occ-cli %s --cl-options= --cl-device=%cl_device %cfg_path
__kernel void test_convert_float_rtn_char(__global char *src,
                                          __global float *dest) {
  size_t i = get_global_id(0);
  dest[i] = convert_float_rtn(src[i]);
}
