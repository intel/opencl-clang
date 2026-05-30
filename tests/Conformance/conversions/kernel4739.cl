// RUN: %occ-cli %s --cl-options= --cl-device=%cl_device %cfg_path
#pragma OPENCL EXTENSION cl_khr_fp64 : enable
__kernel void test_convert_ulong2_sat_double2(__global double2 *src,
                                              __global ulong2 *dest) {
  size_t i = get_global_id(0);
  dest[i] = convert_ulong2_sat(src[i]);
}
