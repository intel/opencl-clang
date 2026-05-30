// RUN: %occ-cli %s --cl-options= --cl-device=%cl_device %cfg_path

__kernel void test_fn(__global char2 *src, __global short *dst) {
  int tid = get_global_id(0);
  short tmp = as_short(src[tid]);
  dst[tid] = tmp;
}
