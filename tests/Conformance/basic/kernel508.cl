// RUN: %occ-cli %s --cl-options= --cl-device=%cl_device %cfg_path

__kernel void test_rgba8888(read_only image2d_t srcimg, __global uchar4 *dst,
                            sampler_t sampler) {
  int tid_x = get_global_id(0);
  int tid_y = get_global_id(1);
  int indx = tid_y * get_image_width(srcimg) + tid_x;
  float4 color;

  color = read_imagef(srcimg, sampler, (int2)(tid_x, tid_y)) * 255.0f;
  dst[indx] = convert_uchar4_rte(color);
}
