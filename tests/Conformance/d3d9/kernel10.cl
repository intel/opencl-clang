// RUN: %occ-cli %s --cl-options= --cl-device=%cl_device %cfg_path
__kernel void TestFunction(read_only image2d_t imageIn,
                           write_only image2d_t imageOut, sampler_t sampler,
                           __global int *imageRes) {
  int w = get_global_id(0);
  int h = get_global_id(1);
  int width = get_image_width(imageIn);
  int height = get_image_height(imageOut);
  float4 color0 = read_imagef(imageIn, sampler, (int2)(w, h)) - 0.2f;
  float4 color1 = read_imagef(imageIn, sampler, (float2)(w, h)) - 0.2f;
  color0 = (color0 == color1) ? color0 : (float4)(0.5, 0.5, 0.5, 0.5);
  write_imagef(imageOut, (int2)(w, h), color0);
  if (w == 0 && h == 0) {
    imageRes[0] = width;
    imageRes[1] = height;
  }
}