// RUN: %occ-cli %s --cl-options= --cl-device=%cl_device %cfg_path
__kernel void test_convert_int4_rte_short4(__global short4 *src,
                                           __global int4 *dest) {
  size_t i = get_global_id(0);
  dest[i] = convert_int4_rte(src[i]);
}
