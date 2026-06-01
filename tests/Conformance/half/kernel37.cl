// RUN: %occ-cli %s --cl-options= --cl-device=%cl_device %cfg_path
__kernel void test(const __global half *p, __global float8 *f) {
  __private long2 data[8 / 8];
  __private half *hdata_p = (__private half *)data;
  __global long2 *i_p = (__global long2 *)p;
  size_t i = get_global_id(0);
  int k;
  for (k = 0; k < 8 / 8; k++)
    data[k] = i_p[i + k];
  f[i] = vloada_half8(0, hdata_p);
}
