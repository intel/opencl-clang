// RUN: %occ-cli %s --cl-options= --cl-device=%cl_device %cfg_path

__kernel void test_fn(__global uchar *src, __global char *dst) {
  int tid = get_global_id(0);
  char tmp = as_char(src[tid]);
  dst[tid] = tmp;
}
