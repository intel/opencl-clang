// RUN: %occ-cli %s --cl-options= --cl-device=%cl_device %cfg_path
#pragma OPENCL EXTENSION cl_khr_fp64 : enable
__kernel void test_convert_double8_rtz_uint8(__global uint8 *src,
                                             __global double8 *dest) {
  size_t i = get_global_id(0);
  dest[i] = convert_double8_rtz(src[i]);
}
