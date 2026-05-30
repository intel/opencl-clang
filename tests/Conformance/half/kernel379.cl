// RUN: %occ-cli %s --cl-options= --cl-device=%cl_device %cfg_path
#pragma OPENCL EXTENSION cl_khr_fp64 : enable
__kernel void test(const __global half *in, __global half *out) {
  size_t i = get_global_id(0);
  vstore_half(convert_double(vload_half(i, in)), i, out);
}
