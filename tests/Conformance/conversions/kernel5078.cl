// RUN: %occ-cli %s --cl-options= --cl-device=%cl_device %cfg_path
__kernel void test_convert_long8_short8(__global short8 *src,
                                        __global long8 *dest) {
  size_t i = get_global_id(0);
  dest[i] = convert_long8(src[i]);
}
