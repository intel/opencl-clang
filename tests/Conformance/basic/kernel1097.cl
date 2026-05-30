// RUN: %occ-cli %s --cl-options= --cl-device=%cl_device %cfg_path

__kernel void test_fn(__global int16 *src, __global float16 *dst) {
  int tid = get_global_id(0);
  float16 tmp = as_float16(src[tid]);
  dst[tid] = tmp;
}
