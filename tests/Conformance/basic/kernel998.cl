// RUN: %occ-cli %s --cl-options= --cl-device=%cl_device %cfg_path

__kernel void test_fn(__global short *src, __global ushort *dst) {
  int tid = get_global_id(0);
  ushort3 tmp = as_ushort3(vload3(tid, src));
  vstore3(tmp, tid, dst);
}
