// RUN: %occ-cli %s --cl-options= --cl-device=%cl_device %cfg_path
#pragma OPENCL EXTENSION cl_khr_fp64 : enable
__kernel void subtract_kernel8(__global double8 *out, __global double8 *in1,
                               __global double8 *in2) {
  size_t i = get_global_id(0);
  out[i] = in1[i] - in2[i];
}
