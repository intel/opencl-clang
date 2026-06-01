// RUN: %occ-cli %s --cl-options= --cl-device=%cl_device %cfg_path
#pragma OPENCL EXTENSION cl_khr_fp64 : enable
__kernel void test_convert_uchar_double(__global double *src,
                                        __global uchar *dest) {
  size_t i = get_global_id(0);
  dest[i] = convert_uchar(src[i]);
}
