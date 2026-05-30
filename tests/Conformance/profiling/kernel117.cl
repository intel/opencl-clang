// RUN: %occ-cli %s --cl-options= --cl-device=%cl_device %cfg_path
constant sampler_t sampler = CLK_ADDRESS_CLAMP_TO_EDGE | CLK_FILTER_NEAREST;

__kernel void image_filter(int n, int m, __global float *filter_weights,
                           read_only image2d_t src_image,
                           write_only image2d_t dst_image) {
  int i, j;
  int indx = 0;
  int tid_x = get_global_id(0);
  int tid_y = get_global_id(1);
  float4 filter_result = (float4)(0.f, 0.f, 0.f, 0.f);

  for (i = -m / 2; i < (m + 1) / 2; i++) {
    for (j = -n / 2; j < (n + 1) / 2; j++) {
      float w = filter_weights[indx++];

      if (w != 0.0f) {
        filter_result +=
            w * read_imagef(src_image, sampler, (int2)(tid_x + j, tid_y + i));
      }
    }
  }

  write_imagef(dst_image, (int2)(tid_x, tid_y), filter_result);
}
