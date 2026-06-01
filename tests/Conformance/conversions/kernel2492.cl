// RUN: %occ-cli %s --cl-options= --cl-device=%cl_device %cfg_path
__kernel void test_convert_uint4_sat_rtn_uchar4(__global uchar4 *src,
                                                __global uint4 *dest) {
  size_t i = get_global_id(0);
  dest[i] = convert_uint4_sat_rtn(src[i]);
}
