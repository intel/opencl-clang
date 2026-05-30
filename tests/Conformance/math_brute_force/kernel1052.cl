// RUN: %occ-cli %s --cl-options= --cl-device=%cl_device %cfg_path
#pragma OPENCL EXTENSION cl_khr_fp64 : enable
__kernel void divide_kernel(__global double *out, __global double *in1,
                            __global double *in2) {
  size_t i = get_global_id(0);
  out[i] = in1[i] / in2[i];
}
