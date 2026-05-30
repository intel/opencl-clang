// RUN: %occ-cli %s --cl-options= --cl-device=%cl_device %cfg_path

__kernel void test_fn(__global int2 *src, __global char8 *dst) {
  int tid = get_global_id(0);
  char8 tmp = as_char8(src[tid]);
  dst[tid] = tmp;
}
