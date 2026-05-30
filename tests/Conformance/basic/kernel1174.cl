// RUN: %occ-cli %s --cl-options= --cl-device=%cl_device %cfg_path

__kernel void test_fn(__global long4 *src, __global float8 *dst) {
  int tid = get_global_id(0);
  float8 tmp = as_float8(src[tid]);
  dst[tid] = tmp;
}
