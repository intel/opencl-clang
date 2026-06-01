// RUN: %occ-cli %s --cl-options= --cl-device=%cl_device %cfg_path
__kernel void test(__global float3 *p, __global half *f) {
  size_t i = get_global_id(0);
  vstorea_half3_rtz(p[i], i, f);
  vstore_half_rtz(((__global float *)p)[4 * i + 3], 4 * i + 3, f);
}
