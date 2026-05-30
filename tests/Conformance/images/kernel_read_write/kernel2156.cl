// RUN: %occ-cli %s --cl-options= --cl-device=%cl_device %cfg_path
__kernel void sample_kernel(read_only image2d_array_t input,
                            sampler_t imageSampler, __global float *xOffsets,
                            __global float *yOffsets, __global float *zOffsets,
                            __global float4 *results) {
  int tidX = get_global_id(0), tidY = get_global_id(1), tidZ = get_global_id(2);
  int offset = tidZ * get_image_width(input) * get_image_height(input) +
               tidY * get_image_width(input) + tidX;
  float4 coords =
      (float4)(xOffsets[offset], yOffsets[offset], zOffsets[offset], 0.0f);
  results[offset] = read_imagef(input, imageSampler, coords);
}