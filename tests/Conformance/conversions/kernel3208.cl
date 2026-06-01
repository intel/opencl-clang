// RUN: %occ-cli %s --cl-options= --cl-device=%cl_device %cfg_path
__kernel void test_convert_int16_sat_ushort16(__global ushort16 *src,
                                              __global int16 *dest) {
  size_t i = get_global_id(0);
  dest[i] = convert_int16_sat(src[i]);
}
