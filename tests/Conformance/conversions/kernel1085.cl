// RUN: %occ-cli %s --cl-options= --cl-device=%cl_device %cfg_path
#pragma OPENCL EXTENSION cl_khr_fp64 : enable
__kernel void test_convert_char16_sat_rtp_double16(__global double16 *src,
                                                   __global char16 *dest) {
  size_t i = get_global_id(0);
  dest[i] = convert_char16_sat_rtp(src[i]);
}
