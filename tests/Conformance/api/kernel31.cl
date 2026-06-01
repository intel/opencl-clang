// RUN: %occ-cli %s --cl-options= --cl-device=%cl_device %cfg_path
__kernel void sample_test(read_only image2d_t src,
                          __global int *outDimensions) {
  int tid = get_global_id(0), i;
  for (i = 0; i < 100000; i++)
    ;
  outDimensions[tid * 2] = get_image_width(src) * tid;
  outDimensions[tid * 2 + 1] = get_image_height(src) * tid;
}
