// RUN: %occ-cli %s --cl-options= --cl-device=%cl_device %cfg_path

__kernel void test_fn(__global uchar *src, __global char4 *dst) {
  int tid = get_global_id(0);
  char4 tmp = as_char4(vload3(tid, src));
  dst[tid] = tmp;
}
