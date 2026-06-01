// RUN: %occ-cli %s --cl-options= --cl-device=%cl_device %cfg_path
__kernel void test(__global float8 *p, __global half *f) {
  __private float8 data;
  size_t i = get_global_id(0);
  data = p[i];
  vstorea_half8_rtp(data, i, f);
}
