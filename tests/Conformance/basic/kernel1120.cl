// RUN: %occ-cli %s --cl-options= --cl-device=%cl_device %cfg_path

__kernel void test_fn(__global uint *src, __global int *dst) {
  int tid = get_global_id(0);
  int3 tmp = as_int3(vload3(tid, src));
  vstore3(tmp, tid, dst);
}
