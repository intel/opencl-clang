// RUN: %occ-cli %s --cl-options= --cl-device=%cl_device %cfg_path

__kernel void test_image_dim(read_only image2d_t srcimg,
                             write_only image2d_t dstimg, sampler_t sampler) {
  int tid_x = get_global_id(0);
  int tid_y = get_global_id(1);
  float4 color;

  color = read_imagef(srcimg, sampler, (int2)(tid_x, tid_y));
  write_imagef(dstimg, (int2)(tid_x, tid_y), color);
}
