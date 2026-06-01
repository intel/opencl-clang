// RUN: %occ-cli %s --cl-options= --cl-device=%cl_device %cfg_path
#pragma OPENCL EXTENSION cl_khr_fp64 : enable
__kernel void test_convert_ushort_rtn_double(__global double *src,
                                             __global ushort *dest) {
  size_t i = get_global_id(0);
  dest[i] = convert_ushort_rtn(src[i]);
}
