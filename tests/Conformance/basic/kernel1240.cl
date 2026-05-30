// RUN: %occ-cli %s --cl-options= --cl-device=%cl_device %cfg_path

__kernel void test_fn(__global float8 *src, __global int8 *dst) {
  int tid = get_global_id(0);
  int8 tmp = as_int8(src[tid]);
  dst[tid] = tmp;
}
