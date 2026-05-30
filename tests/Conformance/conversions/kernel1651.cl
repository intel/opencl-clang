// RUN: %occ-cli %s --cl-options= --cl-device=%cl_device %cfg_path
#pragma OPENCL EXTENSION cl_khr_fp64 : enable
__kernel void test_convert_ushort4_double4(__global double4 *src,
                                           __global ushort4 *dest) {
  size_t i = get_global_id(0);
  dest[i] = convert_ushort4(src[i]);
}
