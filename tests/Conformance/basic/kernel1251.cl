// RUN: %occ-cli %s --cl-options= --cl-device=%cl_device %cfg_path

__kernel void test_fn(__global float4 *src, __global uint *dst) {
  int tid = get_global_id(0);
  uint3 tmp = as_uint3(src[tid]);
  vstore3(tmp, tid, dst);
}
