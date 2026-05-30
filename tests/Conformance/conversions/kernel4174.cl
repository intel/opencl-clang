// RUN: %occ-cli %s --cl-options= --cl-device=%cl_device %cfg_path
#pragma OPENCL EXTENSION cl_khr_fp64 : enable
__kernel void test_convert_double16_rtp_float16(__global float16 *src,
                                                __global double16 *dest) {
  size_t i = get_global_id(0);
  dest[i] = convert_double16_rtp(src[i]);
}
