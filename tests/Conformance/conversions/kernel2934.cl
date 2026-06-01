// RUN: %occ-cli %s --cl-options= --cl-device=%cl_device %cfg_path
__kernel void test_convert_uint16_ulong16(__global ulong16 *src,
                                          __global uint16 *dest) {
  size_t i = get_global_id(0);
  dest[i] = convert_uint16(src[i]);
}
