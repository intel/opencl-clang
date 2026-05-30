// RUN: %occ-cli %s --cl-options= --cl-device=%cl_device %cfg_path
__kernel void test_convert_uchar8_rte_long8(__global long8 *src,
                                            __global uchar8 *dest) {
  size_t i = get_global_id(0);
  dest[i] = convert_uchar8_rte(src[i]);
}
