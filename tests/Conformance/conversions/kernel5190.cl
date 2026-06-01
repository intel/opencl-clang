// RUN: %occ-cli %s --cl-options= --cl-device=%cl_device %cfg_path
__kernel void test_convert_long2_sat_rtz_uint2(__global uint2 *src,
                                               __global long2 *dest) {
  size_t i = get_global_id(0);
  dest[i] = convert_long2_sat_rtz(src[i]);
}
