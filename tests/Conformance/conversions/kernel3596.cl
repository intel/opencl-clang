// RUN: %occ-cli %s --cl-options= --cl-device=%cl_device %cfg_path
__kernel void test_convert_int4_sat_rtz_ulong4(__global ulong4 *src,
                                               __global int4 *dest) {
  size_t i = get_global_id(0);
  dest[i] = convert_int4_sat_rtz(src[i]);
}
