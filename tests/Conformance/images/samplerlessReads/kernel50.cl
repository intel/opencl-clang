// RUN: %occ-cli %s --cl-options= --cl-device=%cl_device %cfg_path
__kernel void sample_kernel(read_only image1d_t input, sampler_t sampler,
                            __global int *results) {
  int tidX = get_global_id(0);
  int offset = tidX;
  int4 clr = read_imagei(input, tidX);
  int4 test = (clr != read_imagei(input, sampler, tidX));
  if (test.x || test.y || test.z || test.w)
    results[offset] = -1;
  else
    results[offset] = 0;
}