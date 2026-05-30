// RUN: %occ-cli %s --cl-options= --cl-device=%cl_device %cfg_path
__kernel void test(__global float *p, __global half *f,
                   uint extra_last_thread) {
  __private ushort data[4];
  size_t i = get_global_id(0);
  size_t last_i = get_global_size(0) - 1;
  size_t adjust = 0;
  size_t offset = 0;
  if (last_i == i && extra_last_thread != 0) {
    adjust = 3 - extra_last_thread;
  }
  vstore_half3_rte(vload3(i, p - adjust), 0, (__private half *)(&data[0]));
  for (offset = 0; offset < 3; offset++) {
    vstore_half(vload_half(offset, (__private half *)data), 0,
                &f[3 * i + offset - adjust]);
  }
}
