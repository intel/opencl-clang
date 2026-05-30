// RUN: %occ-cli %s --cl-options= --cl-device=%cl_device %cfg_path
__kernel void
test_multireadimage(int n, int m, sampler_t sampler, read_only image2d_t img0,
                    read_only image2d_t img1, read_only image2d_t img2,
                    read_only image2d_t img3, read_only image2d_t img4,
                    read_only image2d_t img5, read_only image2d_t img6,
                    __global float4 *dst) {
  int tid_x = get_global_id(0);
  int tid_y = get_global_id(1);
  int2 tid = (int2)(tid_x, tid_y);
  int indx = tid_y * get_image_width(img5) + tid_x;
  float4 sum;

  sum = read_imagef(img0, sampler, tid);
  sum += read_imagef(img1, sampler, tid);
  sum += read_imagef(img2, sampler, tid);
  sum += read_imagef(img3, sampler, tid);
  sum += read_imagef(img4, sampler, tid);
  sum += read_imagef(img5, sampler, tid);
  sum += read_imagef(img6, sampler, tid);

  dst[indx] = sum;
}
