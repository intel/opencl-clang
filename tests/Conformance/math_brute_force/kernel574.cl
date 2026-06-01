// RUN: %occ-cli %s --cl-options= --cl-device=%cl_device %cfg_path
#pragma OPENCL EXTENSION cl_khr_fp64 : enable
__kernel void math_kernel4(__global double4 *out, __global int4 *out2,
                           __global double4 *in) {
  int i = get_global_id(0);
  out[i] = lgamma_r(in[i], out2 + i);
}
