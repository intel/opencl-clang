// RUN: %occ-cli %s --cl-options= --cl-device=%cl_device %cfg_path
__kernel void test_convert_ulong4_sat_rte_int4(__global int4 *src,
                                               __global ulong4 *dest) {
  size_t i = get_global_id(0);
  dest[i] = convert_ulong4_sat_rte(src[i]);
}
