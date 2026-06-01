// RUN: %occ-cli %s --cl-options= --cl-device=%cl_device %cfg_path
#pragma OPENCL EXTENSION cl_khr_fp64 : enable
__kernel void math_kernel16(__global double16 *out, __global int16 *out2,
                            __global double16 *in) {
  int i = get_global_id(0);
  out[i] = frexp(in[i], out2 + i);
}
