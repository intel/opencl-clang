// RUN: %occ-cli %s --cl-options= --cl-device=%cl_device %cfg_path
__kernel void test(const __global half *p, __global float4 *f) {
  __local long data[512 / 4];
  __local half *hdata_p = (__local half *)data;
  __global long *i_p = (__global long *)p;
  size_t i = get_global_id(0);
  size_t lid = get_local_id(0);
  int k;
  for (k = 0; k < 4 / 4; k++)
    data[lid * 4 / 4 + k] = i_p[i * 4 / 4 + k];
  f[i] = vloada_half4(lid, hdata_p);
}
