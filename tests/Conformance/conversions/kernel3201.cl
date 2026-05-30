// RUN: %occ-cli %s --cl-options= --cl-device=%cl_device %cfg_path
__kernel void test_convert_int8_rtz_ushort8(__global ushort8 *src,
                                            __global int8 *dest) {
  size_t i = get_global_id(0);
  dest[i] = convert_int8_rtz(src[i]);
}
