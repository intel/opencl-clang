// RUN: %occ-cli %s --cl-options= --cl-device=%cl_device %cfg_path

__kernel void test_fn(__global long2 *src, __global float4 *dst) {
  int tid = get_global_id(0);
  float4 tmp = as_float4(src[tid]);
  dst[tid] = tmp;
}
