// RUN: %occ-cli %s --cl-options= --cl-device=%cl_device %cfg_path
__kernel void math_kernel16(__global float16 *out, __global float16 *in) {
  int i = get_global_id(0);
  out[i] = exp2(in[i]);
}
