// RUN: %occ-cli %s --cl-options= --cl-device=%cl_device %cfg_path
__kernel void test_convert_long2_rte_uchar2(__global uchar2 *src,
                                            __global long2 *dest) {
  size_t i = get_global_id(0);
  dest[i] = convert_long2_rte(src[i]);
}
