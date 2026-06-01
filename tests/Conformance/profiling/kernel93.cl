// RUN: %occ-cli %s --cl-options= --cl-device=%cl_device %cfg_path
__kernel void testWritei(__global char *src, write_only image2d_t dstimg) {
  int tid_x = get_global_id(0);
  int tid_y = get_global_id(1);
  int indx = tid_y * get_image_width(dstimg) + tid_x;
  int4 color;

  indx *= 4;
  color.x = (int)src[indx + 0];
  color.y = (int)src[indx + 1];
  color.z = (int)src[indx + 2];
  color.w = (int)src[indx + 3];
  write_imagei(dstimg, (int2)(tid_x, tid_y), color);
}
