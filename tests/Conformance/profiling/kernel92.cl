// RUN: %occ-cli %s --cl-options= --cl-device=%cl_device %cfg_path
__kernel void testWritef(__global uchar *src, write_only image2d_t dstimg) {
  int tid_x = get_global_id(0);
  int tid_y = get_global_id(1);
  int indx = tid_y * get_image_width(dstimg) + tid_x;
  float4 color;

  indx *= 4;
  color = (float4)((float)src[indx + 0], (float)src[indx + 1],
                   (float)src[indx + 2], (float)src[indx + 3]);
  color /= (float4)(255.f, 255.f, 255.f, 255.f);
  write_imagef(dstimg, (int2)(tid_x, tid_y), color);
}
