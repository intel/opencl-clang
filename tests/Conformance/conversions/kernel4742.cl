// RUN: %occ-cli %s --cl-options= --cl-device=%cl_device %cfg_path
#pragma OPENCL EXTENSION cl_khr_fp64 : enable
__kernel void test_convert_ulong8_sat_double8(__global double8 *src,
                                              __global ulong8 *dest) {
  size_t i = get_global_id(0);
  dest[i] = convert_ulong8_sat(src[i]);
}
