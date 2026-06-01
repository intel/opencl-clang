// RUN: %occ-cli %s --cl-options= --cl-device=%cl_device %cfg_path
__kernel void test_convert_ulong4_sat_rtn_ulong4(__global ulong4 *src,
                                                 __global ulong4 *dest) {
  size_t i = get_global_id(0);
  dest[i] = convert_ulong4_sat_rtn(src[i]);
}
