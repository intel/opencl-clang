// RUN: %occ-cli %s --cl-options= --cl-device=%cl_device %cfg_path
__kernel void subtract_kernel2(__global float2 *out, __global float2 *in1,
                               __global float2 *in2) {
  size_t i = get_global_id(0);
  out[i] = in1[i] - in2[i];
}
