// RUN: %occ-cli %s --cl-options= --cl-device=%cl_device %cfg_path
__kernel void test_convert_int2_sat_rtz_float2(__global float2 *src,
                                               __global int2 *dest) {
  size_t i = get_global_id(0);
  dest[i] = convert_int2_sat_rtz(src[i]);
}
