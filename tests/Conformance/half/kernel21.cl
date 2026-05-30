// RUN: %occ-cli %s --cl-options= --cl-device=%cl_device %cfg_path
__kernel void test(const __global half *p, __global float *f,
                   uint extra_last_thread) {
  __private ushort data[3];
  __private half *hdata_p = (__private half *)data;
  __global ushort *i_p = (__global ushort *)p;
  size_t i = get_global_id(0);
  int k;
  size_t last_i = get_global_size(0) - 1;
  if (last_i == i && extra_last_thread != 0) {
    if (extra_last_thread == 2) {
      f[3 * i + 1] = vload_half(3 * i + 1, p);
    }
    f[3 * i] = vload_half(3 * i, p);
  } else {
    for (k = 0; k < 3; k++)
      data[k] = i_p[i * 3 + k];
    vstore3(vload_half3(0, hdata_p), i, f);
  }
}
