// RUN: %occ-cli %s --cl-options= --cl-device=%cl_device %cfg_path
__kernel void math_kernel8(__global float8 *out, __global float8 *in) {
  int i = get_global_id(0);
  out[i] = fabs(in[i]);
}
