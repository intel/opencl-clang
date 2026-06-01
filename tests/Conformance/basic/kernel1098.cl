// RUN: %occ-cli %s --cl-options= --cl-device=%cl_device %cfg_path

__kernel void test_fn(__global int *src, __global float4 *dst) {
  int tid = get_global_id(0);
  float4 tmp = as_float4(vload3(tid, src));
  dst[tid] = tmp;
}
