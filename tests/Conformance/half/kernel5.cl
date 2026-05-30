// RUN: %occ-cli %s --cl-options= --cl-device=%cl_device %cfg_path
__kernel void test(const __global half *p, __global float2 *f) {
  __private int data[2 / 2];
  __private half *hdata_p = (__private half *)data;
  __global int *i_p = (__global int *)p;
  size_t i = get_global_id(0);
  int k;
  for (k = 0; k < 2 / 2; k++)
    data[k] = i_p[i + k];
  f[i] = vload_half2(0, hdata_p);
}
