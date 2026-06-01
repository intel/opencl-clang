// RUN: %occ-cli %s --cl-options= --cl-device=%cl_device %cfg_path

__kernel void test_fn(__global int *src, __global float *dst) {
  int tid = get_global_id(0);
  float3 tmp = as_float3(vload3(tid, src));
  vstore3(tmp, tid, dst);
}
