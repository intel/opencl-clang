// RUN: %occ-cli %s --cl-options= --cl-device=%cl_device %cfg_path
__kernel void math_kernel(__global float *out, __global uint *in) {
  int i = get_global_id(0);
  out[i] = nan(in[i]);
}
