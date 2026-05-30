// RUN: %occ-cli %s --cl-options= --cl-device=%cl_device %cfg_path
__kernel void test_rgbaFFFF_write(__global float *src,
                                  write_only image2d_t dstimg) {
  int tid_x = get_global_id(0);
  int tid_y = get_global_id(1);
  int indx = tid_y * get_image_width(dstimg) + tid_x;
  float4 color;

  indx *= 4;
  color = (float4)(src[indx + 0], src[indx + 1], src[indx + 2], src[indx + 3]);
  write_imagef(dstimg, (int2)(tid_x, tid_y), color);
}
