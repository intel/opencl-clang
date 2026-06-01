// RUN: %occ-cli %s --cl-options= --cl-device=%cl_device %cfg_path
__kernel void math_kernel4(__global float4 *out, __global float4 *in1,
                           __global float4 *in2) {
  int i = get_global_id(0);
  out[i] = maxmag(in1[i], in2[i]);
}
