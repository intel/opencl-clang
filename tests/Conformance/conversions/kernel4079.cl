// RUN: %occ-cli %s --cl-options= --cl-device=%cl_device %cfg_path
#pragma OPENCL EXTENSION cl_khr_fp64 : enable
__kernel void test_convert_double4_rtp_short4(__global short4 *src,
                                              __global double4 *dest) {
  size_t i = get_global_id(0);
  dest[i] = convert_double4_rtp(src[i]);
}
