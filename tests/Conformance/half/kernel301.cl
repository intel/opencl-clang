// RUN: %occ-cli %s --cl-options= --cl-device=%cl_device %cfg_path
__kernel void test(__global float16 *p, __global half *f) {
  __private float16 data;
  size_t i = get_global_id(0);
  data = p[i];
  vstorea_half16_rtp(data, i, f);
}
