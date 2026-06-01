// RUN: %occ-cli %s --cl-options= --cl-device=%cl_device %cfg_path
__kernel void sample_kernel(read_only image2d_t input, sampler_t imageSampler,
                            __global float *xOffsets, __global float *yOffsets,
                            __global uint4 *results) {
  int tidX = get_global_id(0), tidY = get_global_id(1);
  int offset = tidY * get_image_width(input) + tidX;
  float2 coords =
      (float2)((float)(xOffsets[offset]), (float)(yOffsets[offset]));
  results[offset] = read_imageui(input, imageSampler, coords);
}