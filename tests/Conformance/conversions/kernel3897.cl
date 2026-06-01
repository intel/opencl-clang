// RUN: %occ-cli %s --cl-options= --cl-device=%cl_device %cfg_path
#pragma OPENCL EXTENSION cl_khr_fp64 : enable
__kernel void test_convert_float2_rtn_double2(__global double2 *src,
                                              __global float2 *dest) {
  size_t i = get_global_id(0);
  dest[i] = convert_float2_rtn(src[i]);
}
