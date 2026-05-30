// RUN: %occ-cli %s --cl-options= --cl-device=%cl_device %cfg_path
__kernel void test_convert_ushort16_rtn_uint16(__global uint16 *src,
                                               __global ushort16 *dest) {
  size_t i = get_global_id(0);
  dest[i] = convert_ushort16_rtn(src[i]);
}
