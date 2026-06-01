// RUN: %occ-cli %s --cl-options= --cl-device=%cl_device %cfg_path

__kernel void test_fn(__global uchar2 *src, __global char2 *dst) {
  int tid = get_global_id(0);
  char2 tmp = as_char2(src[tid]);
  dst[tid] = tmp;
}
