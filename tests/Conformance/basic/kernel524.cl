// RUN: %occ-cli %s --cl-options= --cl-device=%cl_device %cfg_path
__kernel void test_rgbaFFFF(read_only image3d_t srcimg, __global float *dst,
                            sampler_t sampler) {
  int tid_x = get_global_id(0);
  int tid_y = get_global_id(1);
  int tid_z = get_global_id(2);
  int indx =
      (tid_z * get_image_height(srcimg) + tid_y) * get_image_width(srcimg) +
      tid_x;
  float4 color;

  color = read_imagef(srcimg, sampler, (int4)(tid_x, tid_y, tid_z, 0));
  indx *= 4;
  dst[indx + 0] = color.x;
  dst[indx + 1] = color.y;
  dst[indx + 2] = color.z;
  dst[indx + 3] = color.w;
}
