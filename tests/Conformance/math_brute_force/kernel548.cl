// RUN: %occ-cli %s --cl-options= --cl-device=%cl_device %cfg_path
#pragma OPENCL EXTENSION cl_khr_fp64 : enable
__kernel void math_kernel16(__global double16 *out, __global double16 *in1,
                            __global int16 *in2) {
  int i = get_global_id(0);
  out[i] = ldexp(in1[i], in2[i]);
}
