// RUN: %occ-cli %s --cl-options= --cl-device=%cl_device %cfg_path
__kernel void math_kernel2(__global float2 *out, __global float2 *in) {
  int i = get_global_id(0);
  out[i] = log2(in[i]);
}
