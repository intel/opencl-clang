// RUN: %occ-cli %s --cl-options= --cl-device=%cl_device %cfg_path
__kernel void test(__constant half *p, __global float *f,
                   uint extra_last_thread) {
  size_t i = get_global_id(0);
  size_t last_i = get_global_size(0) - 1;
  if (last_i == i && extra_last_thread != 0) {
    if (extra_last_thread == 2) {
      f[3 * i + 1] = vload_half(3 * i + 1, p);
    }
    f[3 * i] = vload_half(3 * i, p);
  } else {
    vstore3(vload_half3(i, p), i, f);
  }
}
