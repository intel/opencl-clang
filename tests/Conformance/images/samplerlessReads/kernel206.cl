// RUN: %occ-cli %s --cl-options= --cl-device=%cl_device %cfg_path
__kernel void sample_kernel(read_only image1d_array_t input, sampler_t sampler,
                            __global int *results) {
  int tidX = get_global_id(0), tidY = get_global_id(1);
  int offset = tidY * get_image_width(input) + tidX;
  int2 coords = (int2)(tidX, tidY);
  uint4 clr = read_imageui(input, coords);
  int4 test = (clr != read_imageui(input, sampler, coords));
  if (test.x || test.y || test.z || test.w)
    results[offset] = -1;
  else
    results[offset] = 0;
}