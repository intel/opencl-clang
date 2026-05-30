// RUN: %occ-cli %s --cl-options= --cl-device=%cl_device %cfg_path

__kernel void test_fn(__global uint4 *src, __global int *dst) {
  int tid = get_global_id(0);
  int3 tmp = as_int3(src[tid]);
  vstore3(tmp, tid, dst);
}
