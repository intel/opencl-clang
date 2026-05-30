// RUN: %occ-cli %s --cl-options= --cl-device=%cl_device %cfg_path

__kernel void test_fn(__global uint4 *src, __global float *dst) {
  int tid = get_global_id(0);
  float3 tmp = as_float3(src[tid]);
  vstore3(tmp, tid, dst);
}
