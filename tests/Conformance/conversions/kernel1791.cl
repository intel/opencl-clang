// RUN: %occ-cli %s --cl-options= --cl-device=%cl_device %cfg_path
__kernel void test_convert_ushort4_rtn_long4(__global long4 *src,
                                             __global ushort4 *dest) {
  size_t i = get_global_id(0);
  dest[i] = convert_ushort4_rtn(src[i]);
}
