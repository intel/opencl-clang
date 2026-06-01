// RUN: %occ-cli %s --cl-options= --cl-device=%cl_device %cfg_path
__kernel void sample_kernel(read_only image1d_t input, sampler_t imageSampler,
                            __global float *xOffsets, __global uint4 *results) {
  int tidX = get_global_id(0);
  int offset = tidX;
  int coord = xOffsets[offset];
  results[offset] = read_imageui(input, imageSampler, coord);
}