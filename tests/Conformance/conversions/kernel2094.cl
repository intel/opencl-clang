// RUN: %occ-cli %s --cl-options= --cl-device=%cl_device %cfg_path
__kernel void test_convert_short2_rtn_uint2(__global uint2 *src,
                                            __global short2 *dest) {
  size_t i = get_global_id(0);
  dest[i] = convert_short2_rtn(src[i]);
}
