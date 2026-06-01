// RUN: %occ-cli %s --cl-options= --cl-device=%cl_device %cfg_path

__kernel void test_fn(__global uchar *src, __global char *dst) {
  int tid = get_global_id(0);
  char3 tmp = as_char3(vload3(tid, src));
  vstore3(tmp, tid, dst);
}
