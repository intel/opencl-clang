// RUN: %occ-cli %s --cl-options= --cl-device=%cl_device %cfg_path
__kernel void test_convert_ulong4_sat_ushort4(__global ushort4 *src,
                                              __global ulong4 *dest) {
  size_t i = get_global_id(0);
  dest[i] = convert_ulong4_sat(src[i]);
}
