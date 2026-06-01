// RUN: %occ-cli %s --cl-options= --cl-device=%cl_device %cfg_path
__kernel void sample_kernel(__global int4 *input, write_only image1d_t output) {
  int tidX = get_global_id(0);
  int offset = tidX;
  write_imagei(output, tidX, input[offset]);
}