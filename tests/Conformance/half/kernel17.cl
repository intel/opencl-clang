// RUN: %occ-cli %s --cl-options= --cl-device=%cl_device %cfg_path
__kernel void test(const __global half *p, __global float16 *f) {
  __private long4 data[16 / 16];
  __private half *hdata_p = (__private half *)data;
  __global long4 *i_p = (__global long4 *)p;
  size_t i = get_global_id(0);
  int k;
  for (k = 0; k < 16 / 16; k++)
    data[k] = i_p[i + k];
  f[i] = vload_half16(0, hdata_p);
}
