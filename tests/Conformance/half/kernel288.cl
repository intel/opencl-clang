// RUN: %occ-cli %s --cl-options= --cl-device=%cl_device %cfg_path
__kernel void test(__global float4 *p, __global half *f) {
  size_t i = get_global_id(0);
  vstorea_half4_rtp(p[i], i, f);
}
