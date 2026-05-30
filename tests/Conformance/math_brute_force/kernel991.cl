// RUN: %occ-cli %s --cl-options= --cl-device=%cl_device %cfg_path
__kernel void math_kernel(__global float *out, __global float *in1,
                          __global float *in2) {
  int i = get_global_id(0);
  out[i] = half_powr(in1[i], in2[i]);
}
