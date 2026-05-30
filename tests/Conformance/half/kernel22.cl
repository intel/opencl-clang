// RUN: %occ-cli %s --cl-options= --cl-device=%cl_device %cfg_path
__kernel void test(const __global half *p, __global float *f,
                   uint extra_last_thread) {
  __local ushort data[384];
  __local half *hdata_p = (__local half *)data;
  __global ushort *i_p = (__global ushort *)p;
  size_t i = get_global_id(0);
  size_t last_i = get_global_size(0) - 1;
  size_t lid = get_local_id(0);
  int k;
  if (last_i == i && extra_last_thread != 0) {
    if (extra_last_thread == 2) {
      f[3 * i + 1] = vload_half(3 * i + 1, p);
    }
    f[3 * i] = vload_half(3 * i, p);
  } else {
    for (k = 0; k < 3; k++)
      data[lid * 3 + k] = i_p[i * 3 + k];
    vstore3(vload_half3(lid, hdata_p), i, f);
  };
}
