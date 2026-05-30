// RUN: %occ-cli %s --cl-options= --cl-device=%cl_device %cfg_path

__kernel void test_fn(__global char *src, __global uchar *dst) {
  int tid = get_global_id(0);
  uchar tmp = as_uchar(src[tid]);
  dst[tid] = tmp;
}
