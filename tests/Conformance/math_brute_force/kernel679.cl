// RUN: %occ-cli %s --cl-options= --cl-device=%cl_device %cfg_path
__kernel void math_kernel(__global float *out, __global float *out2,
                          __global float *in) {
  int i = get_global_id(0);
  out[i] = modf(in[i], out2 + i);
}
