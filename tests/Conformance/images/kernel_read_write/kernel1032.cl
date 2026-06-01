// RUN: %occ-cli %s --cl-options= --cl-device=%cl_device %cfg_path
__kernel void sample_kernel(__global float4 *input,
                            write_only image2d_t output) {
  int tidX = get_global_id(0), tidY = get_global_id(1);
  int offset = tidY * get_image_width(output) + tidX;
  write_imagef(output, (int2)(tidX, tidY), input[offset]);
}