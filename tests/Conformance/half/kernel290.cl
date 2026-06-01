// RUN: %occ-cli %s --cl-options= --cl-device=%cl_device %cfg_path
__kernel void test(__global float4 *p, __global half *f) {
  __local float4 data[128];
  size_t i = get_global_id(0);
  size_t lid = get_local_id(0);
  data[lid] = p[i];
  vstorea_half4_rtp(data[lid], i, f);
}
