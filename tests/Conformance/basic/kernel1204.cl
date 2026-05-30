// RUN: %occ-cli %s --cl-options= --cl-device=%cl_device %cfg_path

__kernel void test_fn(__global ulong *src, __global long *dst) {
  int tid = get_global_id(0);
  long3 tmp = as_long3(vload3(tid, src));
  vstore3(tmp, tid, dst);
}
