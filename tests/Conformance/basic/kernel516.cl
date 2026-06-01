// RUN: %occ-cli %s --cl-options= --cl-device=%cl_device %cfg_path
__kernel void test_multireadimage(read_only image2d_t img0,
                                  read_only image2d_t img1,
                                  read_only image2d_t img2,
                                  __global float4 *dst, sampler_t sampler) {
  int tid_x = get_global_id(0);
  int tid_y = get_global_id(1);
  int2 tid = (int2)(tid_x, tid_y);
  int indx = tid_y * get_image_width(img1) + tid_x;
  float4 sum;

  sum = read_imagef(img0, sampler, tid);
  sum += read_imagef(img1, sampler, tid);
  sum += read_imagef(img2, sampler, tid);

  dst[indx] = sum;
}
