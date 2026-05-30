// RUN: %occ-cli %s --cl-options= --cl-device=%cl_device %cfg_path
#pragma OPENCL EXTENSION cl_khr_fp64 : enable
__kernel void math_kernel4(__global long4 *out, __global double4 *in) {
  int i = get_global_id(0);
  out[i] = isinf(in[i]);
}
