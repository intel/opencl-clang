// RUN: %occ-cli %s --cl-options= --cl-device=%cl_device %cfg_path
__kernel void testReadf(read_only image2d_t srcimg, __global float4 *dst) {
  int tid_x = get_global_id(0);
  int tid_y = get_global_id(1);
  int indx = tid_y * get_image_width(srcimg) + tid_x;
  float4 color;

  const sampler_t sampler = CLK_ADDRESS_CLAMP_TO_EDGE | CLK_FILTER_NEAREST |
                            CLK_NORMALIZED_COORDS_FALSE;
  color = read_imagef(srcimg, sampler, (int2)(tid_x, tid_y));
  dst[indx].x = color.x;
  dst[indx].y = color.y;
  dst[indx].z = color.z;
  dst[indx].w = color.w;
}
