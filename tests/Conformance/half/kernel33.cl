// RUN: %occ-cli %s --cl-options= --cl-device=%cl_device %cfg_path
__kernel void test(const __global half *p, __global float4 *f) {
  __private long data[4 / 4];
  __private half *hdata_p = (__private half *)data;
  __global long *i_p = (__global long *)p;
  size_t i = get_global_id(0);
  int k;
  for (k = 0; k < 4 / 4; k++)
    data[k] = i_p[i + k];
  f[i] = vloada_half4(0, hdata_p);
}
