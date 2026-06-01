// RUN: %occ-cli %s --cl-options= --cl-device=%cl_device %cfg_path
__kernel void test_image_migrate(write_only image2d_t dst,
                                 read_only image2d_t src1,
                                 read_only image2d_t src2, sampler_t sampler,
                                 uint x) {
  int tidX = get_global_id(0), tidY = get_global_id(1);
  int2 coords = (int2){tidX, tidY};
  uint4 val = read_imageui(src1, sampler, coords) ^
              read_imageui(src2, sampler, coords) ^ x;
  write_imageui(dst, coords, val);
}
