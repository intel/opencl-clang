// RUN: %occ-cli %s --cl-options= --cl-device=%cl_device %cfg_path
__kernel void test_convert_char8_rte_uchar8(__global uchar8 *src,
                                            __global char8 *dest) {
  size_t i = get_global_id(0);
  dest[i] = convert_char8_rte(src[i]);
}
