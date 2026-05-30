// RUN: %occ-cli %s --cl-options= --cl-device=%cl_device %cfg_path

__kernel void test_fn(__global float *src, __global uint *dst) {
  int tid = get_global_id(0);
  uint3 tmp = as_uint3(vload3(tid, src));
  vstore3(tmp, tid, dst);
}
