// RUN: %occ-cli %s --cl-options= --cl-device=%cl_device %cfg_path
#pragma OPENCL EXTENSION cl_khr_fp64 : enable
__kernel void test_convert_uint8_rtn_double8(__global double8 *src,
                                             __global uint8 *dest) {
  size_t i = get_global_id(0);
  dest[i] = convert_uint8_rtn(src[i]);
}
