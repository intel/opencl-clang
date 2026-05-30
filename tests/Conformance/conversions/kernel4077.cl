// RUN: %occ-cli %s --cl-options= --cl-device=%cl_device %cfg_path
#pragma OPENCL EXTENSION cl_khr_fp64 : enable
__kernel void test_convert_double2_rtp_short2(__global short2 *src,
                                              __global double2 *dest) {
  size_t i = get_global_id(0);
  dest[i] = convert_double2_rtp(src[i]);
}
