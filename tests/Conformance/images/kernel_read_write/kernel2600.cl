// RUN: %occ-cli %s --cl-options= --cl-device=%cl_device %cfg_path
__kernel void sample_kernel(__global float4 *input,
                            write_only image2d_array_t output) {
  int tidX = get_global_id(0), tidY = get_global_id(1), tidZ = get_global_id(2);
  int offset = tidZ * get_image_width(output) * get_image_height(output) +
               tidY * get_image_width(output) + tidX;
  write_imagef(output, (int4)(tidX, tidY, tidZ, 0), input[offset]);
}