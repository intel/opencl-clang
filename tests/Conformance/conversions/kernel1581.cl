// RUN: %occ-cli %s --cl-options= --cl-device=%cl_device %cfg_path
__kernel void test_convert_ushort2_sat_rtz_int2(__global int2 *src,
                                                __global ushort2 *dest) {
  size_t i = get_global_id(0);
  dest[i] = convert_ushort2_sat_rtz(src[i]);
}
