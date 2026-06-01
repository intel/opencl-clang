// RUN: %occ-cli %s --cl-options= --cl-device=%cl_device %cfg_path
__kernel void test_convert_short_sat_rte_float(__global float *src,
                                               __global short *dest) {
  size_t i = get_global_id(0);
  dest[i] = convert_short_sat_rte(src[i]);
}
