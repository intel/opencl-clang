// RUN: %occ-cli %s --cl-options= --cl-device=%cl_device %cfg_path
#pragma OPENCL EXTENSION cl_khr_fp64 : enable
__kernel void test(const __global half *in, __global half *out) {
  size_t i = get_global_id(0);
  vstore_half8(convert_double8(vload_half8(i, in)), i, out);
}
