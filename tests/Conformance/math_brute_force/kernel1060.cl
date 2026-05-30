// RUN: %occ-cli %s --cl-options= --cl-device=%cl_device %cfg_path
__kernel void multiply_kernel(__global float *out, __global float *in1,
                              __global float *in2) {
  size_t i = get_global_id(0);
  out[i] = in1[i] * in2[i];
}
