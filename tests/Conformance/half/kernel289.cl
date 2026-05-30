// RUN: %occ-cli %s --cl-options= --cl-device=%cl_device %cfg_path
__kernel void test(__global float4 *p, __global half *f) {
  __private float4 data;
  size_t i = get_global_id(0);
  data = p[i];
  vstorea_half4_rtp(data, i, f);
}
