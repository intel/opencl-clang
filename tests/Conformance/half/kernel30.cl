// RUN: %occ-cli %s --cl-options= --cl-device=%cl_device %cfg_path
__kernel void test(const __global half *p, __global float2 *f) {
  __local int data[256 / 2];
  __local half *hdata_p = (__local half *)data;
  __global int *i_p = (__global int *)p;
  size_t i = get_global_id(0);
  size_t lid = get_local_id(0);
  int k;
  for (k = 0; k < 2 / 2; k++)
    data[lid * 2 / 2 + k] = i_p[i * 2 / 2 + k];
  f[i] = vloada_half2(lid, hdata_p);
}
