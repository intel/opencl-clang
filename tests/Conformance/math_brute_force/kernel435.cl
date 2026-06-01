// RUN: %occ-cli %s --cl-options= --cl-device=%cl_device %cfg_path
__kernel void math_kernel(__global int *out, __global float *in) {
  int i = get_global_id(0);
  out[i] = isinf(in[i]);
}
