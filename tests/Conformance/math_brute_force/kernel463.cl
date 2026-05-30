// RUN: %occ-cli %s --cl-options= --cl-device=%cl_device %cfg_path
__kernel void math_kernel8(__global int8 *out, __global float8 *in1,
                           __global float8 *in2) {
  int i = get_global_id(0);
  out[i] = islessequal(in1[i], in2[i]);
}
