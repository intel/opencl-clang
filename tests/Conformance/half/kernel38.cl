// RUN: %occ-cli %s --cl-options= --cl-device=%cl_device %cfg_path
__kernel void test(const __global half *p, __global float8 *f) {
  __local long2 data[1024 / 8];
  __local half *hdata_p = (__local half *)data;
  __global long2 *i_p = (__global long2 *)p;
  size_t i = get_global_id(0);
  size_t lid = get_local_id(0);
  int k;
  for (k = 0; k < 8 / 8; k++)
    data[lid * 8 / 8 + k] = i_p[i * 8 / 8 + k];
  f[i] = vloada_half8(lid, hdata_p);
}
