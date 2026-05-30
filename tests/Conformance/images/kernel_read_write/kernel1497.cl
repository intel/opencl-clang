// RUN: %occ-cli %s --cl-options= --cl-device=%cl_device %cfg_path
__kernel void sample_kernel(read_only image3d_t input, sampler_t imageSampler,
                            __global float *xOffsets, __global float *yOffsets,
                            __global float *zOffsets, __global uint4 *results) {
  int tidX = get_global_id(0), tidY = get_global_id(1), tidZ = get_global_id(2);
  int offset = tidZ * get_image_width(input) * get_image_height(input) +
               tidY * get_image_width(input) + tidX;
  int4 coords = (int4)((int)xOffsets[offset], (int)yOffsets[offset],
                       (int)zOffsets[offset], 0);
  results[offset] = read_imageui(input, imageSampler, coords);
}