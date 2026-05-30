// RUN: %occ-cli %s --cl-options= --cl-device=%cl_device %cfg_path
__kernel void test(__global float3 *p, __global half *f) {
  __private float3 data;
  size_t i = get_global_id(0);
  data = p[i];
  vstorea_half3_rtz(data, i, f);
  vstore_half_rtz(((__global float *)p)[4 * i + 3], 4 * i + 3, f);
}
