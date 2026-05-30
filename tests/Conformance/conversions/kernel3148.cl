// RUN: %occ-cli %s --cl-options= --cl-device=%cl_device %cfg_path
__kernel void test_convert_int_sat_rte_char(__global char *src,
                                            __global int *dest) {
  size_t i = get_global_id(0);
  dest[i] = convert_int_sat_rte(src[i]);
}
