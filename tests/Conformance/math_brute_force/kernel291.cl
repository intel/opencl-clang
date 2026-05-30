// RUN: %occ-cli %s --cl-options= --cl-device=%cl_device %cfg_path
__kernel void math_kernel2(__global float2 *out, __global float2 *in1,
                           __global float2 *in2, __global float2 *in3) {
  int i = get_global_id(0);
  out[i] = fma(in1[i], in2[i], in3[i]);
}
