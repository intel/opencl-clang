// RUN: %occ-cli %s --cl-options= --cl-device=%cl_device %cfg_path
__kernel void test_convert_short4_rtn_ushort4(__global ushort4 *src,
                                              __global short4 *dest) {
  size_t i = get_global_id(0);
  dest[i] = convert_short4_rtn(src[i]);
}
