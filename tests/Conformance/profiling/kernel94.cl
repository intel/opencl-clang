// RUN: %occ-cli %s --cl-options= --cl-device=%cl_device %cfg_path
__kernel void testWriteui(__global uchar *src, write_only image2d_t dstimg) {
  int tid_x = get_global_id(0);
  int tid_y = get_global_id(1);
  int indx = tid_y * get_image_width(dstimg) + tid_x;
  uint4 color;

  indx *= 4;
  color.x = (uint)src[indx + 0];
  color.y = (uint)src[indx + 1];
  color.z = (uint)src[indx + 2];
  color.w = (uint)src[indx + 3];
  write_imageui(dstimg, (int2)(tid_x, tid_y), color);
}
