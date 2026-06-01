// RUN: %occ-cli %s --cl-options= --cl-device=%cl_device %cfg_path
__kernel void math_kernel16(__global int16 *out, __global float16 *in) {
  int i = get_global_id(0);
  out[i] = isfinite(in[i]);
}
