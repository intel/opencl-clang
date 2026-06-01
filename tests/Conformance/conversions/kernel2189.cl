// RUN: %occ-cli %s --cl-options= --cl-device=%cl_device %cfg_path
__kernel void test_convert_short16_sat_rtn_int16(__global int16 *src,
                                                 __global short16 *dest) {
  size_t i = get_global_id(0);
  dest[i] = convert_short16_sat_rtn(src[i]);
}
