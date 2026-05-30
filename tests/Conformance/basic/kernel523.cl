// RUN: %occ-cli %s --cl-options= --cl-device=%cl_device %cfg_path
__kernel void test_rgba16(read_only image3d_t srcimg, __global ushort4 *dst,
                          sampler_t sampler) {
  int tid_x = get_global_id(0);
  int tid_y = get_global_id(1);
  int tid_z = get_global_id(2);
  int indx =
      (tid_z * get_image_height(srcimg) + tid_y) * get_image_width(srcimg) +
      tid_x;
  float4 color;

  color = read_imagef(srcimg, sampler, (int4)(tid_x, tid_y, tid_z, 0));
  ushort4 dst_write;
  dst_write.x = convert_ushort_rte(color.x * 65535.0f);
  dst_write.y = convert_ushort_rte(color.y * 65535.0f);
  dst_write.z = convert_ushort_rte(color.z * 65535.0f);
  dst_write.w = convert_ushort_rte(color.w * 65535.0f);
  dst[indx] = dst_write;
}
