// RUN: %occ-cli %s --cl-options= --cl-device=%cl_device %cfg_path

__kernel void test_fn(__global float16 *src, __global long8 *dst) {
  int tid = get_global_id(0);
  long8 tmp = as_long8(src[tid]);
  dst[tid] = tmp;
}
