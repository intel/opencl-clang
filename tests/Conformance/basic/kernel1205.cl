// RUN: %occ-cli %s --cl-options= --cl-device=%cl_device %cfg_path

__kernel void test_fn(__global ulong4 *src, __global long4 *dst) {
  int tid = get_global_id(0);
  long4 tmp = as_long4(src[tid]);
  dst[tid] = tmp;
}
