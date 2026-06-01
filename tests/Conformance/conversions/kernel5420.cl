// RUN: %occ-cli %s --cl-options= --cl-device=%cl_device %cfg_path
__kernel void test_convert_long16_sat_rte_ulong16(__global ulong16 *src,
                                                  __global long16 *dest) {
  size_t i = get_global_id(0);
  dest[i] = convert_long16_sat_rte(src[i]);
}
