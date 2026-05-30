// RUN: %occ-cli %s --cl-options= --cl-device=%cl_device %cfg_path

__kernel void image_sum(read_only image2d_t srcimg0,
                        read_only image2d_t srcimg1,
                        write_only image2d_t dstimg, sampler_t sampler) {
  int tid_x = get_global_id(0);
  int tid_y = get_global_id(1);
  float4 color0;
  float4 color1;

  color0 = read_imagef(srcimg0, sampler, (float2)((float)tid_x, (float)tid_y));
  color1 = read_imagef(srcimg1, sampler, (float2)((float)tid_x, (float)tid_y));
  write_imagef(dstimg, (int2)(tid_x, tid_y), color0 + color1);
}
