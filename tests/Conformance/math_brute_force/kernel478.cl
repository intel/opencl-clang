// RUN: %occ-cli %s --cl-options= --cl-device=%cl_device %cfg_path
#pragma OPENCL EXTENSION cl_khr_fp64 : enable
__kernel void math_kernel(__global long *out, __global double *in1,
                          __global double *in2) {
  int i = get_global_id(0);
  out[i] = islessgreater(in1[i], in2[i]);
}
