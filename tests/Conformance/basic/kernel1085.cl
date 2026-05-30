// RUN: %occ-cli %s --cl-options= --cl-device=%cl_device %cfg_path

__kernel void test_fn(__global int4 *src, __global long2 *dst) {
  int tid = get_global_id(0);
  long2 tmp = as_long2(src[tid]);
  dst[tid] = tmp;
}
