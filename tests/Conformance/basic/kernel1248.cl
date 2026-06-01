// RUN: %occ-cli %s --cl-options= --cl-device=%cl_device %cfg_path

__kernel void test_fn(__global float8 *src, __global uint8 *dst) {
  int tid = get_global_id(0);
  uint8 tmp = as_uint8(src[tid]);
  dst[tid] = tmp;
}
