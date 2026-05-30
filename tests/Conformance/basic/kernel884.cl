// RUN: %occ-cli %s --cl-options= --cl-device=%cl_device %cfg_path
__kernel void test_fn(read_only image2d_t srcimg, sampler_t sampler,
                      __global float4 *results) {
  int tid_x = get_global_id(0);
  int tid_y = get_global_id(1);
  results[tid_y * get_image_width(srcimg) + tid_x] =
      read_imagef(srcimg, sampler, (int2)(tid_x, tid_y));
}
