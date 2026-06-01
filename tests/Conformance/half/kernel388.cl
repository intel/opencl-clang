// RUN: %occ-cli %s --cl-options= --cl-device=%cl_device %cfg_path
__kernel void test(const __global half *in, __global half *out,
                   uint extra_last_thread) {
  size_t i = get_global_id(0);
  size_t last_i = get_global_size(0) - 1;
  size_t adjust = 0;
  if (i == last_i && extra_last_thread != 0) {
    adjust = 3 - extra_last_thread;
  }
  vstore_half3(vload_half3(i, in - adjust), i, out - adjust);
}
