// RUN: %occ-cli %s --cl-options= --cl-device=%cl_device %cfg_path
__kernel void test(const __global half *p, __global float16 *f) {
  __local long4 data[2048 / 16];
  __local half *hdata_p = (__local half *)data;
  __global long4 *i_p = (__global long4 *)p;
  size_t i = get_global_id(0);
  size_t lid = get_local_id(0);
  int k;
  for (k = 0; k < 16 / 16; k++)
    data[lid * 16 / 16 + k] = i_p[i * 16 / 16 + k];
  f[i] = vload_half16(lid, hdata_p);
}
