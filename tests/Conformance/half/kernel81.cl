// RUN: %occ-cli %s --cl-options= --cl-device=%cl_device %cfg_path
#pragma OPENCL EXTENSION cl_khr_fp64 : enable
__kernel void test(__global double *p, __global half *f,
                   uint extra_last_thread) {
  size_t i = get_global_id(0);
  size_t last_i = get_global_size(0) - 1;
  size_t adjust = 0;
  if (last_i == i && extra_last_thread != 0) {
    adjust = 3 - extra_last_thread;
  }
  vstore_half3(vload3(i, p - adjust), i, f - adjust);
}
