// RUN: %occ-cli %s --cl-options= --cl-device=%cl_device %cfg_path
__kernel void TestFunction(read_only image2d_t planeIn,
                           write_only image2d_t planeOut, sampler_t sampler,
                           __global int *planeRes) {
  int w = get_global_id(0);
  int h = get_global_id(1);
  int width = get_image_width(planeIn);
  int height = get_image_height(planeOut);
  float4 color0 = read_imagef(planeIn, sampler, (int2)(w, h));
  float4 color1 = read_imagef(planeIn, sampler, (float2)(w, h));
  float4 outputColor =
      (color0 == color1) ? (color0 + 0.2f) : (float4)(0.5, 0.5, 0.5, 0.5);
  write_imagef(planeOut, (int2)(w, h), outputColor);
  if (w == 0 && h == 0) {
    planeRes[0] = width;
    planeRes[1] = height;
  }
}